# 第四次实验

## 实验环境
- 虚拟机：**Virtualbox**
  Ubuntu 20.04 Server 64bit
- 软件环境：**VScode,连接到虚拟机**
    - ShellCheck
    - Bash Debug
    - Bash IDE



---

## 实验要求
1. 上述任务的所有源代码文件必须单独提交并提供详细的`--help`脚本内置帮助信息
2. 任务二\三的所有统计数据结果要求写入独立实验报告



---



## 完成情况
线上测试情况![](https://travis-ci.com/vVergilv/TravisBaseOJ.svg?branch=master&status=passed)
#### 任务一：用bash编写一个图片批处理脚本，实现以下功能：
- [x] 支持命令行参数方式使用不同功能
- [x] 支持对指定目录下所有支持格式的图片文件进行批处理
- [x] 支持以下常见图片批处理功能的单独使用或组合使用
  - [x] 支持对jpeg格式图片进行图片质量压缩
  - [x] 支持对jpeg/png/svg格式图片在保持原始宽高比的前提下压缩分辨率
  - [x] 支持对图片批量添加自定义文本水印
  - [x] 支持批量重命名（统一添加文件名前缀或后缀，不影响原始文件扩展名）
  - [x] 支持将png/svg图片统一转换为jpg格式图片

#### 任务二：用bash编写一个文本批处理脚本，对以下附件分别进行批量处理完成相应的数据统计任务：

- [x] 统计不同年龄区间范围（20岁以下、[20-30]、30岁以上）的球员数量、百分比
- [x] 统计不同场上位置的球员数量、百分比
- [x] 名字最长的球员是谁？名字最短的球员是谁？
- [x] 年龄最大的球员是谁？年龄最小的球员是谁？

#### 任务三：用bash编写一个文本批处理脚本，对以下附件分别进行批量处理完成相应的数据统计任务：

- [x] 统计访问来源主机TOP 100和分别对应出现的总次数
- [x] 统计访问来源主机TOP 100 IP和分别对应出现的总次数
- [x] 统计最频繁被访问的URL TOP 100
- [x] 统计不同响应状态码的出现次数和对应百分比
- [x] 分别统计不同4XX状态码对应的TOP 10 URL和对应出现的总次数
- [x] 给定URL输出TOP 100访问来源主机



---



## 实验过程

### 课堂实验

1. 变量
```bash
#!/usr/bin/env bash
BIRTHDATE="Jan 1 2000"   # 填入一个字符串
Presents=10    # 填入一个整数
BIRTHDAY="Saturday"    # 使用命令替换方法赋值
```
![](./img/class_test.png)

2. 数组
```bash
NUMBERS=$(seq 1 10)  # 构造包含1到10整数的数组
STRINGS=("hello" "world")  # 构造分别包含hello和world字符串的数组
NumberOfNames=${#NAMES[@]} # 请使用动态计算数组元素个数的方法
second_name='Eric'  # 读取NAMES数组的第2个元素值进行赋值
```



1. 求2个数的最大公约数，要求：


```bash
#思路一：黑名单，对不同输入进行不同的报错并退出
#思路二：白名单，进行正则匹配，只有满足输入的两个参数是整数才可以运行下一步

#!/bin/bash
function cal_gcd(){
    m=$1
    if [[ $2 -lt $m ]]; then
    m=$2
    fi
    while [[ $m -ne 0 ]]; do
        x=$($1 % "$m")
        y=$($2 % "$m")
        if [[ $x -eq 0 && $y -eq 0 ]];then
            echo "gcd of $1 and $2 is $m"
            break
    fi
    m=$($m - 1)
    done
}

if [[ "$#" -ne 2 ]];then
    echo "The number of input must be 2"
# elif [[ false ]];then
#     echo ""
else 
    cal_gcd "$1" "$2"
fi





```



---



### 课后实验

**1. 任务一**

    用法示例：
    bash ${0} [Options]
    
    支持命令行参数方式使用不同功能
    支持对指定目录下所有支持格式的图片文件进行批处理
    支持以下常见图片批处理功能的单独使用或组合使用
    [Options]:
    -h,--help       显示帮助文档
    -cm,--compress  支持对jpeg格式图片进行图片质量压缩 (1~100)
    -rs,--resize    支持对jpeg/png/svg格式图片在保持原始宽高比的前提下压缩分辨率
    -wm,--watermark 支持对图片批量添加自定义文本水印
    -rn,--rename    支持批量重命名（统一添加文件名前缀或后缀，不影响原始文件扩展名）
    -cv,--convert   支持将png/svg图片统一转换为jpg格式图片"

```
shellcheck检查结果：（取一种情况作为示例）

In imageProcess.sh line 38:
    path=($dir)
          ^--^ SC2206: Quote to prevent word splitting/globbing, or split robustly with mapfile or read -a.


In imageProcess.sh line 39:
    for file in "$path"/*.png;do
                 ^---^ SC2128: Expanding an array without an index only gives the first element.


In imageProcess.sh line 40:
        ( convert "$file" -compress JPEG -quality $quality "$out"/"compressed_${file##*/}.jpg")
                                                                 ^-- SC2140: Word is of the form "A"B"C" (B indicated). Did you mean "ABC" or "A\"B\"C"?


In imageProcess.sh line 48:
    path=($dir)
          ^--^ SC2206: Quote to prevent word splitting/globbing, or split robustly with mapfile or read -a.


In imageProcess.sh line 49:
    for file in "$path"/*.*;do
                 ^---^ SC2128: Expanding an array without an index only gives the first element.


In imageProcess.sh line 51:
            convert "$file" -resize $resize "$out"/"resolution_${file##*/}"
                                                  ^-- SC2140: Word is of the form "A"B"C" (B indicated). Did you mean "ABC" or "A\"B\"C"?


In imageProcess.sh line 61:
    path=($dir)
          ^--^ SC2206: Quote to prevent word splitting/globbing, or split robustly with mapfile or read -a.


In imageProcess.sh line 62:
    for file in "$path"/*.*;do
                 ^---^ SC2128: Expanding an array without an index only gives the first element.


In imageProcess.sh line 74:
    path=($dir)
          ^--^ SC2206: Quote to prevent word splitting/globbing, or split robustly with mapfile or read -a.


In imageProcess.sh line 75:
    for file in "$path"/*.*;do
                 ^---^ SC2128: Expanding an array without an index only gives the first element.


In imageProcess.sh line 84:
    path=($dir)
          ^--^ SC2206: Quote to prevent word splitting/globbing, or split robustly with mapfile or read -a.


In imageProcess.sh line 85:
    for file in "$path"/*.*;do
                 ^---^ SC2128: Expanding an array without an index only gives the first element.

For more information:
  https://www.shellcheck.net/wiki/SC2128 -- Expanding an array without an ind...
  https://www.shellcheck.net/wiki/SC2140 -- Word is of the form "A"B"C" (B in...
  https://www.shellcheck.net/wiki/SC2206 -- Quote to prevent word splitting/g...
  ```

**2. 任务二**

用法示例：`bash ${0} [Options]` 
```
[Options]:

    -h          显示帮助文档
    -r          统计不同年龄区间范围（20岁以下、[20-30]、30岁以上）的球员数量、百分比
    -p          统计不同场上位置的球员数量、百分比
    -n          名字最长的球员是谁？名字最短的球员是谁？
    -a          年龄最大的球员是谁？年龄最小的球员是谁？
```
* 统计不同年龄区间范围（20岁以下、[20-30]、30岁以上）的球员数量、百分比
```
**************Age***************
Age under 20 amount and ratio           :    9  0.012
Age between 20 and 30 amount  and ratio :  600  0.815
Age greater than 30 amount and ratio    :  127  0.173
```
* 统计不同场上位置的球员数量、百分比
```
*****Position amount and Ratio*****
amount of Défenseur          1          Ratio: 0.001
amount of Midfielder       268          Ratio: 0.364
amount of Defender         236          Ratio: 0.321
amount of Forward          135          Ratio: 0.183
amount of Goalie            96          Ratio: 0.130
```
* 名字最长的球员是谁？名字最短的球员是谁？
```
*************Name Statistics*********************
Longest Name:   Francisco Javier Rodriguez
Shortest Name:  Jô
```

* 年龄最大的球员是谁？年龄最小的球员是谁？
```
*****************Age Most********************
Oldest:         Faryd Mondragon
Youngest:       Fabrice Olinga
```

**3. 任务三**

用法示例：`bash ${0} [Options]` 
```
[Options]:

    -h          显示帮助文档
    -o          输出访问来源主机TOP 100和分别对应出现的总次数          
    -p          输出访问来源主机TOP 100 IP和分别对应出现的总次数
    -m          统计最频繁被访问的URL TOP 100         
    -c          统计不同响应状态码的出现次数和对应百分比
    -f          分别统计不同4XX状态码对应的TOP 10 URL和对应出现的总次数
    -u          给定URL输出TOP 100访问来源主机
```

* 统计访问来源主机TOP 100和分别对应出现的总次数
```
=====TOP 100 Host And Its Total Apperance=====
Host:edams.ksc.nasa.gov                 Apperance:6530
Host:piweba4y.prodigy.com               Apperance:4846
Host:163.206.89.4                       Apperance:4791
Host:pc_ds                              Apperance:4608
Host:piweba5y.prodigy.com               Apperance:4607
Host:piweba3y.prodigy.com               Apperance:4416
Host:www-d1.proxy.aol.com               Apperance:3889
Host:www-b2.proxy.aol.com               Apperance:3534
Host:www-b3.proxy.aol.com               Apperance:3463
Host:www-c5.proxy.aol.com               Apperance:3423
Host:www-b5.proxy.aol.com               Apperance:3411
Host:www-c2.proxy.aol.com               Apperance:3407
Host:www-d2.proxy.aol.com               Apperance:3404
Host:www-a2.proxy.aol.com               Apperance:3337
Host:news.ti.com                        Apperance:3298
Host:www-d3.proxy.aol.com               Apperance:3296
Host:www-b4.proxy.aol.com               Apperance:3293
Host:www-c3.proxy.aol.com               Apperance:3272
Host:www-d4.proxy.aol.com               Apperance:3234
Host:www-c1.proxy.aol.com               Apperance:3177
Host:www-c4.proxy.aol.com               Apperance:3134
Host:intgate.raleigh.ibm.com            Apperance:3123
Host:www-c6.proxy.aol.com               Apperance:3088
Host:www-a1.proxy.aol.com               Apperance:3041
Host:mpngate1.ny.us.ibm.net             Apperance:3011
Host:e659229.boeing.com                 Apperance:2983
Host:piweba1y.prodigy.com               Apperance:2957
Host:webgate1.mot.com                   Apperance:2906
Host:www-relay.pa-x.dec.com             Apperance:2761
Host:beta.xerox.com                     Apperance:2318
Host:poppy.hensa.ac.uk                  Apperance:2311
Host:vagrant.vf.mmc.com                 Apperance:2237
Host:palona1.cns.hp.com                 Apperance:1910
Host:www-proxy.crl.research.digital.com Apperance:1793
Host:koriel.sun.com                     Apperance:1762
Host:derec                              Apperance:1681
Host:trusty.lmsc.lockheed.com           Apperance:1637
Host:gw2.att.com                        Apperance:1623
Host:cliffy.lfwc.lockheed.com           Apperance:1563
Host:inet2.tek.com                      Apperance:1503
Host:disarray.demon.co.uk               Apperance:1485
Host:gw1.att.com                        Apperance:1467
Host:128.217.62.1                       Apperance:1435
Host:interlock.turner.com               Apperance:1395
Host:163.205.1.19                       Apperance:1360
Host:sgigate.sgi.com                    Apperance:1354
Host:bocagate.bocaraton.ibm.com         Apperance:1336
Host:piweba2y.prodigy.com               Apperance:1324
Host:gw3.att.com                        Apperance:1311
Host:keyhole.es.dupont.com              Apperance:1310
Host:n1144637.ksc.nasa.gov              Apperance:1297
Host:163.205.3.104                      Apperance:1292
Host:163.205.156.16                     Apperance:1256
Host:163.205.19.20                      Apperance:1252
Host:erigate.ericsson.se                Apperance:1216
Host:gn2.getnet.com                     Apperance:1211
Host:gwa.ericsson.com                   Apperance:1089
Host:tiber.gsfc.nasa.gov                Apperance:1079
Host:128.217.62.2                       Apperance:1054
Host:bstfirewall.bst.bls.com            Apperance:1017
Host:163.206.137.21                     Apperance:1015
Host:spider.tbe.com                     Apperance:1013
Host:gatekeeper.us.oracle.com           Apperance:1010
Host:www-c8.proxy.aol.com               Apperance:995
Host:whopkins.sso.az.honeywell.com      Apperance:984
Host:news.dfrc.nasa.gov                 Apperance:966
Host:128.159.122.110                    Apperance:949
Host:proxy0.research.att.com            Apperance:940
Host:proxy.austin.ibm.com               Apperance:925
Host:www-c9.proxy.aol.com               Apperance:902
Host:bbuig150.unisys.com                Apperance:901
Host:corpgate.nt.com                    Apperance:899
Host:sahp315.sandia.gov                 Apperance:890
Host:amdext.amd.com                     Apperance:869
Host:128.159.132.56                     Apperance:848
Host:n1121796.ksc.nasa.gov              Apperance:830
Host:igate.uswest.com                   Apperance:825
Host:gatekeeper.cca.rockwell.com        Apperance:819
Host:wwwproxy.sanders.com               Apperance:815
Host:gw4.att.com                        Apperance:814
Host:goose.sms.fi                       Apperance:812
Host:128.159.144.83                     Apperance:808
Host:pc_nm                              Apperance:805
Host:jericho3.microsoft.com             Apperance:805
Host:128.159.111.141                    Apperance:798
Host:jericho2.microsoft.com             Apperance:786
Host:sdn_b6_f02_ip.dny.rockwell.com     Apperance:782
Host:lamar.d48.lilly.com                Apperance:778
Host:163.205.11.31                      Apperance:776
Host:heimdallp2.compaq.com              Apperance:772
Host:stortek1.stortek.com               Apperance:771
Host:163.205.16.75                      Apperance:762
Host:mac998.kip.apple.com               Apperance:759
Host:tia1.eskimo.com                    Apperance:742
Host:www-e1f.gnn.com                    Apperance:733
Host:www-b1.proxy.aol.com               Apperance:718
Host:reddragon.ksc.nasa.gov             Apperance:715
Host:128.159.122.137                    Apperance:711
Host:rmcg.cts.com                       Apperance:701
Host:bambi.te.rl.ac.uk                  Apperance:701
```

* 统计访问来源主机TOP 100 IP和分别对应出现的总次数
```
=====TOP 100 IP And Its Total Apperance=====
IP:163.206.89.4                         Apperance:4791
IP:128.217.62.1                         Apperance:1435
IP:163.205.1.19                         Apperance:1360
IP:163.205.3.104                        Apperance:1292
IP:163.205.156.16                       Apperance:1256
IP:163.205.19.20                        Apperance:1252
IP:128.217.62.2                         Apperance:1054
IP:163.206.137.21                       Apperance:1015
IP:128.159.122.110                      Apperance:949
IP:128.159.132.56                       Apperance:848
IP:128.159.144.83                       Apperance:808
IP:128.159.111.141                      Apperance:798
IP:163.205.11.31                        Apperance:776
IP:163.205.16.75                        Apperance:762
IP:128.159.122.137                      Apperance:711
IP:163.205.23.76                        Apperance:691
IP:206.27.25.1                          Apperance:672
IP:198.83.19.44                         Apperance:647
IP:199.1.50.225                         Apperance:641
IP:163.205.23.93                        Apperance:624
IP:139.169.174.102                      Apperance:610
IP:163.205.121.3                        Apperance:600
IP:140.229.116.37                       Apperance:598
IP:141.102.82.127                       Apperance:591
IP:163.206.140.4                        Apperance:586
IP:163.206.104.34                       Apperance:573
IP:204.62.245.32                        Apperance:567
IP:128.159.122.38                       Apperance:565
IP:128.217.62.224                       Apperance:563
IP:128.159.122.107                      Apperance:563
IP:128.159.122.180                      Apperance:553
IP:128.159.123.58                       Apperance:549
IP:163.205.154.11                       Apperance:544
IP:192.112.22.119                       Apperance:532
IP:163.205.16.100                       Apperance:518
IP:199.201.186.103                      Apperance:503
IP:128.159.146.40                       Apperance:503
IP:128.159.122.160                      Apperance:494
IP:192.77.40.4                          Apperance:486
IP:193.143.192.106                      Apperance:482
IP:152.163.192.5                        Apperance:480
IP:163.205.23.71                        Apperance:478
IP:139.169.30.50                        Apperance:475
IP:128.159.122.144                      Apperance:469
IP:163.234.140.22                       Apperance:466
IP:163.205.150.22                       Apperance:463
IP:128.217.61.184                       Apperance:457
IP:163.205.23.72                        Apperance:451
IP:198.83.19.40                         Apperance:448
IP:128.159.122.14                       Apperance:446
IP:199.201.186.104                      Apperance:443
IP:198.83.19.47                         Apperance:443
IP:128.217.61.15                        Apperance:443
IP:128.159.121.34                       Apperance:441
IP:128.159.121.41                       Apperance:438
IP:160.205.119.27                       Apperance:435
IP:163.205.154.17                       Apperance:432
IP:152.163.192.38                       Apperance:432
IP:128.159.122.15                       Apperance:432
IP:128.159.135.73                       Apperance:423
IP:128.159.135.38                       Apperance:423
IP:152.163.192.35                       Apperance:421
IP:128.159.76.128                       Apperance:415
IP:152.163.192.71                       Apperance:413
IP:128.159.63.159                       Apperance:412
IP:163.205.12.100                       Apperance:409
IP:133.53.64.33                         Apperance:404
IP:152.163.192.70                       Apperance:402
IP:128.159.121.64                       Apperance:397
IP:129.239.68.160                       Apperance:396
IP:152.163.192.36                       Apperance:391
IP:163.205.16.90                        Apperance:389
IP:128.32.196.94                        Apperance:389
IP:163.205.1.18                         Apperance:385
IP:163.206.136.1                        Apperance:384
IP:147.147.191.43                       Apperance:383
IP:163.205.16.104                       Apperance:374
IP:152.163.192.69                       Apperance:374
IP:193.178.53.180                       Apperance:373
IP:128.217.63.27                        Apperance:371
IP:130.110.74.81                        Apperance:367
IP:204.69.0.27                          Apperance:366
IP:163.206.130.46                       Apperance:365
IP:152.163.192.67                       Apperance:359
IP:163.205.54.76                        Apperance:357
IP:152.163.192.7                        Apperance:356
IP:198.83.19.43                         Apperance:354
IP:128.159.137.43                       Apperance:350
IP:147.74.110.61                        Apperance:348
IP:163.205.23.44                        Apperance:345
IP:128.159.168.162                      Apperance:343
IP:158.27.59.88                         Apperance:336
IP:152.163.192.3                        Apperance:336
IP:163.205.166.15                       Apperance:335
IP:128.159.145.21                       Apperance:335
IP:163.205.2.180                        Apperance:332
IP:128.217.61.98                        Apperance:329
IP:152.163.192.66                       Apperance:328
IP:163.205.3.38                         Apperance:324
IP:163.205.2.35                         Apperance:324
```

* 统计最频繁被访问的URL TOP 100
```
=====TOP 100 Url And Its Total Apperance=====
Url:/images/NASA-logosmall.gif                                  Apperance:97410
Url:/images/KSC-logosmall.gif                                   Apperance:75337
Url:/images/MOSAIC-logosmall.gif                                Apperance:67448
Url:/images/USA-logosmall.gif                                   Apperance:67068
Url:/images/WORLD-logosmall.gif                                 Apperance:66444
Url:/images/ksclogo-medium.gif                                  Apperance:62778
Url:/ksc.html                                                   Apperance:43687
Url:/history/apollo/images/apollo-logo1.gif                     Apperance:37826
Url:/images/launch-logo.gif                                     Apperance:35138
Url:/                                                           Apperance:30346
Url:/images/ksclogosmall.gif                                    Apperance:27810
Url:/shuttle/missions/sts-69/mission-sts-69.html                Apperance:24606
Url:/shuttle/countdown/                                         Apperance:24461
Url:/shuttle/missions/sts-69/count69.gif                        Apperance:24383
Url:/shuttle/missions/sts-69/sts-69-patch-small.gif             Apperance:23405
Url:/shuttle/missions/missions.html                             Apperance:22453
Url:/images/launchmedium.gif                                    Apperance:19877
Url:/htbin/cdt_main.pl                                          Apperance:17247
Url:/shuttle/countdown/images/countclock.gif                    Apperance:12160
Url:/icons/menu.xbm                                             Apperance:12137
Url:/icons/blank.xbm                                            Apperance:12057
Url:/software/winvn/winvn.html                                  Apperance:10345
Url:/icons/image.xbm                                            Apperance:10308
Url:/history/history.html                                       Apperance:10134
Url:/history/apollo/images/footprint-logo.gif                   Apperance:10126
Url:/history/apollo/images/apollo-small.gif                     Apperance:9439
Url:/history/apollo/images/footprint-small.gif                  Apperance:9230
Url:/software/winvn/winvn.gif                                   Apperance:9037
Url:/history/apollo/apollo.html                                 Apperance:8985
Url:/software/winvn/wvsmall.gif                                 Apperance:8662
Url:/software/winvn/bluemarb.gif                                Apperance:8610
Url:/htbin/cdt_clock.pl                                         Apperance:8583
Url:/shuttle/countdown/liftoff.html                             Apperance:7865
Url:/shuttle/resources/orbiters/orbiters-logo.gif               Apperance:7389
Url:/images/shuttle-patch-logo.gif                              Apperance:7261
Url:/history/apollo/apollo-13/apollo-13.html                    Apperance:7177
Url:/images/                                                    Apperance:7040
Url:/shuttle/countdown/video/livevideo2.gif                     Apperance:7029
Url:/images/kscmap-tiny.gif                                     Apperance:6615
Url:/shuttle/technology/sts-newsref/stsref-toc.html             Apperance:6517
Url:/history/apollo/apollo-13/apollo-13-patch-small.gif         Apperance:6309
Url:/shuttle/missions/sts-71/sts-71-patch-small.gif             Apperance:5613
Url:/shuttle/missions/sts-69/images/images.html                 Apperance:5264
Url:/icons/text.xbm                                             Apperance:5248
Url:/images/construct.gif                                       Apperance:5093
Url:/images/shuttle-patch-small.gif                             Apperance:4869
Url:/shuttle/missions/sts-69/movies/movies.html                 Apperance:4846
Url:/shuttle/missions/sts-70/sts-70-patch-small.gif             Apperance:4791
Url:/icons/unknown.xbm                                          Apperance:4785
Url:/shuttle/missions/sts-69/liftoff.html                       Apperance:4559
Url:/facilities/lc39a.html                                      Apperance:4464
Url:/shuttle/resources/orbiters/endeavour.html                  Apperance:4434
Url:/history/apollo/images/apollo-logo.gif                      Apperance:4365
Url:/shuttle/missions/sts-70/mission-sts-70.html                Apperance:4066
Url:/images/lc39a-logo.gif                                      Apperance:4024
Url:/shuttle/resources/orbiters/endeavour-logo.gif              Apperance:3817
Url:/shuttle/technology/sts-newsref/sts_asm.html                Apperance:3706
Url:/shuttle/countdown/countdown.html                           Apperance:3518
Url:/shuttle/missions/sts-71/movies/movies.html                 Apperance:3507
Url:/shuttle/countdown/video/livevideo.jpeg                     Apperance:3377
Url:/history/apollo/apollo-11/apollo-11.html                    Apperance:3140
Url:/shuttle/missions/sts-71/mission-sts-71.html                Apperance:3130
Url:/shuttle/missions/sts-70/images/images.html                 Apperance:3087
Url:/shuttle/missions/sts-71/images/images.html                 Apperance:2945
Url:/shuttle/missions/sts-73/mission-sts-73.html                Apperance:2939
Url:/images/faq.gif                                             Apperance:2865
Url:/shuttle/technology/images/srb_mod_compare_1-small.gif      Apperance:2864
Url:/shuttle/technology/images/srb_mod_compare_3-small.gif      Apperance:2818
Url:/shuttle/technology/images/srb_mod_compare_6-small.gif      Apperance:2715
Url:/history/apollo/apollo-11/apollo-11-patch-small.gif         Apperance:2701
Url:/elv/elvpage.htm                                            Apperance:2586
Url:/shuttle/missions/sts-73/sts-73-patch-small.gif             Apperance:2544
Url:/shuttle/countdown/video/sts-69-prelaunch-pad.gif           Apperance:2385
Url:/shuttle/missions/51-l/mission-51-l.html                    Apperance:2343
Url:/images/launch-small.gif                                    Apperance:2293
Url:/facilities/tour.html                                       Apperance:2256
Url:/shuttle/missions/51-l/51-l-patch-small.gif                 Apperance:2201
Url:/images/kscmap-small.gif                                    Apperance:2172
Url:/shuttle/resources/orbiters/challenger.html                 Apperance:2171
Url:/shuttle/missions/sts-71/movies/sts-71-launch.mpg           Apperance:2159
Url:/shuttle/technology/sts-newsref/sts-lcc.html                Apperance:2146
Url:/htbin/wais.pl                                              Apperance:2133
Url:/facts/about_ksc.html                                       Apperance:2120
Url:/history/mercury/mercury.html                               Apperance:2107
Url:/images/mercury-logo.gif                                    Apperance:2040
Url:/elv/elvhead3.gif                                           Apperance:1991
Url:/images/launchpalms-small.gif                               Apperance:1979
Url:/images/whatsnew.gif                                        Apperance:1936
Url:/history/apollo/apollo-spacecraft.txt                       Apperance:1929
Url:/facilities/vab.html                                        Apperance:1915
Url:/shuttle/resources/orbiters/columbia.html                   Apperance:1912
Url:/shuttle/countdown/lps/fr.html                              Apperance:1908
Url:/shuttle/resources/orbiters/challenger-logo.gif             Apperance:1904
Url:/images/ksclogo.gif                                         Apperance:1892
Url:/whats-new.html                                             Apperance:1891
Url:/elv/endball.gif                                            Apperance:1874
Url:/history/apollo/apollo-13/apollo-13-info.html               Apperance:1869
Url:/shuttle/missions/sts-74/mission-sts-74.html                Apperance:1868
Url:/elv/PEGASUS/minpeg1.gif                                    Apperance:1845
Url:/elv/SCOUT/scout.gif                                        Apperance:1835
```
* 统计不同响应状态码的出现次数和对应百分比
```
=====Status Code,The number of occurrences,Ratio=====
Status:200      Times: 1398987  Ratio:0.891
Status:302      Times:   26497  Ratio:0.017
Status:304      Times:  134146  Ratio:0.085
Status:403      Times:     171  Ratio:0.000
Status:404      Times:   10055  Ratio:0.006
Status:500      Times:       3  Ratio:0.000
Status:501      Times:      27  Ratio:0.000
```

* 分别统计不同4XX状态码对应的TOP 10 URL和对应出现的总次数
```
=Top 10 URLs Corresponding To Status Codes And The Total Number Of Occurrences=
===Status:403===
Url:/software/winvn/winvn.html/wvsmall.gif                      Apperance:32
Url:/software/winvn/winvn.html/winvn.gif                        Apperance:32
Url:/software/winvn/winvn.html/bluemarb.gif                     Apperance:32
Url:/ksc.html/images/ksclogo-medium.gif                         Apperance:12
Url:/ksc.html/images/WORLD-logosmall.gif                        Apperance:10
Url:/ksc.html/images/USA-logosmall.gif                          Apperance:10
Url:/ksc.html/images/NASA-logosmall.gif                         Apperance:10
Url:/ksc.html/images/MOSAIC-logosmall.gif                       Apperance:10
Url:/ksc.html/facts/about_ksc.html                              Apperance:5
Url:/ksc.html/shuttle/missions/missions.html                    Apperance:4
===Status:404===
Url:/pub/winvn/readme.txt                                       Apperance:1337
Url:/pub/winvn/release.txt                                      Apperance:1185
Url:/shuttle/missions/STS-69/mission-STS-69.html                Apperance:683
Url:/images/nasa-logo.gif                                       Apperance:319
Url:/shuttle/missions/sts-68/ksc-upclose.gif                    Apperance:253
Url:/elv/DELTA/uncons.htm                                       Apperance:209
Url:/history/apollo/sa-1/sa-1-patch-small.gif                   Apperance:200
Url:/images/crawlerway-logo.gif                                 Apperance:160
Url:/history/apollo/a-001/a-001-patch-small.gif                 Apperance:154
Url:/history/apollo/pad-abort-test-1/pad-abort-test-1-patch-small.gif   Apperance:144
```
* 给定URL输出TOP 100访问来源主机,测试用的url=`/pub/winvn/readme.txt`
```
===============Show Url for /pub/winvn/readme.txt       ===
Host:www-e1f.gnn.com                                            Apperance:12
Host:pm1                                                        Apperance:7
Host:www-proxy.crl.research.digital.com                         Apperance:5
Host:slip37-71.il.us.ibm.net                                    Apperance:5
Host:pm-jv1-174.coastalnet.com                                  Apperance:5
Host:piweba4y.prodigy.com                                       Apperance:5
Host:discovery.lanl.gov                                         Apperance:5
Host:van03071.direct.ca                                         Apperance:4
Host:tia1.eskimo.com                                            Apperance:4
Host:port7.toj.com                                              Apperance:4
Host:ip162.phx.primenet.com                                     Apperance:4
Host:guli601.pn.itnet.it                                        Apperance:4
Host:arnetpc-210.arn.net                                        Apperance:4
Host:136.186.85.196                                             Apperance:4
Host:www-relay.pa-x.dec.com                                     Apperance:3
Host:weird.stardust.com                                         Apperance:3
Host:unlinfo2.unl.edu                                           Apperance:3
Host:torii.usask.ca                                             Apperance:3
Host:sophocles.algonet.se                                       Apperance:3
Host:slip7.cei.net                                              Apperance:3
Host:sanantonio-1-14.i-link.net                                 Apperance:3
Host:rsilvers.vnet.net                                          Apperance:3
Host:proxy.kodak.com                                            Apperance:3
Host:port13.netdoor.com                                         Apperance:3
Host:pm-mhc2-218.coastalnet.com                                 Apperance:3
Host:piweba1y.prodigy.com                                       Apperance:3
Host:ns2.centerbank.com                                         Apperance:3
Host:news.ti.com                                                Apperance:3
Host:netd-253-181.beth.mmc.com                                  Apperance:3
Host:modem0.ianet.net                                           Apperance:3
Host:lawrencetown-ts-08.nstn.ca                                 Apperance:3
Host:lankford.mindspring.com                                    Apperance:3
Host:ix-als-il1-01.ix.netcom.com                                Apperance:3
Host:h-antiquary.nr.infi.net                                    Apperance:3
Host:h132_197_8_121.gte.com                                     Apperance:3
Host:ftp.mel.aone.net.au                                        Apperance:3
Host:dslip12.itek.net                                           Apperance:3
Host:dewey.disney.com                                           Apperance:3
Host:dd15-008.compuserve.com                                    Apperance:3
Host:dd11-007.compuserve.com                                    Apperance:3
Host:cs27port.netvoyage.net                                     Apperance:3
Host:crc2-fddi.cris.com                                         Apperance:3
Host:cabk.ftech.co.uk                                           Apperance:3
Host:buffnet1.buffnet.net                                       Apperance:3
Host:annex022.ridgecrest.ca.us                                  Apperance:3
Host:acca.nmsu.edu                                              Apperance:3
Host:156.26.70.26                                               Apperance:3
Host:yyj-ppp-12.cyberstore.ca                                   Apperance:2
Host:www-e1e.gnn.com                                            Apperance:2
Host:www-b2.proxy.aol.com                                       Apperance:2
Host:vivaldi.imed.missouri.edu                                  Apperance:2
Host:van14405.direct.ca                                         Apperance:2
Host:van14391.direct.ca                                         Apperance:2
Host:van08223.direct.ca                                         Apperance:2
Host:van08216.direct.ca                                         Apperance:2
Host:van07199.direct.ca                                         Apperance:2
Host:van02052.direct.ca                                         Apperance:2
Host:van02040.direct.ca                                         Apperance:2
Host:van02035.direct.ca                                         Apperance:2
Host:ts01-sb-2.skyenet.net                                      Apperance:2
Host:ts01-ind-21.iquest.net                                     Apperance:2
Host:trujill.larc.nasa.gov                                      Apperance:2
Host:tlh1.supernet.net                                          Apperance:2
Host:teal.ksc.nasa.gov                                          Apperance:2
Host:srq005.packet.net                                          Apperance:2
Host:spui-08.denhaag.dataweb.nl                                 Apperance:2
Host:slip49-83.ca.us.ibm.net                                    Apperance:2
Host:slip23.fgi.net                                             Apperance:2
Host:shawp3.ppath.uiuc.edu                                      Apperance:2
Host:sgs.clark.net                                              Apperance:2
Host:s53.tucslip.indirect.com                                   Apperance:2
Host:s1.destiny.com.tw                                          Apperance:2
Host:rudic.slip.lm.com                                          Apperance:2
Host:rrhodes.pdial.interpath.net                                Apperance:2
Host:rickpc.cits.nova.edu                                       Apperance:2
Host:rcwusr.bp.com                                              Apperance:2
Host:rclee.lax.primenet.com                                     Apperance:2
Host:proxy.siemens.co.at                                        Apperance:2
Host:ppp83.texoma.com                                           Apperance:2
Host:ppp32.texoma.com                                           Apperance:2
Host:ppp1.globalone.net                                         Apperance:2
Host:ppp09-01.rns.tamu.edu                                      Apperance:2
Host:pped04.tamu.edu                                            Apperance:2
Host:port20.annex2.nwlink.com                                   Apperance:2
Host:port18.modem1.cc.swt.edu                                   Apperance:2
Host:port12.axs.net                                             Apperance:2
Host:pm-mhc2-211.coastalnet.com                                 Apperance:2
Host:pm-gv1-79.coastalnet.com                                   Apperance:2
Host:pm2e1-26.valleynet.com                                     Apperance:2
Host:pm2-18.tvs.net                                             Apperance:2
Host:pm1-25.aug.com                                             Apperance:2
Host:pm1-11.conline.com                                         Apperance:2
Host:piweba5y.prodigy.com                                       Apperance:2
Host:piweba2y.prodigy.com                                       Apperance:2
Host:piranha.business.swt.edu                                   Apperance:2
Host:pc085.mikrolog.fi                                          Apperance:2
Host:orion.accessone.com                                        Apperance:2
Host:ns.kidsoft.com                                             Apperance:2
Host:neworleans-1-5.i-link.net                                  Apperance:2
Host:newglasgow-ts-15.nstn.ca                                   Apperance:2
```

## 参考资料


* [如何使用imageMagick](https://segmentfault.com/a/1190000015210920)

* [LyuLumos师哥实验报告](https://github.com/EddieXu1125/linux-2020-LyuLumos/blob/ch0x04)
* [padresvater实验报告](https://github.com/CUCCS/2021-linux-public-padresvater/blob/chap0x04/)
* [EddiXu实验报告](https://github.com/CUCCS/2021-linux-public-EddieXu1125/tree/chap0x04)
