from PyQt5.QtWidgets import QTableWidgetItem
from PyQt5.QtCore import QObject, pyqtSignal
import run
from datetime import datetime
import re


class RunBtnEvent(QObject):
    text_browser_updated = pyqtSignal(str)  # 自定义信号，用于更新文本浏览器内容
    def __init__(self,cmd_input,terminal,tableWidget,db):
        super().__init__()
        self.cmd_input = cmd_input
        self.terminal = terminal
        self.tableWidget = tableWidget
        self.db = db
        # self.tool_name = tool_name


    def update_textBrowser_2(self,tool_name):
        cmd1 = self.cmd_input.text()
        cmd = " ".join(cmd1.split()[1:])
        # print(cmd)
        #result = self.ui.result_output
        # tool_name = self.tool_name
        sql_query = f"SELECT tool_address,tool_cmd FROM tool where tool_name='{tool_name}'"
        result = self.db.query(sql_query)
        
        if result and len(result) > 0:
            for tool_address,tool_cmd in result:
                if tool_cmd == 'exec' or tool_cmd == 'sh':
                    self.terminal.load_external_commands(tool_address + " " + cmd)
                    self.insert_data_to_table(name='外部工具',operation=tool_cmd + " " + tool_address + " " + cmd,result="运行成功")
                    break
                else :
                    self.terminal.load_external_commands(tool_cmd + " " + tool_address + " " + cmd)
                    self.insert_data_to_table(name='外部工具',operation=tool_cmd + " " + tool_address + " " + cmd,result="运行成功")
                    break
                
        else:
            self.insert_data_to_table(name='外部工具',operation=cmd1,result="运行失败")
        # self.terminal.clear_output()

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
