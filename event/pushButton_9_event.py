
from PyQt5.QtCore import QObject, pyqtSignal

class PushButton9Event(QObject):
    text_browser_updated = pyqtSignal(str)  # 自定义信号，用于更新文本浏览器内容
    def __init__(self,lineEdit_5,comboBox_5,tableWidget_4):
        super().__init__()
        self.lineEdit_5 = lineEdit_5
        self.comboBox_5 = comboBox_5
        self.tableWidget_4 = tableWidget_4

    def perform_query(self):
        search_text = self.lineEdit_5.text()  # 获取lineEdit_5中的文本
        class_txt = self.comboBox_5.currentText()# 获取comboBox_5中的文本

        if class_txt == "根据工具名称查询":
            for row in range(self.tableWidget_4.rowCount()):
                item = self.tableWidget_4.item(row, 1)  
                if item is not None and search_text.lower() in item.text().lower():
                    self.tableWidget_4.showRow(row)  # 显示符合条件的行
                else:
                    self.tableWidget_4.hideRow(row)  # 隐藏不符合条件的行
        if class_txt == "根据工具分类查询":
            for row in range(self.tableWidget_4.rowCount()):
                item = self.tableWidget_4.item(row, 0)  # 第三列索引为2
                if item is not None and search_text.lower() in item.text().lower():
                    self.tableWidget_4.showRow(row)  # 显示符合条件的行
                else:
                    self.tableWidget_4.hideRow(row)  # 隐藏不符合条件的行