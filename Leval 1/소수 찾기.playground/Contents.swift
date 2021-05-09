/**
 난이도: Level 1
 
 [문제 설명]
 1부터 입력받은 숫자 n 사이에 있는 소수의 개수를 반환하는 함수, solution을 만들어 보세요.

 소수는 1과 자기 자신으로만 나누어지는 수를 의미합니다.
 (1은 소수가 아닙니다.)

 [제한 조건]
 n은 2이상 1000000이하의 자연수입니다.
 
 [입출력 예]
 n          result
 10        4
 5          3
 
 [입출력 예 설명]
 입출력 예 #1
 1부터 10 사이의 소수는 [2,3,5,7] 4개가 존재하므로 4를 반환

 입출력 예 #2
 1부터 5 사이의 소수는 [2,3,5] 3개가 존재하므로 3를 반환
 */


// 시간초과 됨...
func solution(_ n:Int) -> Int {
    var count = 0
    
    (1...n).forEach {
        count += isPrime($0) ? 1 : 0
    }
    
    return count
}

// 소수 구하기 함수
func isPrime(_ num: Int) -> Bool {
    guard num >= 2 else { return false } // 1은 소수가 아니고 2부터 소수이므로 guard문 작성
    
    for i in 2..<num {
        if num % i == 0 { // 에라토스테네스의 체를 활용한 for문 작성
            return false
        }
    }
    
    return true
}


print(solution(10))
print(solution(5))


// MARK: - 또 다른 풀이
func solution2(_ n:Int) -> Int {
    var count = 0
    var array = Array.init(repeating: false, count: n+1)
    
    for i in 2...n {
        if array[i] == false {
            count += 1
            
            for j in stride(from: i, through: n, by: i) {
                array[j] = true
            }
        }
    }
    
    return count
}

print(solution2(10))
print(solution2(5))
