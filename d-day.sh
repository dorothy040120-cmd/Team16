#!/bin/bash

# 날짜 입력 확인
if [ -z "$1" ]; then
    echo "사용법: ./d-day.sh YYYY-MM-DD"
    exit 1
fi

target="$1"

# 입력 받은 날짜에서 숫자만 추출 (YYYYMMDD)
d=${target//-/}

# yyyy mm dd 잘라내기
YEAR=${d:0:4}
MONTH=${d:4:2}
DAY=${d:6:2}

# 오늘 날짜 가져오기 (YYYYMMDD 형식)
TODAY=$(date +%Y%m%d)

# 날짜 차이 계산 (초 단위 후 일수로 변환)
target_sec=$(date -d "$YEAR-$MONTH-$DAY" +%s)
today_sec=$(date -d "$TODAY" +%s)

diff=$(( (target_sec - today_sec) / 86400 ))

# 출력 형식
if [ $diff -eq 0 ]; then
    echo "D-Day"
elif [ $diff -gt 0 ]; then
    echo "D-$diff"
else
    echo "D+$((-diff))"
fi
