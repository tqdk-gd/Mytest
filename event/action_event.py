from PyQt5.QtWidgets import ( QDialog,
                             QVBoxLayout, QLabel, QLineEdit, QComboBox,
                             QDialogButtonBox, QMessageBox)
from PyQt5.QtNetwork import QNetworkProxy
from PyQt5.QtCore import QObject,pyqtSignal

class ProxyDialog(QDialog):
    """代理设置对话框"""
    def __init__(self, parent=None):
        super().__init__(parent)
        self.setWindowTitle("代理设置")
        self.setFixedSize(300, 200)
        self.initUI()

    def initUI(self):
        layout = QVBoxLayout()

        # 协议选择
        self.protocol_combo = QComboBox()
        self.protocol_combo.addItems(['HTTP', 'SOCKS5'])
        layout.addWidget(QLabel("协议类型:"))
        layout.addWidget(self.protocol_combo)

        # IP地址输入
        self.ip_input = QLineEdit()
        self.ip_input.setPlaceholderText("例如：127.0.0.1")
        layout.addWidget(QLabel("IP地址:"))
        layout.addWidget(self.ip_input)

        # 端口输入
        self.port_input = QLineEdit()
        self.port_input.setPlaceholderText("例如：8080")
        layout.addWidget(QLabel("端口号:"))
        layout.addWidget(self.port_input)

        # 按钮组
        buttons = QDialogButtonBox(QDialogButtonBox.Ok | QDialogButtonBox.Cancel)
        buttons.accepted.connect(self.validate_input)
        buttons.rejected.connect(self.reject)
        layout.addWidget(buttons)

        self.setLayout(layout)

    def validate_input(self):
        """验证输入有效性"""
        ip = self.ip_input.text().strip()
        port = self.port_input.text().strip()
        
        # 验证IP地址格式
        if not self.is_valid_ip(ip):
            QMessageBox.warning(None, "输入错误", "请输入有效的IP地址")
            return
        
        # 验证端口号
        try:
            port_num = int(port)
            if not (1 <= port_num <= 65535):
                raise ValueError
        except ValueError:
            QMessageBox.warning(None, "输入错误", "端口号必须为1-65535之间的整数")
            return
        
        self.accept()

    def is_valid_ip(self, ip):
        """简单的IP地址验证"""
        parts = ip.split('.')
        if len(parts) != 4:
            return False
        try:
            return all(0 <= int(part) < 256 for part in parts)
        except ValueError:
            return False

    def get_settings(self):
        """获取代理设置"""
        return (
            self.protocol_combo.currentText(),
            self.ip_input.text().strip(),
            self.port_input.text().strip()
        )


class ActionEvent(QObject):
    proxy_changed = pyqtSignal(object)  # 定义代理变更信号
    def __init__(self,current_proxy,main_window):
        super().__init__()
        self.main_window = main_window
        self.current_proxy = current_proxy

    def show_proxy_dialog(self):
        """显示代理设置对话框"""
        dialog = ProxyDialog(self.main_window)
        if dialog.exec_() == QDialog.Accepted:
            protocol, ip, port = dialog.get_settings()
            self.apply_proxy(protocol, ip, port)

    def apply_proxy(self, protocol, ip, port):
        """应用代理设置"""
        try:
            # 创建代理对象
            proxy = QNetworkProxy()
            
            # 设置代理类型
            if protocol == "HTTP":
                proxy.setType(QNetworkProxy.HttpProxy)
            elif protocol == "SOCKS5":
                proxy.setType(QNetworkProxy.Socks5Proxy)
            else:
                proxy.setType(QNetworkProxy.NoProxy)

            # 设置代理参数
            proxy.setHostName(ip)
            proxy.setPort(int(port))
            
            # 应用全局代理设置
            QNetworkProxy.setApplicationProxy(proxy)
            self.current_proxy = proxy
            self.main_window.statusBar().showMessage(f"代理已启用：{protocol} {ip}:{port}", 5000)
            self.proxy_changed.emit(proxy)  # 发射代理变更信号
            
        except Exception as e:
            QMessageBox.critical(self.main_window, "设置错误", f"代理设置失败：{str(e)}")

    def disable_proxy(self):
        """关闭代理"""
        QNetworkProxy.setApplicationProxy(QNetworkProxy(QNetworkProxy.NoProxy))
        self.current_proxy = None
        self.main_window.statusBar().showMessage("代理已关闭", 5000)
        self.proxy_changed.emit(None)  # 发射代理变更信号，关闭代理时传递 None

    