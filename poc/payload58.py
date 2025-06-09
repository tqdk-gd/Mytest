import requests
import argparse

# 创建命令行参数解析器
parser = argparse.ArgumentParser(description='通过错误页面检测运行中的 Adobe ColdFusion 实例。')
parser.add_argument('-u', '--url', type=str, help='输入目标基础 URL，用于发送 GET 请求')

args = parser.parse_args()

if not args.url:
    print("请使用 -u 或 --url 参数提供有效的基础 URL。")
    exit()

# 构建完整请求 URL
base_url = args.url.rstrip('/')
target_url = f"{base_url}/_something_.cfm"

# 设置请求头
headers = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101 Firefox/68.0',
    'Accept-Encoding': 'gzip, deflate',
    'Accept': '*/*'
}

try:
    # 发送 GET 请求
    response = requests.get(target_url, headers=headers)
    # 检查状态码和响应体内容
    if response.status_code == 404 and 'ColdFusion documentation' in response.text:
        print(f"目标 URL: {base_url}\n存在漏洞检测到运行中的 Adobe ColdFusion 实例。")
    else:
        print(f"目标 URL: {base_url}\n不存在漏洞未检测到运行中的 Adobe ColdFusion 实例。")
except requests.RequestException as e:
    print(f"请求发生错误: {e}")