import 'dart:io';

const httpHeaders = {
  'Accept': '*/*',
  'Accept-Encoding': 'gzip, deflate, br',
  'Accept-Language': 'zh-CN,zh;q=0.9,en-US;q=0.8,en;q=0.7',
  'Connection': 'keep-alive',
  'Content-Length': '0',
  'Cookie':
      'gksskpitn=9d12726b-9ee5-4c3d-a4d8-b7c58d85f83f; sajssdk_2015_cross_new_user=1; sensorsdata2015jssdkcross=%7B%22distinct_id%22%3A%22176c77014ba8d6-0f29440b86745f-c791039-3686400-176c77014bb234%22%2C%22first_id%22%3A%22%22%2C%22props%22%3A%7B%22%24latest_traffic_source_type%22%3A%22%E8%87%AA%E7%84%B6%E6%90%9C%E7%B4%A2%E6%B5%81%E9%87%8F%22%2C%22%24latest_search_keyword%22%3A%22%E6%9C%AA%E5%8F%96%E5%88%B0%E5%80%BC%22%2C%22%24latest_referrer%22%3A%22https%3A%2F%2Fcn.bing.com%2F%22%2C%22%24latest_landing_page%22%3A%22https%3A%2F%2Ftime.geekbang.org%2F%22%7D%2C%22%24device_id%22%3A%22176c77014ba8d6-0f29440b86745f-c791039-3686400-176c77014bb234%22%7D; LF_ID=1609663780147-7978872-9659223; _ga=GA1.2.1545265956.1609663780; _gid=GA1.2.544738742.1609663780; GRID=6ac860b-9b18924-404dbec-8499eb8; SERVERID=1fa1f330efedec1559b3abbcb6e30f50|1609667520|1609663779; _gat=1; Hm_lvt_59c4ff31a9ee6263811b23eb921a5083=1609663810,1609663893,1609664387,1609667521; Hm_lpvt_59c4ff31a9ee6263811b23eb921a5083=1609667521; Hm_lvt_022f847c4e3acd44d4a2481d9187f1e6=1609663810,1609663893,1609664387,1609667521; Hm_lpvt_022f847c4e3acd44d4a2481d9187f1e6=1609667521; gk_process_ev={%22count%22:5%2C%22referrer%22:%22https://cn.bing.com/%22%2C%22target%22:%22page_course_list%22%2C%22utime%22:1609664387671%2C%22referrerTarget%22:%22page_course_list%22}',
  'DNT': '1',
  'Host': 'time.geekbang.org',
  'Origin': 'https://time.geekbang.org',
  'Referer': 'https://time.geekbang.org/',
  'sec-ch-ua':
      '"Google Chrome";v="87", " Not;A Brand";v="99", "Chromium";v="87"',
  'sec-ch-ua-mobile': '?0',
  'Sec-Fetch-Dest': 'empty',
  'Sec-Fetch-Mode': 'cors',
  'Sec-Fetch-Site': 'same-origin',
  'User-Agent':
      'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.88 Safari/537.36'
};
