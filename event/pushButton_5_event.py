from PyQt5.QtCore import QObject, pyqtSignal
from PyQt5.QtWidgets import QDialog, QLabel, QLineEdit, QComboBox, QPushButton, QFileDialog, QVBoxLayout, QMessageBox

class PushButton5Event(QObject):
    text_browser_updated = pyqtSignal(str)  # 自定义信号，用于更新文本浏览器内容
    table_refresh_signal = pyqtSignal()  # 自定义信号，用于刷新表格
    def __init__(self,db):
        super().__init__()
        self.db = db

    def open_insert_dialog(self):
        dialog = QDialog()
        dialog.resize(800, 400)
        dialog.setWindowTitle("添加新payload")

        payload_name_label = QLabel("漏洞名称:", dialog)
        payload_name_input = QLineEdit(dialog)

        payload_address_label = QLabel("payload文件地址:", dialog)
        payload_address_textbox = QLineEdit(dialog)  # 创建一个文本框用于显示地址
        payload_address_button = QPushButton("选择文件", dialog)
        payload_address_button.clicked.connect(lambda: self.get_file_path(dialog, payload_address_textbox))

        app_label = QLabel("所属类别:", dialog)
        app_combobox = QComboBox(dialog)
        sql_query = "SELECT app_name FROM app"
        result = self.db.query(sql_query)
        app_names = [row[0] for row in result]
        app_names.insert(0, "")  # 在列表开头插入一个空字符串
        app_combobox.addItems(app_names)

        payload_sample_lable = QLabel("命令提示", dialog)
        payload_sample_input = QLineEdit(dialog)
        payload_sample_input.setPlaceholderText("请输入命令提示比如：-u http://example.com:9090")

        payload_param_lable = QLabel("命令除url所需外参数个数", dialog)
        payload_param_input = QLineEdit(dialog)
        payload_param_input.setPlaceholderText("请输入命令所需参数个数，如：2")
        
        payload_dangerous_lable = QLabel("危险程度", dialog)
        payload_dangerous_input = QLineEdit(dialog)
        payload_dangerous_input.setPlaceholderText("请输入危险程度，如：中危漏洞")

        payload_repair_lable = QLabel("修复意见", dialog)
        payload_repair_input = QLineEdit(dialog)
        payload_repair_input.setPlaceholderText("请输入修复意见，如1、关闭互联网暴露面或接口设置访问权限2、关注厂商官网动态，及时更新补丁信息。")


        # 确定按钮
        ok_button = QPushButton("确定", dialog)
        ok_button.clicked.connect(lambda: self.insert_data(dialog,payload_name_input.text(), payload_address_textbox.text(), app_combobox.currentText(),payload_sample_input.text(),payload_param_input.text(),payload_dangerous_input.text(),payload_repair_input.text()))

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

    def get_file_path(self, dialog, address_textbox):
        file_dialog = QFileDialog()
        file_path, _ = file_dialog.getOpenFileName(dialog, "选择文件", "", "All Files (*)")

        if file_path:
        # 将 \ 替换为 /
            file_path = file_path.replace("\\", "/")
            address_textbox.setText(file_path)  # 更新地址文本框的内容
    

    def insert_data(self, dialog,payload_name, payload_address, app_name,payload_sample,payload_param,payload_dangerous, payload_repair):
        # 在这里执行插入数据到数据库的操作
        # 例如连接数据库，执行 INSERT 查询等
        # 插入数据到数据库
        # 插入时有一个id值是按顺序生成的根据数据库中已有的id往后排，其中app_id是通过app_name查询表app得到的
        # 检查payload_name是否已存在
        sql_query = f"SELECT payload_name FROM payload WHERE payload_name = '{payload_name}'"
        result = self.db.query(sql_query)
        if result:
            QMessageBox.warning(dialog, "警告", "该payload名称已存在，请重新输入！")
            return
        #插入时还有一个id值
        # 获取当前最大的id值
        sql_query = "SELECT MAX(payload_id) FROM payload"
        result = self.db.query(sql_query)
        max_id = result[0][0] if result and result[0][0] is not None else 0
        # 插入新数据
        new_id = max_id + 1
        # 入payload数据
        # 插入数据到数据库
        payload_address = payload_address.replace("\\", "/")
        sql_query = "INSERT INTO payload (payload_id, app_id,payload_name, payload_address, payload_sample, payload_param, payload_dangerous,payload_repair) VALUES (%s, (SELECT app_id FROM app WHERE app_name =%s), %s, %s, %s, %s, %s, %s)"
        values = (new_id, app_name,payload_name, payload_address, payload_sample, payload_param, payload_dangerous,payload_repair)
        self.db.query(sql_query, values)
        self.db.commit()
        # print("数据插入成功！")
        # 提示用户数据已插入成功
        QMessageBox.information(dialog, "成功", "数据插入成功")
        dialog.close()
        # 发射信号刷新表格
        self.table_refresh_signal.emit()
        


        

