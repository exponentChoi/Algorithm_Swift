/**
 난이도: Level 1
 
 [문제 설명]
 임의의 양의 정수 n에 대해, n이 어떤 양의 정수 x의 제곱인지 아닌지 판단하려 합니다.
 n이 양의 정수 x의 제곱이라면 x+1의 제곱을 리턴하고, n이 양의 정수 x의 제곱이 아니라면 -1을 리턴하는 함수를 완성하세요.

 [제한 사항]
 n은 1이상, 50000000000000 이하인 양의 정수입니다.
 
 [입출력 예]
 n          return
 121       144
 3           -1
 
 [입출력 예 설명]
 입출력 예#1
 121은 양의 정수 11의 제곱이므로, (11+1)를 제곱한 144를 리턴합니다.

 입출력 예#2
 3은 양의 정수의 제곱이 아니므로, -1을 리턴합니다.
 */

import Foundation

func solution(_ n:Int64) -> Int64 {
    let s = sqrt(Double(n)) // sqrt - 제곱근 구하는 함수
    return Double(Int(s)) == s ? Int64((s + 1) * (s + 1)) : -1
}

print(solution(121))
print(solution(3))

// MARK: - 다른 문제풀이
func solution2(_ n:Int64) -> Int64 {
    // 형 변환을 최소화 시킴
    let t = Int64(sqrt(Double(n)))
    return t * t == n ? (t+1)*(t+1) : -1
}

print(solution2(121))
print(solution2(3))
