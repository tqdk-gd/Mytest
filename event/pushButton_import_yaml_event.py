
from PyQt5.QtCore import QObject, pyqtSignal
from PyQt5 import QtWidgets
import os
import glob
import yaml
from PyQt5.QtWidgets import QDialog, QLabel, QLineEdit, QComboBox, QPushButton, QVBoxLayout,QFileDialog


class PushButtonImportYamlEvent(QObject):
    text_browser_updated = pyqtSignal(str)  # 自定义信号，用于更新文本浏览器内容
    def __init__(self,listWidget_2,rules):
        super().__init__()
        self.listWidget_2 = listWidget_2
        self.rules = rules        

    def import_yaml(self):
        options = QtWidgets.QFileDialog.Options()
        options |= QtWidgets.QFileDialog.DontUseNativeDialog
        directory = QtWidgets.QFileDialog.getExistingDirectory(None, "选择包含yaml文件的文件夹")
        if directory:
            yaml_files = glob.glob(os.path.join(directory, "*.yaml"))
            if yaml_files:
                for yaml_file in yaml_files:
                    rules = self.load_rules(yaml_file)
                    if rules:
                        self.rules.extend(rules)
                        self.listWidget_2.addItem(f"导入规则: {yaml_file}")
                        print(self.rules)
                    else:
                        self.listWidget_2.addItem(f"未能导入规则: {yaml_file}")
            else:
                self.listWidget_2.addItem("所选文件夹中没有 YAML 文件")
        else:
            self.listWidget_2.addItem("未选择任何文件夹")

    def load_rules(self,rule_file):
        try:
            with open(rule_file, 'r') as stream:
                rules = yaml.safe_load(stream)
                return rules['rules']
        except FileNotFoundError:
            print(f"Error: Rule file '{rule_file}' not found.")
            return []