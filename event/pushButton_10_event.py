from PyQt5.QtCore import QObject, pyqtSignal
from PyQt5.QtWidgets import QDialog, QLabel, QLineEdit, QComboBox, QPushButton, QFileDialog, QVBoxLayout, QMessageBox

class PushButton10Event(QObject):
    text_browser_updated = pyqtSignal(str)  # 自定义信号，用于更新文本浏览器内容
    table_refresh_signal = pyqtSignal()  # 自定义信号，用于刷新表格
    def __init__(self,db):
        super().__init__()
        self.db = db

    def open_insert_dialog(self):
        dialog = QDialog()
        dialog.setWindowTitle("添加新外部工具")
        # 设置对话框的大小，这里宽设为 400，高设为 400，可按需调整
        dialog.resize(800, 400)

        tool_name_label = QLabel("工具名称:", dialog)
        tool_name_input = QLineEdit(dialog)

        tool_address_label = QLabel("外部工具地址:", dialog)
        tool_address_textbox = QLineEdit(dialog)  # 创建一个文本框用于显示地址
        tool_address_button = QPushButton("选择文件", dialog)
        tool_address_button.clicked.connect(lambda: self.get_file_path(dialog, tool_address_textbox))

        app_label = QLabel("所属类别:", dialog)
        app_combobox = QComboBox(dialog)
        sql_query = "SELECT class_name FROM tool_class"
        result = self.db.query(sql_query)
        app_names = [row[0] for row in result]
        app_names.insert(0, "")  # 在列表开头插入一个空字符串
        app_combobox.addItems(app_names)

        tool_sample_lable = QLabel("命令提示", dialog)
        tool_sample_input = QLineEdit(dialog)
        tool_sample_input.setPlaceholderText("请输入命令提示比如：sqlmap -u http://example.com:9090")

        tool_cmd_label = QLabel("执行工具命令:", dialog)
        tool_cmd_textbox = QLineEdit(dialog)  # 创建一个文本框用于显示地址
        tool_cmd_textbox.setPlaceholderText("如果执行命令不在环境变量中，选择执行工具命令文件地址")
        tool_cmd_button = QPushButton("选择文件", dialog)
        tool_cmd_button.clicked.connect(lambda: self.get_file_path(dialog, tool_cmd_textbox))

        tool_description_lable = QLabel("说明", dialog)
        tool_description_input = QLineEdit(dialog)
        tool_description_input.setPlaceholderText("请输入工具说明比如：sqlmap 是一款开源的自动化 SQL 注入工具，用于检测和利用数据库中的 SQL 注入漏洞。它支持多种数据库系统（如 MySQL、Oracle、PostgreSQL 等），能够自动识别漏洞并执行攻击，获取敏感数据或完全控制目标系统。")

        # 确定按钮
        ok_button = QPushButton("确定", dialog)
        ok_button.clicked.connect(lambda: self.insert_data(dialog,tool_name_input.text(), tool_address_textbox.text(), app_combobox.currentText(),tool_sample_input.text(),tool_cmd_textbox.text(),tool_description_input.text()))


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

    def get_file_path(self, dialog, address_textbox):
        file_dialog = QFileDialog()
        file_path, _ = file_dialog.getOpenFileName(dialog, "选择文件", "", "All Files (*)")
        address_textbox.setText(file_path)

        # if file_path:
        # # 将 \ 替换为 /
        #     file_path = file_path.replace("\\", "/")
        #     address_textbox.setText(file_path)  # 更新地址文本框的内容

    def insert_data(self,dialog,tool_name, tool_address, app_name,tool_sample,tool_cmd,tool_description):
        # 在这里执行插入数据到数据库的操作
        # 例如连接数据库，执行 INSERT 查询等
        # 插入数据到数据库
        sql_query = f"SELECT tool_name FROM tool WHERE tool_name = '{tool_name}'"
        result = self.db.query(sql_query)
        # 直接检查结果是否非空
        if result:
            QMessageBox.warning(dialog, "警告", "该tool名称已存在，请重新输入！")
            return
        #插入时还有一个id值
        # 获取当前最大的id值
        sql_query = "SELECT MAX(tool_id) FROM tool"
        result = self.db.query(sql_query)
        # 直接获取结果中的值
        max_id = result[0][0] if result and result[0][0] is not None else 0
        # 插入新数据
        new_id = max_id + 1
        # 入payload数据
        # 插入数据到数据库
        tool_address = tool_address.replace("\\", "/")
        sql_query = "INSERT INTO tool (tool_id, class_id,tool_name, tool_address, tool_sample, tool_cmd, tool_description) VALUES (%s, (SELECT class_id FROM tool_class WHERE class_name =%s),%s,%s,%s,%s,%s)"
        values = (new_id, app_name,tool_name, tool_address, tool_sample, tool_cmd,tool_description)
        self.db.query(sql_query, values)
        self.db.commit()
        # print("数据插入成功！")
        # 提示用户数据已插入成功
        QMessageBox.information(dialog, "成功", "数据插入成功")
        dialog.close()
        # 发射信号刷新表格
        self.table_refresh_signal.emit()
    

    
        

