import requests
import re
import argparse
from faker import Faker

fake = Faker()

# 创建命令行参数解析器
parser = argparse.ArgumentParser(
    description='检测 Adobe Client ID 泄露漏洞',
    formatter_class=argparse.RawTextHelpFormatter
)
parser.add_argument('-u', '--url', type=str, required=True, help='输入目标URL地址')

args = parser.parse_args()

# 构建请求头
headers = {
    'User-Agent': fake.user_agent(),
    'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8',
    'Accept-Language': 'en-US,en;q=0.5',
    'Connection': 'close'
}

# 漏洞检测正则表达式
vuln_pattern = re.compile(
    r'(?i)(?:adobe)(?:[0-9a-z\-_\t .]{0,20})(?:[\s|\']|[\s|"]){0,3}'
    r'(?:=|>|:=|\|\|:|<=|=>|:)(?:\'|"|\s|=|`){0,5}'
    r'([a-f0-9]{32})(?:[\'|"|\n|\r|\s|`|;]|$)'
)

try:
    # 发送 GET 请求
    response = requests.get(args.url, headers=headers, verify=False, timeout=10)
    
    # 检查响应状态
    if response.status_code == 200:
        # 在响应体中搜索敏感信息
        matches = vuln_pattern.findall(response.text)
        
        if matches:
            print(f"目标URL：{args.url}\n存在 Adobe Client ID 泄露：")
            for i, match in enumerate(set(matches), 1):
                print(f"{i}. {match}")
        else:
            print(f"目标URL：{args.url}\n未发现 Adobe Client ID")
    else:
        print(f"请求失败，状态码：{response.status_code}")

except Exception as e:
    print(f"检测过程中发生错误：{str(e)}")