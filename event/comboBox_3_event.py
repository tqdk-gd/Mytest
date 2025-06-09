from PyQt5 import QtWidgets
import run
from PyQt5.QtCore import QObject, pyqtSignal, QThread, pyqtSlot
# ---------------------- 子线程工作类 ----------------------
class Worker(QObject):
    # 定义信号用于传输结果到主线程
    lineedit_update = pyqtSignal(str)        # 更新 lineEdit_2 的信号
    param_query_result = pyqtSignal(int)     # 参数查询结果的信号
    textbrowser_update = pyqtSignal(str)     # 更新 textBrowser 的信号
    request_payload_sample = pyqtSignal(str, object)  # 新增：用于请求任务
    request_help_query = pyqtSignal(str, object)   # 帮助信息任务信号
    request_payload_param = pyqtSignal(str, object)  # 新增：用于请求任务

    


    @pyqtSlot(str, object)
    def query_payload_sample(self, current_text, db):
        """查询 payload_sample（子线程中执行）"""
        sql_query = f"SELECT payload_sample FROM payload where payload_name='{current_text}'"
        result = db.query(sql_query)
        new_text = "没有该漏洞payload" if not result else ', '.join(map(str, result[0]))
        self.lineedit_update.emit(new_text)  # 发射信号通知主线程更新 UI
    @pyqtSlot(str, object)
    def query_payload_param(self, current_text, db):
        """查询 payload_param（子线程中执行）"""
        sql_query = f"SELECT payload_param FROM payload where payload_name='{current_text}'"
        result = db.query(sql_query)
        selected_index = int(result[0][0]) if result else 0
        self.param_query_result.emit(selected_index)  # 通知主线程参数数量
    @pyqtSlot(str, object)
    def query_help_message(self, current_text, db):
        """查询并生成帮助信息（子线程中执行）"""
        sql_query = f"SELECT payload_address FROM payload where payload_name='{current_text}'"
        result = db.query(sql_query)
        if result and len(result) > 0:
            payload_address = ', '.join(map(str, result[0]))
            help_text = run.help_message(payload_address)
        else:
            help_text = "加载中..."
        self.textbrowser_update.emit(help_text)  # 发送帮助文本到主线程
    
    def __init__(self):
        super().__init__()
        # 将请求信号连接到实际的处理函数
        self.request_help_query.connect(self.query_help_message)      # 新增
        self.request_payload_sample.connect(self.query_payload_sample)# 新增
        self.request_payload_param.connect(self.query_payload_param)  # 新增
    # 新增的方法，用于在主线程中触发子线程的工作

# ---------------------- 主事件类 ----------------------
class ComboBox3Event(QObject):
    text_browser_updated = pyqtSignal(str)
    def __init__(self, comboBox_3, db, lineEdit_2, horizontalLayout_4, textBrowser, lineEdit_3):
        super().__init__()
        # 初始化UI组件和数据库连接
        self.comboBox_3 = comboBox_3
        self.db = db
        self.lineEdit_2 = lineEdit_2
        self.horizontalLayout_4 = horizontalLayout_4
        self.textBrowser = textBrowser
        self.lineEdit_3 = lineEdit_3
        # 创建子线程和 Worker 对象
        self.thread = QThread()
        self.worker = Worker()
        self.worker.moveToThread(self.thread)
        # 连接子线程的信号到主线程的槽
        self.worker.lineedit_update.connect(self._update_lineEdit_2)
        self.worker.param_query_result.connect(self._add_components_by_param)
        self.worker.textbrowser_update.connect(self._update_textBrowser_content)
        self.thread.start()
    # ---- 原 update_lineEdit_2 拆分 ----
    def update_lineEdit_2(self):
        """触发子线程查询 payload_sample"""
        current_text = self.comboBox_3.currentText()
        self.lineEdit_2.clear()
        # 通过信号让子线程工作
        self.worker.request_payload_sample.emit(current_text, self.db)
    @pyqtSlot(str)
    def _update_lineEdit_2(self, new_text):
        """实际更新 lineEdit_2（主线程执行）"""
        self.lineEdit_2.setText(new_text)
    # ---- 原 addComponentsToHorizontalLayout 拆分 ----
    def addComponentsToHorizontalLayout(self):
        """触发子线程查询参数数量"""
        current_text = self.comboBox_3.currentText()
        self.worker.request_payload_param.emit(current_text, self.db)
    @pyqtSlot(int)
    def _add_components_by_param(self, selected_index):
        """根据子线程返回的参数数量添加组件（主线程执行）"""
        # 清空旧组件
        for i in reversed(range(self.horizontalLayout_4.count())):
            widget = self.horizontalLayout_4.itemAt(i).widget()
            if widget: widget.deleteLater()
        # 动态添加新组件
        if selected_index != 0:
            for i in range(selected_index):
                label = QtWidgets.QLabel(f"参数{i+1} : ")
                line_edit = QtWidgets.QLineEdit()
                line_edit.textChanged.connect(self.sync_text)
                self.horizontalLayout_4.addWidget(label)
                self.horizontalLayout_4.addWidget(line_edit)
    # ---- 原 update_textBrowser 拆分 ----
    def update_textBrowser(self):
        """触发子线程生成帮助信息"""
        current_text = self.comboBox_3.currentText()
        self.worker.request_help_query.emit(current_text, self.db)
    @pyqtSlot(str)
    def _update_textBrowser_content(self, help_text):
        """更新 textBrowser（主线程执行）"""
        self.textBrowser.clear()
        self.textBrowser.setPlainText(help_text)
        
    #同步修改lineEdit_3
    def sync_text(self):
        text_2 = self.lineEdit_2.text()
        text_3 = self.lineEdit_3.text()
        text_values_list = []
        text_values_list.append(text_3)

        for i in range(self.horizontalLayout_4.count()):
            item = self.horizontalLayout_4.itemAt(i)
            if isinstance(item.widget(), QtWidgets.QLineEdit):
                text_value = item.widget().text()
                text_values_list.append(text_value)

        # print(text_values_list)
        first_index = text_2.find('-')
        if first_index != -1:
            next_index = text_2.find('-', first_index + 2)  # 查找下一个 '-'
            i = 0
            while next_index != -1:
                str = text_2[first_index+3:next_index-1]
                text_2 = text_2[:first_index + 2] + ' ' + text_values_list[i] + ' ' + text_2[next_index:]
                first_index = next_index - len(str) + len(text_values_list[i])
                next_index = text_2.find('-', first_index + 2)
                # print(next_index)
                i += 1
                # print(i)
            
            # 处理最后一个 '-'
            text_2 = text_2[:first_index + 2] + ' ' + text_values_list[i]
        self.lineEdit_2.setText(text_2)