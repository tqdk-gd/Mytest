import os
import re
from PyQt5.QtCore import QObject, pyqtSignal, QThread
from PyQt5.QtWidgets import QApplication

class SearchThread(QThread):
    result_signal = pyqtSignal(str)  # 自定义信号，用于传递搜索结果

    def __init__(self, root_path, keyword):
        super().__init__()
        self.root_path = root_path
        self.keyword = keyword

    def run(self):

        matched_files = []
        try:
            for foldername, _, filenames in os.walk(self.root_path):
                for filename in filenames:
                    file_path = os.path.join(foldername, filename)
                    try:
                        with open(file_path, 'r', encoding='utf-8', errors='ignore') as file:
                            lines = file.readlines()
                            line_numbers = []
                            for line_number, line in enumerate(lines, start=1):
                                if re.search(self.keyword, line, re.IGNORECASE):
                                    line_numbers.append(line_number)
                            if line_numbers:
                                matched_files.append(f"{file_path}: 行号 {', '.join(map(str, line_numbers))}")
                    except Exception as e:
                        print(f"Error reading file {file_path}: {str(e)}")
                        continue

            if matched_files:
                result = "匹配的文件路径和行号:\n" + "\n".join(matched_files)
            else:
                result = "未找到匹配的文件"
            self.result_signal.emit(result)
        except Exception as e:
            self.result_signal.emit(f"发生错误: {str(e)}")

class PushButtonWeblogicUploadshellEvent(QObject):
    text_browser_updated = pyqtSignal(str)  # 自定义信号，用于更新文本浏览器内容
    def __init__(self,lineEdit_windows_ip_2,lineEdit_windows_ip_3,plainTextEdit_weblogic_result):
        super().__init__()
        self.lineEdit_windows_ip_2 = lineEdit_windows_ip_2
        self.lineEdit_windows_ip_3 = lineEdit_windows_ip_3
        self.plainTextEdit_weblogic_result = plainTextEdit_weblogic_result
        
    def global_keyword_search(self):
        root_path = self.lineEdit_windows_ip_2.text().strip()
        keyword = self.lineEdit_windows_ip_3.text()

        if not root_path or not keyword:
            self.plainTextEdit_weblogic_result.setPlainText("请输入文件夹路径和关键词")
            return

        if not os.path.exists(root_path):
            self.plainTextEdit_weblogic_result.setPlainText("错误：路径不存在")
            return

        # 创建搜索线程
        self.plainTextEdit_weblogic_result.setPlainText("正在搜索，请稍候...")
        self.search_thread = SearchThread(root_path, keyword)
        self.search_thread.result_signal.connect(self.show_search_result)
        self.search_thread.start()

    def show_search_result(self, result):
        self.plainTextEdit_weblogic_result.setPlainText(result)