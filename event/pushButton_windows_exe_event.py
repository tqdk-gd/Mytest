import os
import openai
from PyQt5.QtCore import QObject, pyqtSignal

class PushButtonWindowsExeEvent(QObject):
    text_browser_updated = pyqtSignal(str)  # 自定义信号，用于更新文本浏览器内容
    def __init__(self,plainTextEdit_windows_result,lineEdit_windows_ip,lineEdit_windows_port):
        super().__init__()
        self.plainTextEdit_windows_result = plainTextEdit_windows_result
        self.lineEdit_windows_ip = lineEdit_windows_ip
        self.lineEdit_windows_port = lineEdit_windows_port
        self.API_KEY = os.getenv('KEY')  # 从环境变量中读取 API 密钥
        self.MODEL = "gpt-3.5-turbo"  # 更新模型名称
        self.API_ENDPOINT = "https://api.openai.com/v1/chat/completions"

    
    def code_audit(self):
        code_path = self.lineEdit_windows_ip.text()
        api_key = self.lineEdit_windows_port.text()

        if not code_path or not api_key:
            self.plainTextEdit_windows_result.setPlainText("请输入代码路径和API密钥")
            return

        if not os.path.exists(code_path):
            self.plainTextEdit_windows_result.setPlainText("错误：代码路径不存在")
            return

        if os.path.isfile(code_path):
            self.audit_single_file(code_path, api_key)
        elif os.path.isdir(code_path):
            self.audit_directory(code_path, api_key)

    def audit_single_file(self, file_path, api_key):
        try:
            with open(file_path, 'r', encoding='utf-8') as file:
                code = file.read()

            openai.api_key = api_key
            response = openai.ChatCompletion.create(
                model=self.MODEL,
                messages=[
                    {"role": "system", "content": "You are a code auditing assistant."},
                    {"role": "user", "content": f"请对以下代码进行安全审计并指出潜在的漏洞：\n\n{code}"}
                ],
                max_tokens=1024,
                n=1,
                stop=None,
                temperature=0.5,
            )

            result = response.choices[0].message['content']
            self.plainTextEdit_windows_result.appendPlainText(f"文件: {file_path}\n{result}\n")
        except openai.error.RateLimitError:
            self.plainTextEdit_windows_result.appendPlainText(f"文件: {file_path}\nAPI请求超出配额，请检查您的计划和计费详细信息。\n")
        except Exception as e:
            self.plainTextEdit_windows_result.appendPlainText(f"文件: {file_path}\n发生错误: {str(e)}\n")

    def audit_directory(self, dir_path, api_key):
        for root, _, files in os.walk(dir_path):
            for file in files:
                file_path = os.path.join(root, file)
                self.audit_single_file(file_path, api_key)