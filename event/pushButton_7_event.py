
from PyQt5.QtCore import QObject, pyqtSignal
from PyQt5.QtWidgets import QMessageBox

class PushButton7Event(QObject):
    text_browser_updated = pyqtSignal(str)  # 自定义信号，用于更新文本浏览器内容
    table_refresh_signal = pyqtSignal()  # 自定义信号，用于刷新表格
    def __init__(self,tableWidget_3,db):
        super().__init__()
        self.tableWidget_3 = tableWidget_3
        self.db = db

    def delete_row(self):
        selected_row = self.tableWidget_3.currentRow()  # 获取当前选中的行索引
        msg = QMessageBox()
        msg.setIcon(QMessageBox.Question)
        msg.setText(f"确定删除该 payload 吗？")
        msg.setWindowTitle("确认删除")
        msg.setStandardButtons(QMessageBox.Yes | QMessageBox.Cancel)
        response = msg.exec_()
        if response == QMessageBox.Yes:
            if selected_row != -1:
                cell_item = self.tableWidget_3.item(selected_row, 2)  # 第三列索引为2
                if cell_item is not None:
                    item_text = cell_item.text()
                    print(item_text)
                    sql_query = f"DELETE FROM payload WHERE payload_name = '{item_text}'"
                    result = self.db.query(sql_query)
                    self.db.commit()
                    if result:
                        QMessageBox.warning(None, "删除失败", "删除失败！")
                    else:
                        # 发射信号刷新表格
                        self.table_refresh_signal.emit()
                        QMessageBox.information(None, "删除成功", "删除成功！")
        else:
                # 用户点击取消按钮
                cancel_msg = QMessageBox()
                cancel_msg.setIcon(QMessageBox.Information)
                cancel_msg.setText("已取消删除操作")
                cancel_msg.setWindowTitle("取消删除")
                cancel_msg.exec_()

    
        