from PyQt5.QtCore import QObject, pyqtSignal
from PyQt5.QtWidgets import QDialog, QLabel, QLineEdit, QComboBox, QPushButton, QFileDialog, QVBoxLayout, QMessageBox

class PushButton8Event(QObject):
    text_browser_updated = pyqtSignal(str)  # 自定义信号，用于更新文本浏览器内容
    table_refresh_signal = pyqtSignal()  # 自定义信号，用于刷新表格
    def __init__(self,db,tableWidget_3):
        super().__init__()
        self.db = db
        self.tableWidget_3 = tableWidget_3

    def modify_data(self):
        selected_row = self.tableWidget_3.currentRow()
        if selected_row != -1:
            item = self.tableWidget_3.item(selected_row, 2)  # 获取所选行的第三列项目
            item1 = self.tableWidget_3.item(selected_row, 1)  # 获取所选行的第二列项目
            if item is not None:
                current_content = item.text()
                current_content1 = item1.text()
            # 创建弹出窗口并显示当前内容
                dialog = QDialog()
                # 设置对话框的大小，这里宽设为 400，高设为 400，可按需调整
                dialog.resize(800, 400)
                dialog.setWindowTitle("修改payload: " + current_content)

                sql_query = "SELECT payload_name,payload_address,payload_sample, payload_param, payload_dangerous,payload_repair FROM payload WHERE payload_name = %s"
                values = (current_content,)
                result = self.db.query(sql_query, values)

                app_label = QLabel("所属类别:", dialog)
                app_combobox = QComboBox(dialog)
                sql_query = "SELECT app_name FROM app"
                result1 = self.db.query(sql_query)
                app_names = [row[0] for row in result1]
                app_names.insert(0, current_content1)  # 在列表开头插入一个空字符串
                app_combobox.addItems(app_names)


                payload_name_label = QLabel("漏洞名称:", dialog)
                payload_name_input = QLineEdit(dialog)
                payload_name_input.setText(current_content)

                payload_address_label = QLabel("payload文件地址:", dialog)
                payload_address_textbox = QLineEdit(dialog)  # 创建一个文本框用于显示地址
                payload_address_textbox.setText(result[0][1])
                payload_address_button = QPushButton("选择文件", dialog)
                payload_address_button.clicked.connect(lambda: self.get_file_path(dialog, payload_address_textbox))

                payload_sample_lable = QLabel("命令提示", dialog)
                payload_sample_input = QLineEdit(dialog)
                payload_sample_input.setText(result[0][2])

                payload_param_lable = QLabel("命令除url外所需参数个数", dialog)
                payload_param_input = QLineEdit(dialog)
                payload_param_input.setText(str(result[0][3]))
                
                payload_dangerous_lable = QLabel("危险程度", dialog)
                payload_dangerous_input = QLineEdit(dialog)
                payload_dangerous_input.setText(result[0][4])

                payload_repair_lable = QLabel("修复建议", dialog)
                payload_repair_input = QLineEdit(dialog)
                payload_repair_input.setText(result[0][5])


                # 确定按钮
                ok_button = QPushButton("确定", dialog)
                ok_button.clicked.connect(lambda: self.update_data(dialog,payload_name_input.text(), payload_address_textbox.text(), app_combobox.currentText(),payload_sample_input.text(),payload_param_input.text(),payload_dangerous_input.text(),selected_row,payload_repair_input.text(),current_content))

                # 取消按钮
                cancel_button = QPushButton("取消", dialog)
                cancel_button.clicked.connect(dialog.reject)
                
                layout = QVBoxLayout()
                layout.addWidget(payload_name_label)
                layout.addWidget(payload_name_input)
                layout.addWidget(payload_address_label)
                layout.addWidget(payload_address_textbox)
                layout.addWidget(payload_address_button)
                layout.addWidget(app_label)
                layout.addWidget(app_combobox)
                layout.addWidget(payload_sample_lable)
                layout.addWidget(payload_sample_input)
                layout.addWidget(payload_param_lable)
                layout.addWidget(payload_param_input)
                layout.addWidget(payload_dangerous_lable)
                layout.addWidget(payload_dangerous_input)
                layout.addWidget(payload_repair_lable)
                layout.addWidget(payload_repair_input)
                layout.addWidget(ok_button)
                layout.addWidget(cancel_button)
                
                dialog.setLayout(layout)
                dialog.exec_()
        else:
                QMessageBox.warning(self, "警告", "请先选择要修改的行")
                

    def update_data(self,dialog,payload_name,payload_address,payload_app,payload_sample,payload_param,payload_dangerous,selected_row,payload_repair,current_content):
        # 在这里执行插入数据到数据库的操作
        # 例如连接数据库，执行 INSERT 查询等
        sql_query = f"SELECT payload_name FROM payload WHERE payload_name = '{payload_name}' AND payload_name != '{current_content}'"
        result = self.db.query(sql_query)
        if result:
            QMessageBox.warning(dialog, "警告", "该payload名称已存在，请重新输入！")
            return
        sql_query = "SELECT app_id FROM app WHERE app_name = %s"
        values = (payload_app,)
        result = self.db.query(sql_query, values)
        if result:
            payload_app = result[0][0]
        else:
            # 处理没有查询到结果的情况
            QMessageBox.warning(dialog, "警告", "未找到对应的 app_id，请检查所属类别。")
            return
        payload_address = payload_address.replace("\\", "/")
        sql_query = "UPDATE payload SET payload_name = %s, payload_address = %s, app_id = %s, payload_sample = %s, payload_param = %s, payload_dangerous = %s, payload_repair = %s WHERE payload_name = %s"
        values = (payload_name,payload_address,payload_app,payload_sample,payload_param,payload_dangerous,payload_repair,current_content)
        self.db.query(sql_query, values)
        self.db.commit()
        QMessageBox.information(dialog, "成功", "数据修改成功")
        dialog.close()
        # 发射信号刷新表格
        self.table_refresh_signal.emit()
        
        

    def get_file_path(self, dialog, address_textbox):
        file_dialog = QFileDialog()
        file_path, _ = file_dialog.getOpenFileName(dialog, "选择文件", "", "All Files (*)")

        if file_path:
        # 将 \ 替换为 /
            file_path = file_path.replace("\\", "/")
            address_textbox.setText(file_path)  # 更新地址文本框的内容