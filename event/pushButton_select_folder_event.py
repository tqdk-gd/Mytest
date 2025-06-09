import os
import re
from PyQt5.QtCore import QObject, pyqtSignal
from PyQt5.QtWidgets import QFileDialog


class PushButtonSelectFolderEvent(QObject):
    text_browser_updated = pyqtSignal(str)  # 自定义信号，用于更新文本浏览器内容
    def __init__(self,lineEdit_windows_ip_2):
        super().__init__()
        self.lineEdit_windows_ip_2 = lineEdit_windows_ip_2


    def select_folder(self):
        folder_path = QFileDialog.getExistingDirectory(None, "选择文件夹")
        if folder_path:
            self.lineEdit_windows_ip_2.setText(folder_path)