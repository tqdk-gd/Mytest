from PyQt5.QtCore import QObject, pyqtSignal

class ListWidgetEvent(QObject):

    text_browser_updated = pyqtSignal(str)  # 自定义信号，用于更新文本浏览器内容
    def __init__(self,comboBox_3,db):
        super().__init__()
        self.comboBox_3 = comboBox_3
        self.db = db
    
    #通过获取listWidget内容来更新ComboBox_3内容
    def on_item_clicked(self, item):
        text = item.text()
        selected_option = text.split(',')[0]  # 假设第一个元素为选项

        # 查询数据库以获取动态内容
        sql_query = f"SELECT payload.payload_name FROM app,payload WHERE app.app_name = '{selected_option}' and app.app_id=payload.app_id"
        result = self.db.query(sql_query)

        if result is not None:
            # 清空combobox并添加新选项
            self.comboBox_3.clear()
            # self.comboBox_3.addItem('ALL')
            for row in result:
                item_text = ', '.join(map(str, row))
                self.comboBox_3.addItem(item_text)

    