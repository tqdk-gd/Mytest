from PyQt5 import QtWidgets
from PyQt5.QtCore import QObject, pyqtSignal

class PushButton2Event(QObject):
    text_browser_updated = pyqtSignal(str)  # 自定义信号，用于更新文本浏览器内容
    def __init__(self,lineEdit_4):
        super().__init__()
        self.lineEdit_4 = lineEdit_4


# 文本框lineEdit_2 内容发生变化时，修改文本框lineEdit_3 内容，点击选择文件读取文件路径到文本框
    def update_lineEdit_4(self):
        options = QtWidgets.QFileDialog.Options()
        file_path, _ = QtWidgets.QFileDialog.getOpenFileName(None, "选择文件", "", "All Files (*);;Text Files (*.txt)", options=options)
        
        if file_path:
            # 如果用户选择了文件，将文件路径显示在文本框中
            self.lineEdit_4.setText(file_path)