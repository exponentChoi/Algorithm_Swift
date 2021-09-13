/**
 난이도: Level 1
 
 [문제 설명]
 자연수 n을 뒤집어 각 자리 숫자를 원소로 가지는 배열 형태로 리턴해주세요. 예를들어 n이 12345이면 [5,4,3,2,1]을 리턴합니다.

 [제한 조건]
 n은 10,000,000,000이하인 자연수입니다.
 
 [입출력 예]
 n              return
 12345    [5,4,3,2,1]
 */

func solution(_ n:Int64) -> [Int] {
    // 나의 풀이
//    return String(n).compactMap { Int(String($0)) }.reversed()
    
    /**
     *  다른 문제 풀이
     *  hexDigitValue -> Character타입을 16진수 값으로 변환한다.
     */
    return "\(n)".compactMap { $0.hexDigitValue }.reversed()
}

print(solution(12345))
