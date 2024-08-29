#!/bin/bash

# 定义下载的文件列表
urls=(
  "https://mirror.ghproxy.com/raw.githubusercontent.com/qq5460168/666/master/dns.txt/"
  "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts" #https://github.com/StevenBlack/hosts
  "https://raw.githubusercontent.com/jdlingyu/ad-wars/master/hosts" #奖励形式广告、爱奇艺、小米视频、腾讯视频、搜狐视频等
  "https://raw.githubusercontent.com/tiuxo/hosts/master/ads"
  "https://raw.githubusercontent.com/217heidai/adblockfilters/main/rules/adblockdns.txt" #heidai
  "https://raw.githubusercontent.com/liwenjie119/adg-rules/master/black.txt" #LWJ's black list
  "https://adguardteam.github.io/HostlistsRegistry/assets/filter_21.txt" #CHN: anti-AD
  "https://adguardteam.github.io/HostlistsRegistry/assets/filter_29.txt" #CHN: AdRules DNS List
   "https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/doh-vpn-proxy-bypass.txt" #HaGeZi's Encrypted
  "https://adguardteam.github.io/HostlistsRegistry/assets/filter_23.txt" #WindowsSpyBlocker - Hosts spy rules


)

# 临时文件夹
temp_dir=$(mktemp -d)
echo "在 $temp_dir 创建临时目录"

# 下载文件
for url in "${urls[@]}"; do
  echo "正在下载 $url"
  curl -sL "$url" -o "${temp_dir}/$(basename "$url")"
done

# 合并文件
echo "合并中......"
cat "${temp_dir}"/* > rules.txt

# 清理临时文件
echo "清理临时文件......"
rm -rf "$temp_dir"

# 去除重复行和以#或!开头的行
echo "去除重复行和以#、!、/开头的行......"
sort rules.txt | uniq | grep -vE '^(#|!|/)' > rules_cleaned.txt

# 重命名清理后的文件为rules.txt
mv rules_cleaned.txt .././rules.txt


echo "rules.txt去广告规则已创建......"