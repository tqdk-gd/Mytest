#!/usr/bin/env python3
"""
Automated Web Security Scanner with HTML Report
Usage: python3 web_scanner.py -t target.com -n nuclei-templates/custom-rules.yaml
"""
import os
import sys
import json
import argparse
import subprocess
from collections import defaultdict
from pathlib import Path
from jinja2 import Template
from concurrent.futures import ThreadPoolExecutor

# 配置参数
BASE_DIR = Path(__file__).parent.resolve()
TOOLS = {
    'dirsearch': 'dirsearch/dirsearch.py',
    'subfinder': 'subfinder',
    'assetfinder': 'assetfinder',
    'httpx': 'httpx',
    'gau': 'gau',
    'nuclei': 'nuclei'
}

class WebScanner:
    def __init__(self, target, nuclei_templates):
        self.target = target
        self.nuclei_templates = Path(nuclei_templates)
        self.output_dir = BASE_DIR / f"scan_results/{self.target.replace('.','_')}_{os.getpid()}"
        self.data = {
            'directory_tree': {},
            'assets': defaultdict(list),
            'vulnerabilities': defaultdict(list)
        }
        
        self._init_dirs()
        self._check_tools()

    def _init_dirs(self):
        (self.output_dir / 'data').mkdir(parents=True, exist_ok=True)
        (self.output_dir / 'report').mkdir(exist_ok=True)

    def _check_tools(self):
        missing = [name for name, path in TOOLS.items() 
                  if not Path(path).exists() and not subprocess.run(f"which {name}", 
                  shell=True, capture_output=True).stdout]
        if missing:
            sys.exit(f"[错误] 缺少必要工具: {', '.join(missing)}")

    def run_command(self, cmd, output_file=None):
        try:
            result = subprocess.run(
                cmd, 
                shell=True, 
                check=True,
                capture_output=True,
                text=True
            )
            if output_file:
                with open(output_file, 'w') as f:
                    f.write(result.stdout)
            return result.stdout
        except subprocess.CalledProcessError as e:
            sys.exit(f"命令执行失败: {e}\n 错误输出: {e.stderr}")

    def directory_scan(self):
        print("[+] 正在进行目录扫描...")
        output_file = self.output_dir / 'data/dirsearch.json'
        cmd = f"python3 {TOOLS['dirsearch']} -u https://{self.target} -e '*' --format=json -o {output_file}"
        self.run_command(cmd)
        
        # 解析目录结构
        with open(output_file) as f:
            dir_data = json.load(f)
        self._build_directory_tree(dir_data['results'])

    def _build_directory_tree(self, results):
        tree = {}
        for item in results:
            current = tree
            path = item['url'].replace(f"https://{self.target}", "").lstrip('/')
            for part in path.split('/'):
                current = current.setdefault(part, {})
        self.data['directory_tree'] = tree

    def asset_discovery(self):
        print("[+] 正在进行资产收集...")
        with ThreadPoolExecutor() as executor:
            executor.submit(self._find_subdomains)
            executor.submit(self._collect_urls)

    def _find_subdomains(self):
        # 子域名发现
        subfinder_out = self.run_command(f"{TOOLS['subfinder']} -d {self.target} -silent")
        assetfinder_out = self.run_command(f"{TOOLS['assetfinder']} --subs-only {self.target}")
        all_subs = set(subfinder_out.splitlines() + assetfinder_out.splitlines())
        
        # 存活检测
        live_subs = self.run_command(
            f"echo '{os.linesep.join(all_subs)}' | {TOOLS['httpx']} -silent"
        ).splitlines()
        
        self.data['assets']['subdomains'] = live_subs
        self.data['assets']['subdomain_count'] = len(live_subs)

    def _collect_urls(self):
        # GAU收集
        gau_urls = self.run_command(
            f"{TOOLS['gau']} --subs {self.target}"
        ).splitlines()
        
        # 目录扫描结果中的URL
        dir_urls = []
        for item in (self.output_dir / 'data/dirsearch.json').read_text().splitlines():
            if '"url"' in item:
                dir_urls.append(item.split('"')[3])
        
        # 合并并去重
        all_urls = list(set(gau_urls + dir_urls + self.data['assets']['subdomains']))
        self.data['assets']['urls'] = all_urls
        (self.output_dir / 'data/merged_urls.txt').write_text('\n'.join(all_urls))
        
        # 统计文件类型
        ext_counts = defaultdict(int)
        for url in all_urls:
            ext = url.split('.')[-1].split('?')[0].lower()
            if ext in ['js','css','html','php','png','jpg','jpeg']:
                ext_counts[ext] +=1
        self.data['assets']['file_types'] = dict(ext_counts)

    def vulnerability_scan(self):
        print("[+] 正在进行漏洞扫描...")
        nuclei_output = self.output_dir / 'data/nuclei_results.json'
        cmd = f"{TOOLS['nuclei']} -l {self.output_dir/'data/merged_urls.txt'} " \
              f"-t {self.nuclei_templates} -severity low,medium,high,critical -json -o {nuclei_output}"
        self.run_command(cmd)
        
        # 处理结果
        with open(nuclei_output) as f:
            for line in f:
                vuln = json.loads(line)
                severity = vuln['info']['severity'].lower()
                self.data['vulnerabilities'][severity].append({
                    'template': vuln['template-id'],
                    'name': vuln['info']['name'],
                    'url': vuln['host'],
                    'description': vuln['info'].get('description', ''),
                    'severity': vuln['info']['severity']
                })

    def generate_report(self):
        print("[+] 正在生成可视化报告...")
        template = Template((BASE_DIR / 'template.html').read_text())
        report_html = template.render(
            target=self.target,
            directory_tree=self.data['directory_tree'],
            assets=self.data['assets'],
            vulnerabilities=self.data['vulnerabilities']
        )
        
        report_file = self.output_dir / 'report/full_report.html'
        report_file.write_text(report_html)
        print(f"\n[+] 扫描完成！报告已生成到: {report_file.resolve()}")

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('-t', '--target', required=True, help="目标网站")
    parser.add_argument('-n', '--nuclei-templates', required=True, 
                       help="Nuclei模板文件或目录")
    args = parser.parse_args()
    
    scanner = WebScanner(args.target, args.nuclei_templates)
    scanner.directory_scan()
    scanner.asset_discovery()
    scanner.vulnerability_scan()
    scanner.generate_report()
