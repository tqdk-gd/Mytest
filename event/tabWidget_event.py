import os
import openai
from PyQt5.QtCore import QObject, pyqtSignal
from PyQt5 import QtCore,QtWidgets

class TabWidgetEvent(QObject):
    text_browser_updated = pyqtSignal(str)  # 自定义信号，用于更新文本浏览器内容
    def __init__(self,tableWidget_3,tableWidget_4,db):
        super().__init__()
        self.tableWidget_3 = tableWidget_3
        self.tableWidget_4 = tableWidget_4
        self.db = db

    def on_tab_clicked(self, index):
        if index == 3:  
            # print("Tab 3 Clicked!")
            # 在这里可以添加你想要执行的操作
            sql_query = '''SELECT web_app.class_name,app.app_name,payload.payload_name,payload.payload_address,payload.payload_dangerous,payload.payload_repair
                        FROM payload
                        JOIN app ON payload.app_id = app.app_id
                        JOIN web_app ON app.class_id = web_app.web_id;'''
            result = self.db.query(sql_query)
            if result is not None:
                # 清空tableWidget并添加新选项
                self.tableWidget_3.setRowCount(0)
                for row in result:
                    row_count = self.tableWidget_3.rowCount()
                    self.tableWidget_3.insertRow(row_count)
                    for col, value in enumerate(row):
                        item = QtWidgets.QTableWidgetItem(str(value))
                        self.tableWidget_3.setItem(row_count, col, item)
        elif index == 4:
            # print("Tab 3 Clicked!")
            # 在这里可以添加你想要执行的操作
            sql_query = '''SELECT tool_class.class_name,tool.tool_name,tool.tool_address,tool.tool_cmd,tool_description
                        FROM tool
                        JOIN tool_class ON tool.class_id = tool_class.class_id;'''
            result = self.db.query(sql_query)
            if result is not None:
                # 清空tableWidget并添加新选项
                self.tableWidget_4.setRowCount(0)
                for row in result:
                    row_count = self.tableWidget_4.rowCount()
                    self.tableWidget_4.insertRow(row_count)
                    for col, value in enumerate(row):
                        item = QtWidgets.QTableWidgetItem(str(value))
                        self.tableWidget_4.setItem(row_count, col, item)

    # def on_tab_clicked_1(self, index): 
            