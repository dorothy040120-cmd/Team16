#!/bin/bash

# 랜덤 비밀번호 생성기
# 길이: $1
# 개수: $2

LENGTH=$1
COUNT=$2

CHARSET="A-Za-z0-9!@#$%^&*()_+=-"

# 인자 확인
if [ -z "$LENGTH" ] || [ -z "$COUNT" ]; then
    echo "사용법: ./pwgen.sh [길이] [개수]"
    exit 1
fi

# 비밀번호 생성 함수
generate_pw() {
    local len=$1
    tr -dc "$CHARSET" < /dev/urandom | head -c "$len"
}~

echo "비밀번호 생성기"
echo " - 길이: $LENGTH"
echo " - 개수: $COUNT"
echo ""

for ((i=1; i<=COUNT; i++)); do
    PW=$(generate_pw "$LENGTH")
    echo "$i) $PW"
done