
from PyQt5.QtCore import QObject, pyqtSignal

class PushButton6Event(QObject):
    text_browser_updated = pyqtSignal(str)  # 自定义信号，用于更新文本浏览器内容
    def __init__(self,lineEdit,comboBox_4,tableWidget_3):
        super().__init__()
        self.lineEdit = lineEdit
        self.comboBox_4 = comboBox_4
        self.tableWidget_3 = tableWidget_3

    def perform_query(self):
        search_text = self.lineEdit.text()  # 获取lineEdit中的文本
        class_txt = self.comboBox_4.currentText()# 获取comboBox_4中的文本

        if class_txt == "根据漏洞名称查询":
            for row in range(self.tableWidget_3.rowCount()):
                item = self.tableWidget_3.item(row, 2)  # 第三列索引为2
                if item is not None and search_text.lower() in item.text().lower():
                    self.tableWidget_3.showRow(row)  # 显示符合条件的行
                else:
                    self.tableWidget_3.hideRow(row)  # 隐藏不符合条件的行
        if class_txt == "根据所属分类查询":
            for row in range(self.tableWidget_3.rowCount()):
                item = self.tableWidget_3.item(row, 0)  # 第二列索引为1
                if item is not None and search_text.lower() in item.text().lower():
                    self.tableWidget_3.showRow(row)  # 显示符合条件的行
                else:
                    self.tableWidget_3.hideRow(row)  # 隐藏不符合条件的行
        if class_txt == "根据所属应用查询":
            for row in range(self.tableWidget_3.rowCount()):
                item = self.tableWidget_3.item(row, 1)  # 第一列索引为0
                if item is not None and search_text.lower() in item.text().lower():
                    self.tableWidget_3.showRow(row)  # 显示符合条件的行
                else:
                    self.tableWidget_3.hideRow(row)  # 隐藏不符合条件的行
