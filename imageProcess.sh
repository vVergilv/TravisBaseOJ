#!/user/bin/env bash

# 帮助文档
if [[ $1 = "--help" ]] || [[ $1 = "-h" ]]
then
    echo "========图片批处理脚本-帮助文档========"
    echo "
    用法示例：
    bash ${0} [Options]
    
    支持命令行参数方式使用不同功能
    支持对指定目录下所有支持格式的图片文件进行批处理
    支持以下常见图片批处理功能的单独使用或组合使用
    -h,--help       显示帮助文档
    -cm,--compress  支持对jpeg格式图片进行图片质量压缩 (1~100)
    -rs,--resize    支持对jpeg/png/svg格式图片在保持原始宽高比的前提下压缩分辨率
    -wm,--watermark 支持对图片批量添加自定义文本水印
    -rn,--rename    支持批量重命名（统一添加文件名前缀或后缀，不影响原始文件扩展名）
    -cv,--convert   支持将png/svg图片统一转换为jpg格式图片"
    exit 0
fi


# 各函数变量名的初始化
# 可修改，类似全局变量
quality=70
resize=30%
watermark="Vergil"
name="re_"
dir="./img" 
out="./output"
if_cm=0
if_rs=0
if_wm=0
if_rn=0
if_cn=0

# 图片的质量压缩函数
function jpegcompress() {
    path=($dir)
    for file in "$path"/*.png;do
        ( convert "$file" -compress JPEG -quality $quality "$out"/"compressed_${file##*/}.jpg")
    done
    echo "========图片质量压缩完成========"
}
# jpegcompress 

# 压缩分辨率函数,##.作用是删去最后一个.前的字符串，即取文件拓展名
function resolution() {
    path=($dir)
    for file in "$path"/*.*;do
        if [[  ${file##*.} == "jpg" ||  ${file##*.} == "svg" || ${file##*.} == "png" ]];then
            convert "$file" -resize $resize "$out"/"resolution_${file##*/}"
        fi
    done
    echo "=========分辨率压缩完成========="
    return
}
# resolution

# 添加水印的函数
function addwatermark() {
    path=($dir)
    for file in "$path"/*.*;do
        if [[  ${file##*.} == "jpg" || ${file##*.} == "png" ]];then
            convert "$file" -pointsize 50 -fill black -gravity center -draw "text 10,10 '$watermark'" "$out/wm_${file##*/}"              
        fi
    done
    echo "==========添加水印完成=========="
    return
}
# addwatermark

# 批量重命名
function rename() {
    path=($dir)
    for file in "$path"/*.*;do
             cp "$file"  "$out/$name${file##*/}"  
    done
    echo "=========批量重命名完成=========="
    return
}
# rename

function convert_to_jpg() {
    path=($dir)
    for file in "$path"/*.*;do
        if [[  ${file##*.} == "svg" || ${file##*.} == "png" ]];then
            file1=${file##*/}
            convert "$file" "$out/${file1%.*}.jpg"              
        fi
    done
    echo "==========转换格式完成=========="
    return
}
# convert_to_jpg

# 以下实现命令行参数方式使用不同功能
while true;do
    case "$1" in
        -cm|--compress) 
            if_cm=1; shift ;;               
        -rs|--resize)
            if_rs=1; shift ;;
        -wm|--watermark)
            if_wm=1; shift ;;
        -rn|--rename)
            if_rn=1; shift ;;
        -cn|--convert) 
            if_cn=1; shift ;;    
         "") break;;
    esac
done

# 主函数与输出重定向
log=log.txt
echo "程序开始运行" >$log 
echo "以下为shellcheck检查结果">>$log
shellcheck "$0">>$log  
if [[ $if_cm == 1 ]];then
    jpegcompress 2>>$log #2即标准错误输入文件
fi
if [[ $if_rs == 1 ]];then
    resolution 2>>$log
fi
if [[ $if_wm == 1 ]];then
    addwatermark 2>>$log
fi
if [[ $if_rn == 1 ]];then
    rename 2>>$log
fi
if [[ $if_cn == 1 ]];then
    convert_to_jpg 2>>$log
fi