from PyQt5.QtWidgets import QFileDialog
from PyQt5.QtWidgets import QMessageBox
from openpyxl import Workbook
from PyQt5.QtCore import QObject, pyqtSignal

class PushButton4Event(QObject):
    text_browser_updated = pyqtSignal(str)  # 自定义信号，用于更新文本浏览器内容
    def __init__(self,tableWidget):
        super().__init__()
        self.tableWidget = tableWidget

    # 点击导出按钮,导出表格
    def export_table_to_excel(self):
        try:
            file_path, _ = QFileDialog.getSaveFileName(None, 'Save File', '', 'Excel Files (*.xlsx *.xls)')
            if file_path:
                wb = Workbook()
                ws = wb.active
                for row in range(self.tableWidget.rowCount()):
                    for col in range(self.tableWidget.columnCount()):
                        item = self.tableWidget.item(row, col)
                        if item is not None:
                            ws.cell(row=row+1, column=col+1, value=item.text())
                
                wb.save(file_path)
                print('Table exported to Excel file:', file_path)
        except PermissionError:
            msg = QMessageBox()
            msg.setIcon(QMessageBox.Warning)
            msg.setText("该文件当前已打开，无法保存。")
            msg.setWindowTitle("正在使用的文件")
            msg.exec()