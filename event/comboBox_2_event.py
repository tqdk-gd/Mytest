from PyQt5.QtCore import QObject, pyqtSignal


class ComboBox2Event(QObject):
    text_browser_updated = pyqtSignal(str)  # 自定义信号，用于更新文本浏览器内容
    def __init__(self,comboBox_2,db,listWidget):
        super().__init__()
        self.comboBox_2 = comboBox_2
        self.db = db
        self.listWidget = listWidget

    # 获取下拉框comboBox_2内容生成listWidget内容
    def update_list_widget(self):
        current_text = self.comboBox_2.currentText()
        # print("ComboBox_2 内容:", current_text)
        sql_query = ""
        sql_query = f"SELECT app.app_name FROM web_app,app where web_app.class_name='{current_text}' and web_app.web_id = app.class_id"
        result = self.db.query(sql_query)
        # print(result)
        if result is not None:
            self.listWidget.clear()
            for row in result:
                item_text = ', '.join(map(str, row))  # 将结果行转换为字符串
                self.listWidget.addItem(item_text)