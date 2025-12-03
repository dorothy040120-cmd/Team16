
#!/bin/bash

########################################
#  공부 타이머 / 포모도로 타이머 기능
########################################

# 카운트다운 함수 (분 단위를 받아서 초로 환산하여 1초 단위 출력)
run_countdown() {
    local minutes=$1
    local label=$2
    local total_seconds=$((minutes * 60))

    while [ $total_seconds -gt 0 ]; do
        local min=$((total_seconds / 60))
        local sec=$((total_seconds % 60))
        printf "\r[%s] 남은 시간: %02d:%02d " "$label" "$min" "$sec"
        sleep 1
        ((total_seconds--))
    done
    echo ""
}

# 포모도로 타이머 함수
study_timer() {
    # 기본값 설정: 25분 공부 / 5분 휴식 / 4회 반복
    work_min=${1:-25}
    break_min=${2:-5}
    cycles=${3:-4}

    echo ""
    echo "��� [포모도로 타이머 시작]"
    echo " - 공부: ${work_min}분"
    echo " - 휴식: ${break_min}분"
    echo " - 반복: ${cycles}회"
    echo ""

    for (( i=1; i<=cycles; i++ )); do
        echo "▶ 사이클 $i 공부 시작!"
        run_countdown "$work_min" "공부"

        echo "☕ 휴식 시작!"
        run_countdown "$break_min" "휴식"
        echo ""
    done

    echo "��� 모든 사이클 완료! 수고했어!!"
}

########################################
#  메인 실행부
########################################

if [ "$1" = "study" ]; then
    study_timer "$2" "$3" "$4"
else
    echo "사용법:"
    echo "  ./prodtool.sh study [공부시간] [휴식시간] [반복]"
    echo ""
    echo "예시:"
    echo "  ./prodtool.sh study"
    echo "  ./prodtool.sh study 40 10 3"
fi
    echo "  ./prodtool.sh study"
    echo "  ./prodtool.sh study 40 10 3"
fi

