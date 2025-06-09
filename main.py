import sys
import untitled
import re
from PyQt5 import QtCore,QtWidgets
from PyQt5.QtWidgets import (QApplication, QMainWindow, QAction, QDialog,
                             QVBoxLayout, QLabel, QLineEdit, QComboBox,
                             QDialogButtonBox, QMessageBox)
from PyQt5.QtWidgets import QApplication, QWidget, QLabel, QLineEdit, QPushButton, QVBoxLayout, QMessageBox
from PyQt5.QtNetwork import QNetworkProxy
import data
from event import (pushButton_event,pushButton_2_event,pushButton_3_event,pushButton_4_event,
                   pushButton_6_event, pushButton_weblogic_uploadshell_2_event,pushButton_windows_exe_event,pushButton_weblogic_uploadshell_event,
                   pushButton_7_event,pushButton_5_event,pushButton_8_event,pushButton_import_yaml_event,
                   pushButton_run_scan_event,pushButton_9_event,pushButton_10_event,pushButton_11_event,pushButton_12_event,pushButton_weblogic_uploadshell_2_event,
                   run_btn_event,pushButton_select_folder_event,pushButton_select_file_event)
from event import comboBox_2_event,comboBox_3_event
from event import listWidget_event
from event import tabWidget_event
from event import action_event
import os
import datetime
import glob
import yaml
from concurrent.futures import ThreadPoolExecutor
from PyQt5.QtWidgets import QDialog, QLabel, QLineEdit, QComboBox, QPushButton, QVBoxLayout,QFileDialog
from PyQt5.QtCore import Qt, QTimer, QThread, pyqtSignal, pyqtSlot, QObject
from PyQt5.QtGui import QPixmap, QIcon
from PyQt5.QtWidgets import (
    QWidget, 
    QLabel, 
    QLineEdit, 
    QPushButton, 
    QVBoxLayout, 
    QHBoxLayout,
    QMessageBox,
    QApplication,
    QGridLayout
)
from PyQt5.QtGui import (
    QIcon,
    QPixmap,
    QFont
)
from PyQt5.QtCore import (
    Qt,
    QPoint,
    QPropertyAnimation,
    pyqtProperty,
    QTimer
)

class LoginWindow(QWidget):
    def __init__(self):
        super().__init__()
        self.db = data.DBConnector('config.ini')
        # 初始化 registration_window 属性
        self.registration_window = None
        self.initUI()
        self.setWindowIcon(QIcon('icons/logo.png'))  # 添加窗口图标

    def initUI(self):
        # 窗口基础设置
        self.setWindowTitle('Web常见漏洞验证工具')
        self.setFixedSize(500, 400)  # 固定窗口尺寸
        self.setStyleSheet("""
            QWidget {
                background: #f0f2f5;
                font-family: '微软雅黑';
            }
            QLabel {
                color: #2d3436;
                font-size: 14px;
                margin-bottom: 5px;
            }
            QLabel#title_label {
                font-family: 'Microsoft YaHei UI', 'SimHei', sans-serif;  /* 指定字体，优先使用微软雅黑 UI，其次黑体 */
                font-size: 21px;  /* 设置字体大小 */
                font-weight: bold;  /* 设置字体加粗 */
                color: #1976d2;  /* 设置字体颜色为蓝色 */
                text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.1);  /* 添加文字阴影 */
                margin-bottom: 30px;
            }
            QComboBox {
                border: 1px solid #ced4da;
                border-radius: 4px;
                padding: 8px;
                font-size: 14px;
                margin-bottom: 15px;
            }
            QComboBox:focus {
                border-color: #4dabf7;
                background: #fff; 
            }
            QLineEdit {
                border: 1px solid #ced4da;
                border-radius: 4px;
                padding: 8px;
                font-size: 14px;
                margin-bottom: 15px;
            }
            QLineEdit:focus {
                border-color: #4dabf7;
                background: #fff;
            }
            QPushButton {
                background: #1976d2;
                color: white;
                border: none;
                padding: 12px 24px;
                border-radius: 4px;
                font-size: 14px;
                min-width: 120px;
            }
            QPushButton:hover {
                background: #1565c0;
            }
            QPushButton:pressed {
                background: #0d47a1;
            }
            
        """)

        # 创建标题标签
        self.title_label = QLabel('Web常见漏洞验证工具登录窗口', self)
        self.title_label.setObjectName('title_label')
        self.title_label.setAlignment(Qt.AlignCenter)
        


        self.username_label = QLabel("用户名:")
        self.username_input = QLineEdit()
        self.username_input.setPlaceholderText("请输入用户名")
        self.username_input.setClearButtonEnabled(True)

        self.password_label = QLabel("密码:")
        self.password_input = QLineEdit()
        self.password_input.setPlaceholderText("请输入密码")
        self.password_input.setEchoMode(QLineEdit.Password)
        self.password_input.setClearButtonEnabled(True)

        self.login_button = QPushButton('登录认证')
        self.login_button.setIcon(QIcon('icons/login_key.png'))
        self.login_button.clicked.connect(self.login)

        # 使用 QGridLayout 布局
        grid_layout = QGridLayout()
        grid_layout.setContentsMargins(40, 30, 40, 30)  # 设置布局边距
        grid_layout.setVerticalSpacing(20)  # 设置垂直间距

        # 添加控件到布局
        grid_layout.addWidget(self.title_label, 0, 0, 1, 2, Qt.AlignCenter)
        grid_layout.addWidget(self.username_label, 1, 0)
        grid_layout.addWidget(self.username_input, 1, 1)
        grid_layout.addWidget(self.password_label, 2, 0)
        grid_layout.addWidget(self.password_input, 2, 1)
        grid_layout.addWidget(self.login_button, 3, 0, 1, 2, Qt.AlignCenter)

        # 创建超链接标签
        self.github_link = QLabel('<a href="https://github.com/tqdk-gd/Mytest.git">点击获取登录账户密码</a>', self)
        self.github_link.setObjectName('github_link')
        self.github_link.setAlignment(Qt.AlignCenter)
        self.github_link.setOpenExternalLinks(True)


        
        
        # 使用 QVBoxLayout 包装 grid_layout 和 github_link
        main_layout = QVBoxLayout()
        main_layout.addLayout(grid_layout)
        main_layout.addStretch(1)  # 添加伸缩项，让超链接靠下显示
        main_layout.addWidget(self.github_link)
        main_layout.setContentsMargins(20, 20, 20, 20)  # 设置主布局边距
        main_layout.setSpacing(15)  # 设置主布局间距

        self.setLayout(main_layout)

    def login(self):
        # 在原有逻辑基础上增加输入动画反馈
        inputs_valid = True
        for input_field in [self.username_input, self.password_input]:
            if not input_field.text().strip():
                self.shake_input(input_field)
                inputs_valid = False

        if inputs_valid:
            # 安全提示：建议使用参数化查询防止SQL注入
            query = "SELECT * FROM users WHERE user_name = %s AND user_password = %s"
            result = self.db.query(query, (self.username_input.text(), self.password_input.text()))
            # 后续登录逻辑...
            if result:
                reply = QMessageBox.information(self, '成功', '用户名和密码正确')
                self.close()
                main_window = MainWindow()
                main_window.show()
            else:
                QMessageBox.warning(self, '警告', '用户名或密码错误')

    def shake_input(self, widget):
        # 输入验证失败的抖动动画
        animation = QPropertyAnimation(widget, b"pos")
        animation.setDuration(100)
        animation.setLoopCount(2)
        animation.setKeyValueAt(0, widget.pos())
        animation.setKeyValueAt(0.25, QPoint(widget.x()+5, widget.y()))
        animation.setKeyValueAt(0.75, QPoint(widget.x()-5, widget.y()))
        animation.setEndValue(widget.pos())
        animation.start()
    


class MainWindow(QMainWindow):
    def __init__(self):
        super().__init__()
        self.ui = untitled.Ui_MainWindow()
        self.ui.setupUi(self)
        self.db = data.DBConnector('config.ini')
        self.rules = []
        self.current_proxy = None
        self.tool_name = ''
        # self.API_KEY = os.getenv('KEY')  # 从环境变量中读取 API 密钥
        # self.MODEL = "gpt-3.5-turbo"  # 更新模型名称
        # self.API_ENDPOINT = "https://api.openai.com/v1/chat/completions"
        #定义槽函数类
        self.pushButton_event = pushButton_event.PushButtonEvent(lineEdit_2 = self.ui.lineEdit_2,
                                                                   lineEdit_3 = self.ui.lineEdit_3,
                                                                   comboBox_3 = self.ui.comboBox_3,
                                                                   textBrowser_2 = self.ui.textBrowser_2,
                                                                   tableWidget = self.ui.tableWidget,
                                                                   current_proxy=self.current_proxy,
                                                                   db = self.db)
        self.pushButton_2_event = pushButton_2_event.PushButton2Event(lineEdit_4=self.ui.lineEdit_4)
        self.pushButton_3_event = pushButton_3_event.PushButton3Event(lineEdit_4=self.ui.lineEdit_4, 
                                                                      db=self.db,
                                                                      lineEdit_2 = self.ui.lineEdit_2,
                                                                      comboBox_3 = self.ui.comboBox_3,
                                                                      textBrowser_2 = self.ui.textBrowser_2,
                                                                      tableWidget = self.ui.tableWidget,
                                                                      current_proxy = self.current_proxy)
        self.pushButton_4_event = pushButton_4_event.PushButton4Event(tableWidget = self.ui.tableWidget)
        self.comboBox_2_event = comboBox_2_event.ComboBox2Event(db=self.db,
                                                              comboBox_2=self.ui.comboBox_2,
                                                              listWidget=self.ui.listWidget)
        self.comboBox_3_event = comboBox_3_event.ComboBox3Event(db=self.db,
                                                              comboBox_3=self.ui.comboBox_3,
                                                              lineEdit_2=self.ui.lineEdit_2,
                                                              textBrowser=self.ui.textBrowser,
                                                              horizontalLayout_4=self.ui.horizontalLayout_4,
                                                              lineEdit_3 = self.ui.lineEdit_3)
        self.listWidget_event = listWidget_event.ListWidgetEvent(comboBox_3=self.ui.comboBox_3,
                                                              db= self.db)
        self.pushButton_6_event = pushButton_6_event.PushButton6Event(lineEdit=self.ui.lineEdit,
                                                                      tableWidget_3=self.ui.tableWidget_3,
                                                                      comboBox_4=self.ui.comboBox_4
                                                                      )
        self.pushButton_windows_exe_event = pushButton_windows_exe_event.PushButtonWindowsExeEvent(lineEdit_windows_ip=self.ui.lineEdit_windows_ip,
                                                                                                    lineEdit_windows_port=self.ui.lineEdit_windows_port,
                                                                                                    plainTextEdit_windows_result=self.ui.plainTextEdit_windows_result)
        self.pushButton_weblogic_uploadshell_event = pushButton_weblogic_uploadshell_event.PushButtonWeblogicUploadshellEvent(lineEdit_windows_ip_2=self.ui.lineEdit_windows_ip_2,
                                                                                                                                lineEdit_windows_ip_3=self.ui.lineEdit_windows_ip_3,
                                                                                                                                plainTextEdit_weblogic_result=self.ui.plainTextEdit_weblogic_result)
        self.tabWidget_event = tabWidget_event.TabWidgetEvent(tableWidget_3=self.ui.tableWidget_3,tableWidget_4=self.ui.tableWidget_4,db=self.db)
        self.pushButton_7_event = pushButton_7_event.PushButton7Event(tableWidget_3=self.ui.tableWidget_3,db=self.db)
        self.pushButton_5_event = pushButton_5_event.PushButton5Event(db=self.db)
        self.pushButton_8_event = pushButton_8_event.PushButton8Event(db=self.db,tableWidget_3=self.ui.tableWidget_3)
        self.pushButton_import_yaml_event = pushButton_import_yaml_event.PushButtonImportYamlEvent(listWidget_2=self.ui.listWidget_2,rules=self.rules)
        self.pushButton_run_scan_event = pushButton_run_scan_event.PushButtonRunScanEvent(listWidget_2=self.ui.listWidget_2,rules=self.rules,comboBox_language=self.ui.comboBox_language)
        self.action_event = action_event.ActionEvent(main_window=self,current_proxy=self.current_proxy)
        self.pushButton_9_event = pushButton_9_event.PushButton9Event(lineEdit_5=self.ui.lineEdit_5,comboBox_5=self.ui.comboBox_5,tableWidget_4=self.ui.tableWidget_4)
        self.pushButton_10_event = pushButton_10_event.PushButton10Event(db=self.db)
        self.pushButton_11_event = pushButton_11_event.PushButton11Event(db=self.db,tableWidget_4=self.ui.tableWidget_4)
        self.pushButton_12_event = pushButton_12_event.PushButton12Event(tableWidget_4=self.ui.tableWidget_4,db=self.db)
        self.pushButton_weblogic_uploadshell_2_event = pushButton_weblogic_uploadshell_2_event.PushButtonWeblogicUploadshell2Event(comboBox_6=self.ui.comboBox_6,db=self.db,lineEdit_windows_ip_4=self.ui.lineEdit_windows_ip_4,plainTextEdit_weblogic_result_2=self.ui.plainTextEdit_weblogic_result_2)
        self.run_btn_event = run_btn_event.RunBtnEvent(cmd_input=self.ui.cmd_input,terminal=self.ui.terminal,tableWidget=self.ui.tableWidget,db=self.db)
        self.pushButton_select_folder_event = pushButton_select_folder_event.PushButtonSelectFolderEvent(lineEdit_windows_ip_2=self.ui.lineEdit_windows_ip_2)
        self.pushButton_select_file_event = pushButton_select_file_event.PushButtonSelectFileEvent(lineEdit_windows_ip_4=self.ui.lineEdit_windows_ip_4)



        #连接槽函数到事件
        self.ui.pushButton.clicked.connect(self.pushButton_event.update_textBrowser_2)
        self.ui.pushButton_2.clicked.connect(self.pushButton_2_event.update_lineEdit_4)
        self.ui.pushButton_3.clicked.connect(self.pushButton_3_event.read_file_content)
        self.ui.pushButton_4.clicked.connect(self.pushButton_4_event.export_table_to_excel)
        self.ui.pushButton_6.clicked.connect(self.pushButton_6_event.perform_query)
        self.ui.pushButton_7.clicked.connect(self.pushButton_7_event.delete_row)
        self.pushButton_7_event.table_refresh_signal.connect(lambda: self.tabWidget_event.on_tab_clicked(index=3))
        self.ui.run_btn.clicked.connect(lambda: self.run_btn_event.update_textBrowser_2(tool_name=self.tool_name))
        self.ui.comboBox_2.currentIndexChanged.connect(self.comboBox_2_event.update_list_widget)
        self.ui.comboBox_3.currentIndexChanged.connect(self.comboBox_3_event.update_lineEdit_2)
        self.ui.comboBox_3.currentIndexChanged.connect(self.comboBox_3_event.addComponentsToHorizontalLayout)
        self.ui.comboBox_3.currentIndexChanged.connect(self.comboBox_3_event.update_textBrowser)
        self.ui.lineEdit_3.textChanged.connect(self.comboBox_3_event.sync_text)
        self.ui.listWidget.itemClicked.connect(self.listWidget_event.on_item_clicked)
        self.ui.pushButton_windows_exe.clicked.connect(self.pushButton_windows_exe_event.code_audit)
        self.ui.pushButton_weblogic_uploadshell.clicked.connect(self.pushButton_weblogic_uploadshell_event.global_keyword_search)
        self.ui.tabWidget.tabBarClicked.connect(lambda: self.tabWidget_event.on_tab_clicked(index=3))
        self.ui.tabWidget.tabBarClicked.connect(lambda: self.tabWidget_event.on_tab_clicked(index=4))
        # self.ui.tabWidget.tabBarClicked.connect(self.tabWidget_event.on_tab_clicked_1)
        self.ui.pushButton_5.clicked.connect(self.pushButton_5_event.open_insert_dialog)
        self.pushButton_5_event.table_refresh_signal.connect(lambda: self.tabWidget_event.on_tab_clicked(index=3))
        self.ui.pushButton_8.clicked.connect(self.pushButton_8_event.modify_data)
        self.pushButton_8_event.table_refresh_signal.connect(lambda: self.tabWidget_event.on_tab_clicked(index=3))
        self.ui.pushButton_import_yaml.clicked.connect(self.pushButton_import_yaml_event.import_yaml)
        self.ui.pushButton_run_scan.clicked.connect(self.pushButton_run_scan_event.run_scan)
        self.ui.pushButton_9.clicked.connect(self.pushButton_9_event.perform_query)
        self.ui.pushButton_10.clicked.connect(self.pushButton_10_event.open_insert_dialog)
        self.pushButton_10_event.table_refresh_signal.connect(lambda: self.tabWidget_event.on_tab_clicked(index=4))
        self.ui.pushButton_11.clicked.connect(self.pushButton_11_event.modify_data)
        self.pushButton_11_event.table_refresh_signal.connect(lambda: self.tabWidget_event.on_tab_clicked(index=4))
        self.ui.pushButton_12.clicked.connect(self.pushButton_12_event.delete_row)
        self.pushButton_12_event.table_refresh_signal.connect(lambda: self.tabWidget_event.on_tab_clicked(index=4))
        self.ui.action1.triggered.connect(self.action_event.show_proxy_dialog)
        self.ui.action2.triggered.connect(self.action_event.disable_proxy)
        self.action_event.proxy_changed.connect(self.sync_proxy)
        self.ui.action_exit.triggered.connect(self.close)
        self.comboBox_2_changed()
        self.ui.pushButton_weblogic_uploadshell_2.clicked.connect(self.pushButton_weblogic_uploadshell_2_event.dangerous_function_search)
        self.ui.pushButton_select_folder.clicked.connect(self.pushButton_select_folder_event.select_folder)
        self.ui.pushButton_select_file.clicked.connect(self.pushButton_select_file_event.select_file)

        
    
    #自适应窗口
    def resizeEvent(self, event):
        super().resizeEvent(event)
        self.ui.tabWidget.setGeometry(QtCore.QRect(0, 0, self.ui.centralwidget.width(), self.ui.centralwidget.height()))
        self.ui.horizontalLayoutWidget_2.setGeometry(QtCore.QRect(0, 0, self.ui.tabWidget.width()-5, self.ui.tabWidget.height()-5))
        #self.ui.verticalLayoutWidget.setGeometry(QtCore.QRect(0, 0, self.ui.tabWidget.width(), self.ui.tabWidget.height()))
        #self.ui.verticalLayoutWidget_2.setGeometry(QtCore.QRect(0, 0, self.ui.tabWidget.width(), self.ui.tabWidget.height()))
        #self.ui.verticalLayoutWidget_3.setGeometry(QtCore.QRect(0, 0, self.ui.tabWidget.width(), self.ui.tabWidget.height()))
        self.ui.tabWidget_2.setGeometry(QtCore.QRect(0, 0, self.ui.tabWidget.width()-5, self.ui.tabWidget.height()-5))

    def select_file(self):
        """选择文件并将文件路径显示在 lineEdit_windows_ip_4 中"""
        from PyQt5.QtWidgets import QFileDialog
        # 打开文件选择对话框
        file_path, _ = QFileDialog.getOpenFileName(self.centralWidget(), "选择文件", "", "所有文件 (*.*)")
        if file_path:
            # 将选择的文件路径设置到 lineEdit_windows_ip_4 中
            self.ui.lineEdit_windows_ip_4.setText(file_path)

    def comboBox_2_changed(self):
        
        sql_query = ''
        result = ''
        result1 = ''
        sql_query = "SELECT class_name FROM web_app"
        result = self.db.query(sql_query)
        # 填充comboBox_2
        for row in result:
            self.ui.comboBox_2.addItem(row[0])
        
        sql_query = "select class_name from program_class"
        result = self.db.query(sql_query)
        # 填充comboBox_6
        for row in result:
            self.ui.comboBox_6.addItem(row[0])

        sql_query = "select class_name from program_class"
        result = self.db.query(sql_query)
        # 填充comboBox_5
        for row in result:
            self.ui.comboBox_language.addItem(row[0])


        sql_query = "SELECT class_name,class_id FROM tool_class"
        result = self.db.query(sql_query)
        
        
        # 填充 tool_box
        for class_name,class_id in result:
            tools = QtWidgets.QWidget()
            layout = QtWidgets.QVBoxLayout(tools)
            listwidget = QtWidgets.QListWidget()
            listwidget.setObjectName(f"listWidget_{class_name}")
            sql_query = f"SELECT tool.tool_name FROM tool WHERE tool.class_id={class_id}"
            result1 = self.db.query(sql_query)
            # print(class_name)
            for row in result1:
                listwidget.addItem(row[0])
            listwidget.itemClicked.connect(self.on_item_clicked)
            layout.addWidget(listwidget)
            self.ui.tool_box.addItem(tools,class_name)

        # sql_query = f"SELECT tool.tool_name FROM tool,tool_class WHERE tool_class.tool_name={result[0][0]} AND tool.tool_class_id=tool_class.tool_class_id"
        # result = self.db.query(sql_query)
        # # 填充 tool_box
        # for row in result:
        #     self.ui.tool_box.addItem(row[0])
    
    def on_item_clicked(self,item):
        text = item.text()
        selected_option = text.split(',')[0]  # 假设第一个元素为选项

        # 查询数据库以获取动态内容
        sql_query = f"SELECT tool.tool_sample FROM tool WHERE tool_name = '{selected_option}'"
        self.tool_name = selected_option

        result = self.db.query(sql_query)

        if result is not None:
            # 清空combobox并添加新选项
            self.ui.terminal.clear_output()
            # self.comboBox_3.addItem('ALL')
            for row in result:
                self.ui.cmd_input.setPlaceholderText(f"输入完整命令（示例：{row[0]}）")
                
    def sync_proxy(self, proxy):
            """同步代理信息"""
            self.current_proxy = proxy
            # 可以在这里添加其他同步代理信息的逻辑，例如更新其他事件类的代理信息
            self.pushButton_event.update_proxy(proxy)
            self.pushButton_3_event.update_proxy(proxy)
            self.ui.terminal.update_proxy(proxy)

    

    



   




    
    



    def categorize_vulnerabilities(self,vulnerabilities):
        categories = {}
        for vuln in vulnerabilities:
            category = vuln.get('category', 'Uncategorized')
            if category not in categories:
                categories[category] = []
            categories[category].append(vuln)
        return categories

                


    def get_file_path(self, dialog, address_textbox):
        file_dialog = QFileDialog()
        file_path, _ = file_dialog.getOpenFileName(dialog, "选择文件", "", "All Files (*)")

        if file_path:
        # 将 \ 替换为 /
            file_path = file_path.replace("\\", "/")
            address_textbox.setText(file_path)  # 更新地址文本框的内容
    
    

    def delete_row(self):
        selected_row = self.ui.tableWidget_3.currentRow()  # 获取当前选中的行索引
        if selected_row != -1:
            cell_item = self.ui.tableWidget_3.item(selected_row, 2)  # 第三列索引为2
            if cell_item is not None:
                item_text = cell_item.text()
                print(item_text)
                sql_query = f"DELETE FROM payload WHERE payload_name = '{item_text}'"
                result = self.db.execute(sql_query)
                if result:
                    self.ui.tableWidget_3.removeRow(selected_row)  # 删除选中的行
                    QMessageBox.information(self, "删除成功", "删除成功！")

            

        
    
    #同步修改lineEdit_3
    def sync_text(self):
        text_2 = self.ui.lineEdit_2.text()
        text_3 = self.ui.lineEdit_3.text()
        text_values_list = []
        text_values_list.append(text_3)

        for i in range(self.ui.horizontalLayout_4.count()):
            item = self.ui.horizontalLayout_4.itemAt(i)
            if isinstance(item.widget(), QtWidgets.QLineEdit):
                text_value = item.widget().text()
                text_values_list.append(text_value)

        # print(text_values_list)
        first_index = text_2.find('-')
        if first_index != -1:
            next_index = text_2.find('-', first_index + 2)  # 查找下一个 '-'
            i = 0
            while next_index != -1:
                str = text_2[first_index+3:next_index-1]
                text_2 = text_2[:first_index + 2] + ' ' + text_values_list[i] + ' ' + text_2[next_index:]
                first_index = next_index - len(str) + len(text_values_list[i])
                next_index = text_2.find('-', first_index + 2)
                print(next_index)
                i += 1
                print(i)
            
            # 处理最后一个 '-'
            text_2 = text_2[:first_index + 2] + ' ' + text_values_list[i]
        self.ui.lineEdit_2.setText(text_2)
    
    
    
    # 窗口关闭时，弹出确认窗口
    def closeEvent(self, event):
        reply = QMessageBox.question(self, '确认', '是否关闭窗口?', QMessageBox.Yes | QMessageBox.No, QMessageBox.No)
        if reply == QMessageBox.Yes:
            if self.current_proxy:
                self.action_event.disable_proxy()
            self.db.close()  # 关闭数据库连接
            event.accept()  # 关闭窗口
        else:
            event.ignore()  # 忽略关闭窗口的操作
    


        

        


if __name__ == '__main__':
    # 只有直接运行这个脚本，才会往下执行
    # 别的脚本文件执行，不会调用这个条件句

    # 实例化，传参
    app = QApplication(sys.argv)
    app.setWindowIcon(QIcon('icons/logo.png'))
    # mainWindow = MainWindow()
    # mainWindow.show()
    login_window = LoginWindow()
    login_window.show()
    # 调用Ui_MainWindow类的setupUi，创建初始组件
    # 以下代码是为了让窗口关闭时，Python也关闭，保证窗口关闭后，程序也关闭
    # 进入程序的主循环，并通过exit函数确保主循环安全结束(该释放资源的一定要释放)
    sys.exit(app.exec_())
