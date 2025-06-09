from PyQt5.QtWidgets import QTableWidgetItem
from PyQt5.QtCore import QObject, pyqtSignal, QThread
import run
from datetime import datetime
import re
from PyQt5.QtWidgets import QMessageBox
class Worker(QObject):
    result_signal = pyqtSignal(dict)  # 发送运行结果的信号
    error_signal = pyqtSignal(str)  # 发送错误信息的信号
    finished_signal = pyqtSignal()  # 发送任务完成的信号
    show_warning_signal = pyqtSignal(str, str)

    def __init__(self, lineEdit_2, lineEdit_3, comboBox_3, db,current_proxy=None):
        super().__init__()
        self.lineEdit_2 = lineEdit_2
        self.lineEdit_3 = lineEdit_3
        self.comboBox_3 = comboBox_3
        self.db = db
        self.current_proxy = current_proxy

    def run(self):
        try:
            cmd = self.lineEdit_2.text()
            url = self.lineEdit_3.text()
            
            if not url:
                # 发射信号，在主线程显示警告框
                self.show_warning_signal.emit("错误", "URL 不能为空，请输入有效的 URL。")
                self.error_signal.emit("URL 不能为空")
                return
            payload_name = self.comboBox_3.currentText()
            result3 = run.test_url_connectivity(url)

            if not result3["success"]:
                self.error_signal.emit(result3["error"])
                return

            payload_address = ''
            sql_query = f"SELECT payload_address FROM payload where payload_name='{payload_name}'"
            result = self.db.query(sql_query)
            if result and len(result) > 0:
                for row in result:
                    payload_address = ', '.join(map(str, row))
                    break

            result1 = run.run_command(cmd, payload_address,proxy=self.current_proxy)
            result1_no_newline = result1.replace("\n", "")
            # print(result1)
            match = re.search(r'不存在漏洞', result1)
            # 使用 f-string 优化字符串拼接
            if not match:
                result2 = f"目标 {url} 存在漏洞：{payload_name}"
            else:
                result2 = f"目标 {url} 不存在漏洞：{payload_name}"

            result_data = {
                "result1_no_newline": result1_no_newline,
                "payload_name": payload_name,
                "result2": result2
            }
            self.result_signal.emit(result_data)
        except Exception as e:
            self.error_signal.emit(str(e))
        finally:
            self.finished_signal.emit()

class PushButtonEvent(QObject):
    text_browser_updated = pyqtSignal(str)  # 自定义信号，用于更新文本浏览器内容
    def __init__(self,lineEdit_2,lineEdit_3,comboBox_3,textBrowser_2,tableWidget,db,current_proxy=None):
        super().__init__()
        self.lineEdit_2 = lineEdit_2
        self.lineEdit_3 = lineEdit_3
        self.textBrowser_2 = textBrowser_2
        self.comboBox_3 = comboBox_3
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


    # # 点击按钮‘开始运行’传送参数和地址来运行对应payload

    # def run_payload(self):
    #     self.update_textBrowser_2()
    #     self.save_to_excel()
    #     self.update_textBrowser_2()
    #     self.clear_input_fields()
    #点击按钮‘开始运行’传送参数和地址来运行对应payload
    def update_textBrowser_2(self):
        # 创建线程和工作对象
        self.thread = QThread()
        self.worker = Worker(self.lineEdit_2, self.lineEdit_3, self.comboBox_3, self.db,self.current_proxy)
        # 将工作对象移动到线程中
        self.worker.moveToThread(self.thread)

        # 连接信号和槽
        self.textBrowser_2.clear()
        self.textBrowser_2.setPlainText("运行中...")
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

    def handle_result(self, result_data):
        self.insert_data_to_table(
            name="漏洞验证",
            operation=result_data["payload_name"] + '验证',
            result=result_data["result2"]
        )
        self.textBrowser_2.clear()
        self.textBrowser_2.setPlainText(result_data["result1_no_newline"])

    def handle_error(self, error_msg):
        self.textBrowser_2.clear()
        self.textBrowser_2.setPlainText(error_msg)
        self.insert_data_to_table(name="漏洞验证", operation="验证失败", result=error_msg)

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

    # def button_clicked_handler(self):
    #     self.update_textBrowser_2()  # 调用更新文本浏览器内容的方法