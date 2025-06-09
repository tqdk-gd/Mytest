import requests
import argparse
from faker import Faker
import hashlib

fake = Faker()
# 创建命令行参数解析器
parser = argparse.ArgumentParser(description='基于徽标检测 Adobe ColdFusion 实例的版本号。', formatter_class=argparse.RawTextHelpFormatter)
parser.add_argument('-u', '--url', type=str, help='输入目标 URL 以发送 GET 请求')

args = parser.parse_args()

if not args.url:
    print("请使用 -u 或 --url 参数提供有效的 URL。")
    exit()

base_url = args.url.rstrip('/')
paths = [
    f"{base_url}/CFIDE/administrator/images/mx_login.gif",
    f"{base_url}/cfide/administrator/images/mx_login.gif",
    f"{base_url}/CFIDE/administrator/images/background.jpg",
    f"{base_url}/cfide/administrator/images/background.jpg",
    f"{base_url}/CFIDE/administrator/images/componentutilslogin.jpg",
    f"{base_url}/cfide/administrator/images/componentutilslogin.jpg"
]

headers = {
    'User-Agent': fake.user_agent(),
    'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8',
    'Accept-Language': 'zh-CN,zh;q=0.8,zh-TW;q=0.7,zh-HK;q=0.5,en-US;q=0.3,en;q=0.2',
    'Accept-Encoding': 'gzip, deflate',
    'Upgrade-Insecure-Requests': '1',
    'Connection': 'close'
}

version_md5_mapping = {
    "coldfusion-8": "da07693b70ddbac5bc0d8bf98d4a3539",
    "coldfusion-9": "c0757351b00f7ecf35a035c976068d12",
    "coldfusion-10": "a4c81b7a6289b2fc9b36848fa0cae83c",
    "coldfusion-11": "7f024de9f480481ca03049e0d66679d6",
    "coldfusion-2016": "f1281b6866aef66e35dc36fe4f0bf990",
    "coldfusion-2021": "a88530d7f1980412dac076de732a4e86",
    "coldfusion-2018": "92ef6ee3c4d1700e3cca797b19d3e7ba",
    "coldfusion-mx-7": "cb594e69af5ba15bca453f76aca53615"
}

def calculate_md5(content):
    """计算内容的 MD5 哈希值"""
    md5_hash = hashlib.md5()
    md5_hash.update(content)
    return md5_hash.hexdigest()

for path in paths:
    try:
        response = requests.get(path, headers=headers, allow_redirects=True, max_redirects=2)
        if response.status_code == 200:
            md5_hash = calculate_md5(response.content)
            for version, expected_md5 in version_md5_mapping.items():
                if md5_hash == expected_md5:
                    print(f"目标 URL: {base_url}\n存在漏洞，检测到 Adobe ColdFusion 版本: {version}")
                    break
            else:
                continue
            break
    except requests.RequestException as e:
        print(f"请求 {path} 时出错: {e}")
else:
    print(f"目标 URL: {base_url}\n不存在漏洞未检测到 Adobe ColdFusion 版本")