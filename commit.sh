begin=$(expr $(cat ./begin) + 86400) 
end=$(date '+%s')

list=$(seq $begin 86400 $end)
after=''

for i in $list
do
    date -u --date=@$i '+%Y年%m月%d日：没有' >> ./data.md
    echo >> ./data.md

    sed -i '1{:a;N;'10'!b a};$d;N;P;D' ./readme.md
    tail ./data.md >> ./readme.md

    echo $i > ./begin
    
    git add ./data.md
    git add ./begin.md
    git add ./readme.md
    git commit --date=$i --message='happys GKD!'
done

git push origin HEAD