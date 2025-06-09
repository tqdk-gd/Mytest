import requests
import argparse
from faker import Faker
import re

fake = Faker()
# 创建命令行参数解析器
parser = argparse.ArgumentParser(description='检测 Adobe ColdFusion 管理登录界面', formatter_class=argparse.RawTextHelpFormatter)
parser.add_argument('-u', '--url', type=str, help='输入目标 URL 发送 GET 请求')

args = parser.parse_args()

if args.url:
    base_url = args.url.rstrip('/')
    paths = [
        f"{base_url}/CFIDE/administrator/index.cfm",
        f"{base_url}/cfide/administrator/index.cfm"
    ]
else:
    print("Please provide a valid URL using -u or --url argument.")
    exit()

headers = {
    'User-Agent': fake.user_agent(),
    'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8',
    'Accept-Language': 'zh-CN,zh;q=0.8,zh-TW;q=0.7,zh-HK;q=0.5,en-US;q=0.3,en;q=0.2',
    'Accept-Encoding': 'gzip, deflate',
    'Upgrade-Insecure-Requests': '1',
    'Connection': 'close'
}

# 定义正则表达式列表
regex_patterns = [
    re.compile(r'ColdFusion Administrator Login'),
    re.compile(r'name="loginform" action="/CFIDE/administrator/enter.cfm"'),
    re.compile(r'background="/CFIDE/administrator/images/loginbackground.jpg"'),
    re.compile(r'Please enable Javascript to use ColdFusion Administrator')
]

for path in paths:
    try:
        response = requests.get(path, headers=headers, allow_redirects=True)
        if response.status_code == 200:
            # 检查所有正则表达式是否都匹配
            all_matched = True
            for pattern in regex_patterns:
                if not pattern.search(response.text):
                    all_matched = False
                    break
            if all_matched:
                print(f"目标 URL: {path}\n发现 Adobe ColdFusion 管理登录界面")
                break
    except requests.RequestException as e:
        print(f"请求 {path} 时出错: {e}")
else:
    print(f"目标 URL: {base_url}\n未发现 Adobe ColdFusion 管理登录界面")