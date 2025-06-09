import subprocess
import shlex
import os
from functools import lru_cache
import requests
from urllib.parse import urlparse
from requests.exceptions import Timeout, ConnectionError, SSLError, RequestException
from PyQt5.QtNetwork import QNetworkProxy
import paramiko
import configparser
# ---------------------- help_message 函数优化 ----------------------
@lru_cache(maxsize=128)  # 添加缓存，避免重复调用
def help_message(payload_address):
    """获取帮助信息（带缓存）"""
    command = ["python", payload_address, "--help"]  # 避免 shell=True
    try:
        result = subprocess.run(
            command,
            shell=False,    # 禁用 shell 减少进程开销
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            text=True,
            check=True      # 检查非零返回码时引发异常
        )
        return result.stdout
    except subprocess.CalledProcessError as e:
        # 部分程序将帮助信息输出到 stdout 或 stderr，合并处理
        return e.stdout or e.stderr or "Failed to get help message"
# ---------------------- run_command 函数优化 ----------------------
def run_command(cmd, payload_address,proxy=None):
    """执行命令（速度优化版）"""
    cmd_args = shlex.split(cmd)  # 安全拆分含空格的参数
    command = ["python", payload_address] + cmd_args  # 列表传参

    env = os.environ.copy()
    if proxy:
        if proxy.type() == QNetworkProxy.HttpProxy:
            proxy_url = f"http://{proxy.hostName()}:{proxy.port()}"
            env["HTTP_PROXY"] = proxy_url
            env["HTTPS_PROXY"] = proxy_url
        elif proxy.type() == QNetworkProxy.Socks5Proxy:
            proxy_url = f"socks5://{proxy.hostName()}:{proxy.port()}"
            env["HTTP_PROXY"] = proxy_url
            env["HTTPS_PROXY"] = proxy_url
    
    try:
        result = subprocess.run(
            command,
            shell=False,          # 禁用 shell 提升安全性
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            text=True,
            check=True,            # 自动捕获错误状态
            env=env
        )
        output = result.stdout
        error = result.stderr
        return_code = result.returncode
        
        if return_code == 0:
            return f"命令执行成功:\n{output}"
        else:
            return (
                f"命令失败 (code: {return_code})"
                f"\nSTDOUT: {output}"
                f"\nSTDERR: {error}"
            )
            
    except subprocess.CalledProcessError as e:
        # 结构化错误信息
        return (
            f"命令执行失败:\n {e}"
            f"\n可能是参数错误"
            f"\nSTDOUT: {e.stdout}"
            f"\nSTDERR: {e.stderr}"
        )
        
    except Exception as e:
        return f"Unexpected error: {str(e)}"
    
def test_url_connectivity(url, timeout=5):
    """
    测试 URL 连通性
    :param url: 目标 URL
    :param timeout: 请求超时时间（秒）
    :return: dict 包含状态、状态码、耗时、错误信息等
    """
    result = {
        "url": url,
        "success": False,
        "status_code": None,
        "reason": "",
        "response_time": None,
        "error": None
    }
    try:
        # 验证 URL 格式合法性
        parsed = urlparse(url)
        if not parsed.scheme or not parsed.netloc:
            raise ValueError("无效的URL格式")
        # 发送 GET 请求
        response = requests.get(url, timeout=timeout, allow_redirects=True)
        
        # 记录响应时间和状态码
        result.update({
            "success": 200 <= response.status_code < 500,
            "status_code": response.status_code,
            "reason": response.reason,
            "response_time": response.elapsed.total_seconds()
        })
    except Timeout:
        result["error"] = f"在{timeout}秒后超时"
    except ConnectionError:
        result["error"] = "DNS解析失败或连接被拒绝"
    except SSLError:
        result["error"] = "SSL证书验证失败"
    except ValueError as e:
        result["error"] = str(e)
    except RequestException as e:
        result["error"] = f"请求错误: {str(e)}"
        
    return result
def run_command_1(cmd, payload_address, proxy=None, config_path='config.ini'):
    """执行命令（速度优化版），支持从 ini 文件读取 SSH 配置并远程执行"""
    cmd_args = shlex.split(cmd)  # 安全拆分含空格的参数
    command = ["python", payload_address] + cmd_args  # 列表传参
    command_str = " ".join(command)  # 转换为字符串形式的命令

    config = configparser.ConfigParser()
    config.read(config_path)

    if 'ssh' in config and 'host' in config['ssh'] and 'user' in config['ssh'] and 'password' in config['ssh']:
        ssh_host = config['ssh']['host']
        ssh_port = int(config['ssh'].get('port', 22))
        ssh_user = config['ssh']['user']
        ssh_password = config['ssh']['password']

        try:
            # 创建 SSH 客户端实例
            ssh = paramiko.SSHClient()
            ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
            # 连接到远程主机
            ssh.connect(ssh_host, port=ssh_port, username=ssh_user, password=ssh_password)
            # 执行命令
            stdin, stdout, stderr = ssh.exec_command(command_str)
            # 获取命令执行结果
            output = stdout.read().decode('utf-8')
            error = stderr.read().decode('utf-8')
            return_code = stdout.channel.recv_exit_status()

            ssh.close()  # 关闭 SSH 连接

            if return_code == 0:
                return f"命令执行成功:\n{output}"
            else:
                return (
                    f"命令失败 (code: {return_code})"
                    f"\nSTDOUT: {output}"
                    f"\nSTDERR: {error}"
                )
        except Exception as e:
            return f"SSH 连接或命令执行出错: {str(e)}"
    else:
        env = os.environ.copy()
        if proxy:
            if proxy.type() == QNetworkProxy.HttpProxy:
                proxy_url = f"http://{proxy.hostName()}:{proxy.port()}"
                env["HTTP_PROXY"] = proxy_url
                env["HTTPS_PROXY"] = proxy_url
            elif proxy.type() == QNetworkProxy.Socks5Proxy:
                proxy_url = f"socks5://{proxy.hostName()}:{proxy.port()}"
                env["HTTP_PROXY"] = proxy_url
                env["HTTPS_PROXY"] = proxy_url

        try:
            result = subprocess.run(
                command,
                shell=False,          # 禁用 shell 提升安全性
                stdout=subprocess.PIPE,
                stderr=subprocess.PIPE,
                text=True,
                check=True,            # 自动捕获错误状态
                env=env
            )
            output = result.stdout
            error = result.stderr
            return_code = result.returncode

            if return_code == 0:
                return f"命令执行成功:\n{output}"
            else:
                return (
                    f"命令失败 (code: {return_code})"
                    f"\nSTDOUT: {output}"
                    f"\nSTDERR: {error}"
                )

        except subprocess.CalledProcessError as e:
            # 结构化错误信息
            return (
                f"命令执行失败:\n {e}"
                f"\n可能是参数错误"
                f"\nSTDOUT: {e.stdout}"
                f"\nSTDERR: {e.stderr}"
            )

        except Exception as e:
            return f"Unexpected error: {str(e)}"


# tool_cmd="python"
# tool_address="E:\shentou\sqlmap-1.8\sqlmap.py"
# cmd="--help"
# run_tool(cmd, tool_cmd, tool_address, async_mode=True, callback=handle_result)

# print(help_message('C:/Users/地/Desktop/python/bishe/poc/payload.py'))
# db = data.DBConnector('config.ini')
# # 执行 cmd.exe /c dir C:\ 命令，并获取命令的输出结果
# current_text = "蓝凌OA SQL注入漏洞"
# sql_query = ""
# sql_query = f"SELECT payload_address FROM payload where payload_name='{current_text}'"
# result = db.query(sql_query)
# file = ""
# if result is not None:
#     for row in result:
#         file = ', '.join(map(str, row))  # 将结果行转换为字符串
#         break

# command = "python " + file + " " + "-u http://39.107.224.48"
# try:
#     result = subprocess.run(command, shell=True, check=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)

#     if result.returncode == 0:
#         output = result.stdout
#         print("Command executed successfully:")
#         print(output)
#     else:
#         print(f"Command failed with return code {result.returncode}")
#         print("STDOUT:", result.stdout)
#         print("STDERR:", result.stderr)

# except subprocess.CalledProcessError as e:
#     print(f"Command execution failed with error: {e}" + "\n" + "可能是参数出现错误")
