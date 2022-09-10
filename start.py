#!/usr/bin/python3
# -*- coding: utf-8 -*-
import re
import sys
import json
import os
import requests


def main():
    if len(sys.argv) < 2:
        print("Usage: python3 start.py LeetCode-URL")
        sys.exit(1)

    url = sys.argv[1].split('?')[0]

    url_match = re.match(
        r'^https://leetcode.cn/problems/([\w|-]+)/?$', url)
    if url_match is None:
        print("Invalid URL")

    slug = url_match.group(1)

    if slug is None:
        print("Invalid URL")

    user_agent = "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36"
    data = {
        "operationName": "questionData",
        "query":
        "query questionData($titleSlug: String!) {question(titleSlug: $titleSlug) {questionFrontendId\n translatedTitle}}",
        "variables": {"titleSlug": slug}
    }
    req = requests.post('https://leetcode.cn/graphql/',
                        data=json.dumps(data).encode('utf-8'),
                        headers={'User-Agent': user_agent, 'Connection':
                                 'keep-alive', 'Content-Type': 'application/json',
                                 'Referer': url}, timeout=15)

    if req.status_code == 200:
        res = req.json()['data']['question']
        file_path = 'src/' + slug + '.sql'
        if not os.path.exists(file_path):
            with open('README.md', mode='a', encoding='utf-8') as f:
                f.write(
                    f'- [{res["questionFrontendId"]}. {res["translatedTitle"]}]({file_path}) <{url}>\n')

            with open(file_path, 'w', encoding='utf-8') as f:
                f.writelines([
                    '-- ' + res['questionFrontendId'] +
                    '. ' + res['translatedTitle'] + '\n',
                    '-- ' + url,
                    '\n'
                ])

                os.system(f'code {file_path}')
        else:
            print('File already exists: ' + file_path)
    else:
        print('HTTP Status Code: %s' % req.status_code)


if __name__ == "__main__":
    main()
