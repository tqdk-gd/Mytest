import re
from PyQt5.QtWidgets import QTableWidgetItem
from PyQt5.QtWidgets import QMessageBox
import run
from datetime import datetime
from PyQt5.QtCore import QObject, pyqtSignal, QThread

# 工作线程类
class Worker(QObject):
    result_signal = pyqtSignal(str, str)  # 发送运行结果和漏洞判断结果的信号
    error_signal = pyqtSignal(str)  # 发送错误信息的信号
    finished_signal = pyqtSignal()  # 发送任务完成的信号
    show_warning_signal = pyqtSignal(str, str)  # 新增信号，用于在主线程显示警告框

    def __init__(self, lineEdit_4, lineEdit_2, comboBox_3, db,current_proxy):
        super().__init__()
        self.lineEdit_4 = lineEdit_4
        self.lineEdit_2 = lineEdit_2
        self.comboBox_3 = comboBox_3
        self.current_proxy = current_proxy
        self.db = db



    def run(self):
        try:
            file_path = self.lineEdit_4.text()
            # 检查文件路径是否为空
            if not file_path:
                # 发射信号，在主线程显示警告框
                self.show_warning_signal.emit("错误", "文件路径不能为空，请输入有效的文件路径。")
                self.error_signal.emit("文件路径不能为空")
                return
            # 检测文件后缀
            if not file_path.lower().endswith('.txt'):
                # 发射信号，在主线程显示警告框
                self.show_warning_signal.emit("错误", "仅支持读取 .txt 后缀的文件，请重新选择。")
                self.error_signal.emit("仅支持读取 .txt 后缀的文件")
                return
            cmd = self.lineEdit_2.text()  # 获取文本框内容
            payload_name = self.comboBox_3.currentText()

            # 提前查询 payload 地址
            sql_query = f"SELECT payload_address FROM payload where payload_name='{payload_name}'"
            result = self.db.query(sql_query)
            if not result:
                self.error_signal.emit("未找到对应的 payload 地址")
                return
            payload_address = ', '.join(map(str, result[0]))
            with open(file_path, 'r', encoding='utf-8', errors='ignore') as file:
                content = file.readlines()  # 以列表形式读取文件内容
                # 去除每个元素末尾的换行符并存储到新列表中
                urls = [item.strip() for item in content]
                all_results = ''
                for url in urls:
                    result3 = run.test_url_connectivity(url)
                    if not result3["success"]:
                        #self.error_signal.emit('网络检测出错：目标url：'+ url +'，'+result3["error"])
                        self.error_signal.emit('网络检测出错：目标url'+result3["error"])
                        continue

                    # 替换命令中的 -u 参数
                    new_cmd = self._replace_url_in_cmd(cmd, url)

                    # 执行命令并传递代理信息
                    run_result = run.run_command(new_cmd, payload_address, proxy=self.current_proxy)
                    result1_no_newline = run_result.replace("\n", "")
                    all_results += run_result + '\n'
                    match = re.search(r'不存在漏洞', result1_no_newline)
                    # 使用 f-string 优化字符串拼接
                    if not match:
                        result_msg = f"目标 {url} 存在漏洞：{payload_name}"
                    else:
                        result_msg = f"目标 {url} 不存在漏洞：{payload_name}"

                    
                    self.result_signal.emit(result_msg, run_result)

                # self.result_signal.emit("所有扫描结果：\n" + all_results, "")
        except FileNotFoundError:
            self.error_signal.emit("文件未找到。")
        finally:
            self.finished_signal.emit()

    def _replace_url_in_cmd(self, cmd, url):
        first_index = cmd.find('-u')
        if first_index != -1:
            next_index = cmd.find('-', first_index + 2)  # 查找下一个 '-'
            if next_index != -1:
                return cmd[:first_index + 2] + ' ' + url + ' ' + cmd[next_index:]
            else:  # 处理最后一个 '-'
                return cmd[:first_index + 2] + ' ' + url
        return cmd

class PushButton3Event(QObject):
    text_browser_updated = pyqtSignal(str)  # 自定义信号，用于更新文本浏览器内容
    def __init__(self, lineEdit_4, lineEdit_2, comboBox_3, textBrowser_2, tableWidget, db, current_proxy=None):
        super().__init__()
        self.lineEdit_4 = lineEdit_4
        self.lineEdit_2 = lineEdit_2
        self.comboBox_3 = comboBox_3
        self.textBrowser_2 = textBrowser_2
        self.tableWidget = tableWidget
        self.db = db
        self.current_proxy = current_proxy
        self.thread = None
        self.worker = None


    def update_proxy(self, proxy):
        """
        更新代理信息

        :param proxy: QNetworkProxy 类型的代理对象，若为 None 则清除代理设置
        """
        self.current_proxy = proxy

    #批量扫描url
    def read_file_content(self):
        # 创建线程和工作对象
        self.thread = QThread()
        self.worker = Worker(self.lineEdit_4, self.lineEdit_2, self.comboBox_3, self.db, self.current_proxy)
        # 将工作对象移动到线程中
        self.worker.moveToThread(self.thread)

        # 连接信号和槽
        self.textBrowser_2.clear()
        # self.textBrowser_2.setPlainText("运行中...")
        self.thread.started.connect(self.worker.run)
        self.worker.result_signal.connect(self.handle_result)
        self.worker.error_signal.connect(self.handle_error)
        self.worker.finished_signal.connect(self.thread.quit)
        self.worker.finished_signal.connect(self.worker.deleteLater)
        self.thread.finished.connect(self.thread.deleteLater)
        self.worker.show_warning_signal.connect(self.show_warning_message)
        # 启动线程
        self.thread.start()

    def show_warning_message(self, title, message):
        """
        在主线程显示警告框
        """
        QMessageBox.warning(None, title, message)
    def handle_result(self, result_msg, run_result):
        if run_result:
            self.textBrowser_2.append(run_result)
        self.insert_data_to_table("漏洞验证", self.comboBox_3.currentText() + '验证', result_msg)
        self.text_browser_updated.emit(result_msg)

    def handle_error(self, error_msg):
        if error_msg == "文件未找到。":
            msg = QMessageBox()
            msg.setIcon(QMessageBox.Warning)
            msg.setText(error_msg)
            msg.setWindowTitle("错误")
            msg.exec_()
        else:
            # self.textBrowser_2.clear()
            self.textBrowser_2.append(error_msg)
            self.insert_data_to_table(name="漏洞验证", operation=self.comboBox_3.currentText() + '验证', result=error_msg)
            self.text_browser_updated.emit(error_msg)
    #插入表格数据
    def insert_data_to_table(self, name, operation,result):
        current_time = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
        row_position = self.tableWidget.rowCount()
        self.tableWidget.insertRow(row_position)
        
        time_item = QTableWidgetItem(current_time)
        self.tableWidget.setItem(row_position, 0, time_item)
        
        line_item = QTableWidgetItem(name)
        self.tableWidget.setItem(row_position, 1, line_item)

        text_item1 = QTableWidgetItem(operation)
        self.tableWidget.setItem(row_position, 2, text_item1)
        
        text_item = QTableWidgetItem(result)
        self.tableWidget.setItem(row_position, 3, text_item)
