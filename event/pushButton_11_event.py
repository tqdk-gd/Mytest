from PyQt5.QtCore import QObject, pyqtSignal
from PyQt5.QtWidgets import QDialog, QLabel, QLineEdit, QComboBox, QPushButton, QFileDialog, QVBoxLayout, QMessageBox

class PushButton11Event(QObject):
    text_browser_updated = pyqtSignal(str)  # 自定义信号，用于更新文本浏览器内容
    table_refresh_signal = pyqtSignal()  # 自定义信号，用于刷新表格
    def __init__(self,db,tableWidget_4):
        super().__init__()
        self.db = db
        self.tableWidget_4 = tableWidget_4

    def modify_data(self):
        selected_row = self.tableWidget_4.currentRow()
        if selected_row != -1:
            item = self.tableWidget_4.item(selected_row, 1)  # 获取所选行的第三列项目
            item1 = self.tableWidget_4.item(selected_row, 0)  # 获取所选行的第二列项目
            if item is not None:
                current_content = item.text()
                current_content1 = item1.text()
                # 创建弹出窗口并显示当前内容
                dialog = QDialog()
                # 设置对话框的大小，这里宽设为 400，高设为 400，可按需调整
                dialog.resize(800, 400)
                dialog.setWindowTitle("修改外部工具: " + current_content)

                sql_query = "SELECT tool_name,tool_address,tool_sample,tool_cmd,tool_description FROM tool WHERE tool_name = %s"
                values = (current_content,)
                result = self.db.query(sql_query, values)

                app_label = QLabel("所属类别:", dialog)
                app_combobox = QComboBox(dialog)
                sql_query = "SELECT class_name FROM tool_class"
                result1 = self.db.query(sql_query)
                app_names = [row[0] for row in result1]
                app_names.insert(0, current_content1)  # 在列表开头插入一个空字符串
                app_combobox.addItems(app_names)


                tool_name_label = QLabel("工具名称:", dialog)
                tool_name_input = QLineEdit(dialog)
                tool_name_input.setText(current_content)

                tool_address_label = QLabel("外部工具地址:", dialog)
                tool_address_textbox = QLineEdit(dialog)  # 创建一个文本框用于显示地址
                tool_address_textbox.setText(result[0][1])
                tool_address_button = QPushButton("选择文件", dialog)
                tool_address_button.clicked.connect(lambda: self.get_file_path(dialog, tool_address_textbox))

                tool_sample_lable = QLabel("命令提示", dialog)
                tool_sample_input = QLineEdit(dialog)
                tool_sample_input.setText(result[0][2])

                tool_cmd_label = QLabel("执行工具命令:", dialog)
                tool_cmd_textbox = QLineEdit(dialog)  # 创建一个文本框用于显示地址
                tool_cmd_textbox.setText(result[0][3])
                tool_cmd_button = QPushButton("选择文件", dialog)
                tool_cmd_button.clicked.connect(lambda: self.get_file_path(dialog, tool_cmd_textbox))

                tool_description_lable = QLabel("说明", dialog)
                tool_description_input = QLineEdit(dialog)
                tool_description_input.setText(result[0][4])

                # 确定按钮
                ok_button = QPushButton("确定", dialog)
                ok_button.clicked.connect(lambda: self.update_data(dialog,current_content,tool_name_input.text(), tool_address_textbox.text(), app_combobox.currentText(),tool_sample_input.text(),tool_cmd_textbox.text(),tool_description_input.text()))

                # 取消按钮
                cancel_button = QPushButton("取消", dialog)
                cancel_button.clicked.connect(dialog.reject)
                
                layout = QVBoxLayout()
                layout.addWidget(tool_name_label)
                layout.addWidget(tool_name_input)
                layout.addWidget(tool_address_label)
                layout.addWidget(tool_address_textbox)
                layout.addWidget(tool_address_button)
                layout.addWidget(app_label)
                layout.addWidget(app_combobox)
                layout.addWidget(tool_sample_lable)
                layout.addWidget(tool_sample_input)
                layout.addWidget(tool_cmd_label)
                layout.addWidget(tool_cmd_textbox)
                layout.addWidget(tool_cmd_button)
                layout.addWidget(tool_description_lable)
                layout.addWidget(tool_description_input)
                layout.addWidget(ok_button)
                layout.addWidget(cancel_button)
                
                dialog.setLayout(layout)
                dialog.exec_()
        else:
                QMessageBox.warning(self, "警告", "请先选择要修改的行")

    def update_data(self,dialog,current_content,tool_name,tool_address,class_name,tool_sample,tool_cmd,tool_description):
        # 在这里执行插入数据到数据库的操作
        # 例如连接数据库，执行 INSERT 查询等
        sql_query = f"SELECT tool_name FROM tool WHERE tool_name = '{tool_name}'AND tool_name != '{current_content}'"
        result = self.db.query(sql_query)
        if result:
            QMessageBox.warning(dialog, "警告", "该工具名称已存在，请重新输入！")
            return
        sql_query = "SELECT class_id FROM tool_class WHERE class_name = %s"
        values = (class_name,)
        result = self.db.query(sql_query, values)
        class_name = result[0][0]
        sql_query = "UPDATE tool SET tool_name = %s, tool_address = %s, class_id = %s, tool_sample = %s, tool_cmd = %s ,tool_description = %s WHERE tool_name = %s"
        values = (tool_name,tool_address,class_name,tool_sample,tool_cmd,tool_description,current_content)
        self.db.query(sql_query, values)
        self.db.commit()
        QMessageBox.information(dialog, "成功", "数据修改成功")
        dialog.close()
        # 发射信号刷新表格
        self.table_refresh_signal.emit()

                


        

    def get_file_path(self, dialog, address_textbox):
        file_dialog = QFileDialog()
        file_path, _ = file_dialog.getOpenFileName(dialog, "选择文件", "", "All Files (*)")
        address_textbox.setText(file_path)

        # if file_path:
        # # 将 \ 替换为 /
        #     file_path = file_path.replace("\\", "/")
        #     address_textbox.setText(file_path)  # 更新地址文本框的内容