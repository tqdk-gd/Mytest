import sys
from PyQt5.QtWidgets import QTextEdit, QApplication
from PyQt5.QtCore import Qt, QProcess, QTextStream, pyqtSignal
from PyQt5.QtGui import QTextCursor, QTextCharFormat, QColor
from PyQt5.QtNetwork import QNetworkProxy

# from untitled import Ui_MainWindow

class CommandTerminal(QTextEdit):
    command_executed = pyqtSignal(str)  # 命令执行完成信号

    def __init__(self, parent=None, proxy=None):  # 新增 proxy 参数
        super().__init__(parent)
        self.init_ui()
        self.history = []       # 命令历史记录
        self.history_index = 0  # 当前历史记录位置
        self.process = QProcess()  # 初始化 QProcess 实例
        self.proxy = proxy  # 保存代理信息
        

    def init_ui(self):
        # 设置终端样式
        self.setStyleSheet("""
            QTextEdit {
                background-color: black;
                color: white;
                font-family: Consolas;
                font-size: 12pt;
            }
        """)
        self.setVerticalScrollBarPolicy(Qt.ScrollBarAlwaysOn)
        self.append_prompt()

    def update_proxy(self, proxy):
        """
        设置代理信息

        :param proxy: QNetworkProxy 类型的代理对象，若为 None 则清除代理设置
        """
        self.proxy = proxy

    def append_prompt(self):
        # 获取当前文本内容
        text = self.toPlainText()
        # 检查文本末尾是否已经存在提示符，并且确保在输出内容后换行插入
        if not text.endswith("\n> ") and not text.endswith("> "):
            # 添加绿色提示符
            fmt = QTextCharFormat()
            fmt.setForeground(QColor(0, 255, 0))  # 绿色
            self.moveCursor(QTextCursor.End)      # 移动光标到末尾
            if text:  # 如果已有内容，先插入换行符
                self.insertPlainText("\n")
            self.setCurrentCharFormat(fmt)
            self.insertPlainText("> ")
            self.moveCursor(QTextCursor.EndOfLine)  # 移动到当前行的末尾
            self.prompt_pos = self.textCursor().position()  # 记录提示符结束位置

    def keyPressEvent(self, event):
        # 检测 Ctrl+C 组合键
        if event.modifiers() == Qt.ControlModifier and event.key() == Qt.Key_C:
            if self.process.state() == QProcess.Running:
                # 尝试终止进程
                self.process.terminate()
                if not self.process.waitForFinished(3000):
                    # 若终止失败，强制杀死进程
                    self.process.kill()
                self.append_output("\nProcess terminated by Ctrl+C", QColor(255, 0, 0))
                self.append_prompt()
            return
        # 禁止修改提示符之前的区域
        cursor = self.textCursor()
        text_length = self.document().characterCount()
        if self.prompt_pos < text_length:  # 检查位置是否有效
            if cursor.position() < self.prompt_pos:
                cursor.setPosition(self.prompt_pos)
                self.setTextCursor(cursor)
        else:
            self.prompt_pos = text_length - 1  # 修正位置

        # 回车执行命令
        if event.key() in [Qt.Key_Enter, Qt.Key_Return]:
            self.execute_command()
            return

        # 上下键浏览历史
        if event.key() == Qt.Key_Up:
            self.navigate_history(-1)
            return
        elif event.key() == Qt.Key_Down:
            self.navigate_history(1)
            return

        super().keyPressEvent(event)

    #从外部获取命令
    def load_external_commands(self, cmd): 
        if not cmd:
            self.append_prompt()
            return

        # 保存到历史记录
        self.history.append(cmd)
        self.history_index = len(self.history)

        # 执行系统命令
        self.process.readyReadStandardOutput.connect(self.read_output)
        self.process.readyReadStandardError.connect(self.read_error)
        self.process.finished.connect(self.command_finished)
        self.start_process(cmd)
    def execute_command(self):
        # 获取命令文本
        cursor = self.textCursor()
        cursor.setPosition(self.prompt_pos)
        cursor.movePosition(QTextCursor.End, QTextCursor.KeepAnchor)
        cmd = cursor.selectedText().strip()
        
        if not cmd:
            self.append_prompt()
            return

        # 保存到历史记录
        self.history.append(cmd)
        self.history_index = len(self.history)

        # 执行系统命令
        self.process.readyReadStandardOutput.connect(self.read_output)
        self.process.readyReadStandardError.connect(self.read_error)
        self.process.finished.connect(self.command_finished)
        self.start_process(cmd)
    def start_process(self, cmd):
        # 检查进程是否正在运行，若运行则终止
        if self.process.state() == QProcess.Running:
            self.process.terminate()
            if not self.process.waitForFinished(3000):  # 等待 3 秒
                self.process.kill()  # 3 秒后未结束则强制杀死
            self.append_output("\nPrevious process terminated to start a new one", QColor(255, 0, 0))
        env = QProcess.systemEnvironment()  # 获取系统环境变量
        if self.proxy:
            if self.proxy.type() == QNetworkProxy.HttpProxy:
                proxy_url = f"http://{self.proxy.hostName()}:{self.proxy.port()}"
                env.append(f"HTTP_PROXY={proxy_url}")
                env.append(f"HTTPS_PROXY={proxy_url}")
            elif self.proxy.type() == QNetworkProxy.Socks5Proxy:
                proxy_url = f"socks5://{self.proxy.hostName()}:{self.proxy.port()}"
                env.append(f"HTTP_PROXY={proxy_url}")
                env.append(f"HTTPS_PROXY={proxy_url}")
        from PyQt5.QtCore import QProcessEnvironment
        process_env = QProcessEnvironment.systemEnvironment()
        for var in env:
            if '=' in var:
                key, value = var.split('=', 1)
                process_env.insert(key, value)
        self.process.setProcessEnvironment(process_env)


        if QApplication.instance().platformName() == 'windows':
            self.process.start('cmd', ['/C', cmd])
        else:
            self.process.start('bash', ['-c', cmd])

    def read_output(self):
        data = self.process.readAllStandardOutput().data()
        try:
            # 强制使用 gbk 编码解码
            text = data.decode('gbk', errors='replace')
        except UnicodeDecodeError:
            # 如果解码失败，尝试使用默认系统编码
            import locale
            default_encoding = locale.getpreferredencoding()
            text = data.decode(default_encoding, errors='replace')
        self.append_output(text, QColor(255, 255, 255))

    def read_error(self):
        data = self.process.readAllStandardError().data()
        try:
            # 强制使用 gbk 编码解码
            text = data.decode('gbk', errors='replace')
        except UnicodeDecodeError:
            import locale
            default_encoding = locale.getpreferredencoding()
            text = data.decode(default_encoding, errors='replace')
        self.append_output(text, QColor(255, 0, 0))

    def append_output(self, text, color):
        # 添加带颜色的输出
        fmt = QTextCharFormat()
        fmt.setForeground(color)
        cursor = self.textCursor()
        cursor.movePosition(QTextCursor.End)
        cursor.setCharFormat(fmt)
         # 确保输出前有换行
        if cursor.position() > 0:
            cursor.insertText("\n")
        cursor.insertText(text)
        self.ensureCursorVisible()

    def command_finished(self):
        # 命令执行完成
        self.append_prompt()
        self.command_executed.emit("Command completed")

    def clear_output(self):
        """清空终端并重置提示符"""
        self.clear()          # 清空所有内容
        self.append_prompt()  # 重新添加初始提示符
    def navigate_history(self, delta):
        # 历史记录导航
        if not self.history:
            return


        new_index = self.history_index + delta
        if 0 <= new_index < len(self.history):
            self.history_index = new_index
            # 替换当前命令
            cursor = self.textCursor()
            cursor.setPosition(self.prompt_pos)
            cursor.movePosition(QTextCursor.End, QTextCursor.KeepAnchor)
            cursor.removeSelectedText()
            cursor.insertText(self.history[self.history_index])

# class MainWindow(Ui_MainWindow):

#     def __init__(self):
#         super().__init__()
#         self.terminal = CommandTerminal()
#         self.setCentralWidget(self.terminal)
#         self.terminal.command_executed.connect(self.on_command_finish)

#     def on_command_finish(self, msg):
#         print("命令执行完成:", msg)

# if __name__ == "__main__":
#     import sys
#     app = QApplication(sys.argv)
#     terminal = CommandTerminal()
#     terminal.resize(800, 600)
#     terminal.show()
#     sys.exit(app.exec_())