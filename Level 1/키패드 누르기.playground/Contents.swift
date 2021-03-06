/**
 난이도: Level 1 (2020 카카오 인턴십)
 
 문제 설명
 스마트폰 전화 키패드의 각 칸에 다음과 같이 숫자들이 적혀 있습니다.

 kakao_phone1.png

 이 전화 키패드에서 왼손과 오른손의 엄지손가락만을 이용해서 숫자만을 입력하려고 합니다.
 맨 처음 왼손 엄지손가락은 * 키패드에 오른손 엄지손가락은 # 키패드 위치에서 시작하며, 엄지손가락을 사용하는 규칙은 다음과 같습니다.

 엄지손가락은 상하좌우 4가지 방향으로만 이동할 수 있으며 키패드 이동 한 칸은 거리로 1에 해당합니다.
 왼쪽 열의 3개의 숫자 1, 4, 7을 입력할 때는 왼손 엄지손가락을 사용합니다.
 오른쪽 열의 3개의 숫자 3, 6, 9를 입력할 때는 오른손 엄지손가락을 사용합니다.
 가운데 열의 4개의 숫자 2, 5, 8, 0을 입력할 때는 두 엄지손가락의 현재 키패드의 위치에서 더 가까운 엄지손가락을 사용합니다.
 4-1. 만약 두 엄지손가락의 거리가 같다면, 오른손잡이는 오른손 엄지손가락, 왼손잡이는 왼손 엄지손가락을 사용합니다.
 순서대로 누를 번호가 담긴 배열 numbers, 왼손잡이인지 오른손잡이인 지를 나타내는 문자열 hand가 매개변수로 주어질 때, 각 번호를 누른 엄지손가락이 왼손인 지 오른손인 지를 나타내는 연속된 문자열 형태로 return 하도록 solution 함수를 완성해주세요.
 
 [제한사항]
 numbers 배열의 크기는 1 이상 1,000 이하입니다.
 numbers 배열 원소의 값은 0 이상 9 이하인 정수입니다.
 hand는 "left" 또는 "right" 입니다.
 "left"는 왼손잡이, "right"는 오른손잡이를 의미합니다.
 왼손 엄지손가락을 사용한 경우는 L, 오른손 엄지손가락을 사용한 경우는 R을 순서대로 이어붙여 문자열 형태로 return 해주세요.
 
 [입출력 예]
 [numbers]                                [hand]       [result]
 [1, 3, 4, 5, 8, 2, 1, 4, 5, 9, 5]     "right"         "LRLLLRLLRRL"
 [7, 0, 8, 2, 8, 3, 1, 5, 7, 6, 2]     "left"           "LRLLRRLLLRR"
 [1, 2, 3, 4, 5, 6, 7, 8, 9, 0]         "right"         "LLRLLRLLRL"
 */

import Foundation

func solution(_ numbers:[Int], _ hand:String) -> String {
    var result = "" // L or R 입력 될 string
    let center = [2,5,8,0,11] // 가운데 열 숫자들 (11은 0자리의 위치)
    var leftFinger = 10 // 왼쪽 손가락이 올라간 위치 (* = 10)
    var rightFinger = 12 // 오른쪽 손가락이 올라간 위치 (# = 12)
    
    numbers.forEach { num in
        switch num {
        case 1, 4, 7: // 왼쪽 손가락 구역
            result += "L"
            leftFinger = num
        case 3, 6, 9: // 오른쪽 손가락 구역
            result += "R"
            rightFinger = num
        default:
            // 왼손가락이 가운데에 있는 경우와 아닌경우 거리차이 구하기
            let leftDistance = center.contains(leftFinger) ?  distance(leftFinger, num) : distance(leftFinger + 1, num) + 1
            // 오른손가락이 가운데에 있는 경우와 아닌경우 거리차이 구하기
            let rightDistance = center.contains(rightFinger) ? distance(rightFinger, num) : distance(rightFinger - 1, num) + 1
            
            if leftDistance == rightDistance { // 같은 위치인 경우
                result += hand == "left" ? "L" : "R"
                if hand == "left" {
                    leftFinger = num
                } else {
                    rightFinger = num
                }
            } else if leftDistance < rightDistance { // 왼손가락이 더 가까운 경우
                result += "L"
                leftFinger = num
            } else { // 오른손가락이 더 가까운 경우
                result += "R"
                rightFinger = num
            }
        }
    }
    
    return result
}

func distance(_ start: Int, _ end: Int) -> Int {
    guard start != end else { return 0 } // 출발지와 목적지가 같으면 거리 0 반환
    
    let s = start == 0 ? 11 : start
    let e = end == 0 ? 11 : end
    let diff = (s - e).magnitude // (시작점 - 도착점)의 절댓값
    
    return Int(diff / 3) // (시작점 - 도착점)을 3으로 나누면 거리가 나온다.
}

print(solution([1, 3, 4, 5, 8, 2, 1, 4, 5, 9, 5], "right"))
print(solution([7, 0, 8, 2, 8, 3, 1, 5, 7, 6, 2] , "left"))
print(solution([1, 2, 3, 4, 5, 6, 7, 8, 9, 0] , "right"))


