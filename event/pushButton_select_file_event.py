from PyQt5.QtCore import QObject, pyqtSignal
import re

class PushButtonSelectFileEvent(QObject):
    text_browser_updated = pyqtSignal(str)  # 自定义信号，用于更新文本浏览器内容
    def __init__(self,lineEdit_windows_ip_4):
        super().__init__()
        self.lineEdit_windows_ip_4 = lineEdit_windows_ip_4

    def select_file(self):
        """选择文件并将文件路径显示在 lineEdit_windows_ip_4 中"""
        from PyQt5.QtWidgets import QFileDialog
        # 打开文件选择对话框
        file_path, _ = QFileDialog.getOpenFileName(None, "选择文件", "", "所有文件 (*.*)")
        if file_path:
            # 将选择的文件路径设置到 lineEdit_windows_ip_4 中
            self.lineEdit_windows_ip_4.setText(file_path)