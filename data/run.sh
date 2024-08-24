#!/bin/bash

# 定义下载的文件列表
urls=(
  "https://raw.githubusercontent.com/qq5460168/dangchu/main/black.txt" #5460
  "https://raw.githubusercontent.com/damengzhu/banad/main/jiekouAD.txt" #大萌主
  "https://raw.githubusercontent.com/afwfv/DD-AD/main/rule/DD-AD.txt"  #DD
  "https://raw.gitmirror.com/Cats-Team/dns-filter/main/abp.txt" #AdRules DNS Filter
  "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts" #https://github.com/StevenBlack/hosts
  "https://raw.githubusercontent.com/jdlingyu/ad-wars/master/hosts" #奖励形式广告、爱奇艺、小米视频、腾讯视频、搜狐视频等
  "https://raw.githubusercontent.com/tiuxo/hosts/master/ads"
  "https://raw.githubusercontent.com/217heidai/adblockfilters/main/rules/adblockdns.txt" #heidai
  "https://raw.githubusercontent.com/liwenjie119/adg-rules/master/black.txt" #LWJ's black list
  "https://adguardteam.github.io/HostlistsRegistry/assets/filter_21.txt" #CHN: anti-AD
  "https://adguardteam.github.io/HostlistsRegistry/assets/filter_29.txt" #CHN: AdRules DNS List
  "https://raw.githubusercontent.com/qq5460168/dangchu/main/white.txt" #白名单
  "https://raw.githubusercontent.com/loveqqzj/AdGuard/master/Mobile.txt" #loveqqzj
  "https://raw.githubusercontent.com/mphin/AdGuardHomeRules/main/Blacklist.txt" #mphin
  "https://gitee.com/zjqz/ad-guard-home-dns/raw/master/black-list" #周木木
  "https://raw.githubusercontent.com/liwenjie119/adg-rules/master/black.txt" #liwenjie119
   "https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/doh-vpn-proxy-bypass.txt" #HaGeZi's Encrypted
  "https://adguardteam.github.io/HostlistsRegistry/assets/filter_23.txt" #WindowsSpyBlocker - Hosts spy rules
)

# 临时文件夹
temp_dir=$(mktemp -d)
echo "Temporary directory created at $temp_dir"

# 下载文件并合并
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
echo "去除重复行和以#或!开头的行......"
sort rules.txt | uniq | grep -vE '^(#|!|/)' > rules_cleaned.txt

# 重命名清理后的文件为rules.txt
mv rules_cleaned.txt .././rules.txt


echo "rules.txt has been created with unique lines and without lines starting with # or !"