/**
 난이도: Level 1
 
 [문제 설명]
 함수 solution은 정수 n을 매개변수로 입력받습니다. n의 각 자릿수를 큰것부터 작은 순으로 정렬한 새로운 정수를 리턴해주세요. 예를들어 n이 118372면 873211을 리턴하면 됩니다.

 [제한 조건]
 n은 1이상 8000000000 이하인 자연수입니다.
 
 [입출력 예]
 n                 return
 118372        873211
 */

func solution(_ n:Int64) -> Int64 {
    // description과 String()의 성능차이는 비슷하다.. String()이 조금 더 빠른듯한 느낌적인 느낌!
    return Int64(n.description.sorted(by: >).map { String($0) }.joined()) ?? n
}

print(solution(118372))
