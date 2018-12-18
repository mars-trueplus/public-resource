# -*- coding: utf-8 -*-

from bs4 import BeautifulSoup as BS
import requests
import re

DOWNLOAD_URL = 'https://secure.php.net/get/php-{php_version}.tar.gz/from/this/mirror'
MAGENTO_DOWNLOAD_URL = 'https://github.com/magento/magento2/archive/{magento_version}.tar.gz'


def get_versions(url):
    data = requests.get(url).text
    soup = BS(data, 'html.parser')
    res = []
    soup_resp = soup.find_all('a', href=re.compile('/from/a/mirror'), string=re.compile('tar.gz'))
    for r in soup_resp:
        # find all numbers in string
        nums = re.findall(r'\d+', r.text)
        version = '.'.join(nums)
        res.append(version)
    return res


def get_stable_versions():
    url = 'http://php.net/downloads.php'
    res = get_versions(url)
    return res


def get_unsupported_versions():
    url = 'http://php.net/releases'
    res = get_versions(url)
    return res


if __name__ == '__main__':
    stables = get_stable_versions()
    unsupported = get_unsupported_versions()
    all = stables + unsupported
    all = sorted(all, reverse=True)
    with open('php_version.txt', 'w') as f:
        f.write('\n'.join(all))
