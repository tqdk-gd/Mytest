from PyQt5.QtCore import QObject, pyqtSignal
import re

class PushButtonWeblogicUploadshell2Event(QObject):
    text_browser_updated = pyqtSignal(str)  # 自定义信号，用于更新文本浏览器内容
    def __init__(self,comboBox_6,db,lineEdit_windows_ip_4,plainTextEdit_weblogic_result_2):
        super().__init__()
        self.comboBox_6 = comboBox_6
        self.db = db
        self.lineEdit_windows_ip_4 = lineEdit_windows_ip_4
        self.plainTextEdit_weblogic_result_2 = plainTextEdit_weblogic_result_2

    def dangerous_function_search(self):
        file_path = self.lineEdit_windows_ip_4.text()  # 获取用户输入的文件路径
        class_name = self.comboBox_6.currentText()  # 使用用户选择的类名

        if not file_path:
            self.plainTextEdit_weblogic_result_2.setPlainText("请输入文件路径")
            return

        try:
            with open(file_path, 'r', encoding='utf-8') as file:
                lines = file.readlines()
        except FileNotFoundError:
            self.plainTextEdit_weblogic_result_2.setPlainText("文件未找到，请检查路径")
            return
        except Exception as e:
            self.plainTextEdit_weblogic_result_2.setPlainText(f"读取文件时发生错误: {str(e)}")
            return

        try:
            results = {}
            # 检查是否包含危险函数
            sql = f'''SELECT program.program_function, program.program_ds
            FROM program
            JOIN program_class ON program_class.class_id = program.program_class_id
            WHERE program_class.class_name = '{class_name}'
            '''
            result = self.db.query(sql)

            for program_function, program_ds in result:
                line_numbers = []
                for line_number, line in enumerate(lines, start=1):
                    if re.search(rf'\b{program_function}\b', line):
                        line_numbers.append(line_number)
                if line_numbers:
                    results[f"{class_name} ：{program_function}(): {program_ds}"] = line_numbers

            # 将字典转换为字符串
            result_text = "\n".join([f"{key}: 第 {', '.join(map(str, value))} 行" for key, value in results.items()]) if results else "未找到危险函数"
            self.plainTextEdit_weblogic_result_2.setPlainText(result_text)

        except Exception as e:
            self.plainTextEdit_weblogic_result_2.setPlainText(f"发生错误: {str(e)}")