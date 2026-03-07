#!/usr/bin/env python3
"""
arXiv论文搜索脚本
用于搜索Spatial AGI相关的最新论文
"""

import sys
import json
import urllib.request
import urllib.parse
import time
from datetime import datetime

def search_arxiv(query, max_results=20):
    """
    搜索arXiv论文
    
    Args:
        query: 搜索查询（如 "all:spatial+all:intelligence"）
        max_results: 最大结果数
    
    Returns:
        论文列表（JSON格式）
    """
    base_url = "http://export.arxiv.org/api/query?"
    
    # 构建查询URL
    params = {
        'search_query': query,
        'start': 0,
        'max_results': max_results,
        'sortBy': 'submittedDate',
        'sortOrder': 'descending'
    }
    
    url = base_url + urllib.parse.urlencode(params)
    
    print(f"🔍 搜索arXiv: {query}")
    print(f"📄 最多获取: {max_results} 篇论文")
    print(f"🔗 URL: {url}")
    
    try:
        # 发送请求
        with urllib.request.urlopen(url, timeout=30) as response:
            data = response.read().decode('utf-8')
        
        # 解析XML响应（简化版，只提取基本信息）
        papers = parse_arxiv_response(data)
        
        return papers
        
    except Exception as e:
        print(f"❌ 搜索失败: {e}")
        return []

def parse_arxiv_response(xml_data):
    """
    解析arXiv API返回的XML数据
    
    Args:
        xml_data: XML字符串
    
    Returns:
        论文列表
    """
    papers = []
    
    # 简单的XML解析（提取关键信息）
    import re
    
    # 提取所有entry
    entries = re.findall(r'<entry>(.*?)</entry>', xml_data, re.DOTALL)
    
    for entry in entries:
        paper = {}
        
        # 提取ID
        id_match = re.search(r'<id>(.*?)</id>', entry)
        if id_match:
            paper['arxiv_url'] = id_match.group(1)
            paper['arxiv_id'] = id_match.group(1).split('/')[-1]
        
        # 提取标题
        title_match = re.search(r'<title>(.*?)</title>', entry, re.DOTALL)
        if title_match:
            paper['title'] = title_match.group(1).strip()
        
        # 提取摘要
        summary_match = re.search(r'<summary>(.*?)</summary>', entry, re.DOTALL)
        if summary_match:
            paper['summary'] = summary_match.group(1).strip()
        
        # 提取作者
        authors = re.findall(r'<name>(.*?)</name>', entry)
        paper['authors'] = authors
        
        # 提取发布日期
        published_match = re.search(r'<published>(.*?)</published>', entry)
        if published_match:
            paper['published'] = published_match.group(1)
        
        # 生成PDF链接
        if 'arxiv_id' in paper:
            paper['pdf_url'] = f"https://arxiv.org/pdf/{paper['arxiv_id']}"
            paper['html_url'] = f"https://arxiv.org/html/{paper['arxiv_id']}"
        
        if paper:
            papers.append(paper)
    
    return papers

def save_results(papers, output_file):
    """
    保存搜索结果到JSON文件
    
    Args:
        papers: 论文列表
        output_file: 输出文件路径
    """
    with open(output_file, 'w', encoding='utf-8') as f:
        json.dump(papers, f, ensure_ascii=False, indent=2)
    
    print(f"✅ 结果已保存到: {output_file}")

def main():
    if len(sys.argv) < 2:
        print("用法: python3 search_arxiv.py <查询> [最大结果数]")
        print("示例: python3 search_arxiv.py 'all:spatial+all:intelligence' 20")
        sys.exit(1)
    
    query = sys.argv[1]
    max_results = int(sys.argv[2]) if len(sys.argv) > 2 else 20
    
    # 搜索论文
    papers = search_arxiv(query, max_results)
    
    if papers:
        # 打印结果
        print(f"\n📚 找到 {len(papers)} 篇论文:\n")
        for i, paper in enumerate(papers, 1):
            print(f"{i}. {paper.get('title', 'N/A')}")
            print(f"   arXiv: {paper.get('arxiv_url', 'N/A')}")
            print(f"   发布: {paper.get('published', 'N/A')[:10]}")
            print(f"   作者: {', '.join(paper.get('authors', ['N/A'])[:3])}")
            if len(paper.get('authors', [])) > 3:
                print(f"         ... 等{len(paper['authors'])}位作者")
            print()
        
        # 保存结果
        output_file = f"/tmp/today_papers_{datetime.now().strftime('%Y%m%d_%H%M%S')}.json"
        save_results(papers, output_file)
    else:
        print("❌ 未找到任何论文")

if __name__ == "__main__":
    main()
