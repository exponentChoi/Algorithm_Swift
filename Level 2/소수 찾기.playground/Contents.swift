/**
 난이도: Level 2
 
 [문제 설명]
 한자리 숫자가 적힌 종이 조각이 흩어져있습니다. 흩어진 종이 조각을 붙여 소수를 몇 개 만들 수 있는지 알아내려 합니다.

 각 종이 조각에 적힌 숫자가 적힌 문자열 numbers가 주어졌을 때, 종이 조각으로 만들 수 있는 소수가 몇 개인지 return 하도록 solution 함수를 완성해주세요.

 [제한사항]
 numbers는 길이 1 이상 7 이하인 문자열입니다.
 numbers는 0~9까지 숫자만으로 이루어져 있습니다.
 "013"은 0, 1, 3 숫자가 적힌 종이 조각이 흩어져있다는 의미입니다.
 
 [입출력 예]
 numbers    return
 "17"            3
 "011"          2
 
 [입출력 예 설명]
 예제 #1
 [1, 7]으로는 소수 [7, 17, 71]를 만들 수 있습니다.

 예제 #2
 [0, 1, 1]으로는 소수 [11, 101]를 만들 수 있습니다.

 11과 011은 같은 숫자로 취급합니다.
 */

import Foundation

func solution(_ numbers: String) -> Int {
    let numberArr = numbers.map { String($0) } // 1. String으로 하나씩 재배열
    let combines = comb(numbers: numberArr).compactMap { Int($0) } // 2. 모든 경우의 수로 숫자 조합
    
    return Set(combines).filter { isPrime($0) }.count // 3. [2]에서 조합한 숫자들 중 소수인 숫자들의 갯수를 추출
}

/// 재귀함수 - 숫자들을 가지고 만들 수 있는 숫자들을 전부 조합한다.
func comb(numbers: [String]) -> Set<String> {
    if numbers.count == 1 { return Set(numbers) } // 숫자가 한개인 경우 한가지의 숫자밖에 못만든다.
    if numbers.count < 1 { return [] }
    
    var answer: Set<String> = [] // 결과값을 담을 배열..(중복은 제거한다.)
    
    // numbers 매개변수의 갯수만큼 for문을 돌려 숫자를 조합한다.
    for i in 0..<numbers.count {
        let num = numbers[i] // 2.1) numbers의 첫번 째 숫자
        var subNumbers: [String] = numbers // 2.2) numbers의 첫번 째 숫자를 제외한 숫자들
        subNumbers.remove(at: i) // numbers의 첫번 째 숫자를 제거
        
        let subComb = comb(numbers: subNumbers) // 2.3) [2.2]의 숫자들로 만들 수 있는 숫자들을 조합한다.
        let subArray = subComb.compactMap{ num + $0 } // 2.4) [2.3]에서 구한 숫자들과 [2.1]의 숫자를 합친다.
        
        // 2.5) 위에서 구한 숫자들을 결과값을 담는 배열에 합친다.
        answer = answer.union(subComb)
        answer = answer.union(Set(subArray))
    }
    
    return answer
}

/// 소수 판별기
func isPrime(_ number: Int) -> Bool {
    guard number >= 2 else { return false }
    guard number > 3 else { return true }
    
    let root = sqrt(Double(number))
    
    for i in 2...Int(root) {
        if number % i == 0 && number != 2 {
            return false
        }
    }
    
    return true
}

print(solution("17"))
print(solution("011"))
print(solution("523"))
