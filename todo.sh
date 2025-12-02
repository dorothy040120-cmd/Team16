#!/bin/bash

DB="todo.db"

# db 파일 없으면 생성
if [ ! -f "$DB" ]; then
    touch "$DB"
fi

# 다음 ID 계산 (파일이 비어있으면 1번부터 시작)
next_id() {
    if [ ! -s "$DB" ]; then
        echo 1
    else
        awk -F"|" 'END { print $1 + 1 }' "$DB"
    fi
}

case "$1" in

    add)
        if [ -z "$2" ]; then
            echo "사용법: ./todo.sh add \"내용\""
            exit 1
        fi
        ID=$(next_id)
        echo "$ID|0|$2" >> "$DB"
        echo "추가됨: $2"
        ;;

    list)
        if [ ! -s "$DB" ]; then
            echo "할 일이 없습니다."
            exit 0
        fi

        while IFS="|" read -r id done text; do
            if [ "$done" -eq 1 ]; then
                mark="✔"
            else
                mark=" "
            fi
            echo "[$mark] $id: $text"
        done < "$DB"
        ;;

    done)
        if [ -z "$2" ]; then
            echo "사용법: ./todo.sh done ID"
            exit 1
        fi
        sed -i "s/^$2|0|/$2|1|/" "$DB"
        echo "ID $2 완료 처리됨."
        ;;

    clear)
        grep "|0|" "$DB" > temp.db
        mv temp.db "$DB"
        echo "완료된 항목이 삭제되었습니다."
        ;;

    *)
        echo "사용법:"
        echo "  ./todo.sh add \"내용\""
        echo "  ./todo.sh list"
        echo "  ./todo.sh done ID"
        echo "  ./todo.sh clear"
        ;;
esac
