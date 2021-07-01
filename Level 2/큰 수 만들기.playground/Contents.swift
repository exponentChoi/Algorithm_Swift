/**
 난이도: Level 2 - 탐욕법(Greedy)
 
 [문제 설명]
 어떤 숫자에서 k개의 수를 제거했을 때 얻을 수 있는 가장 큰 숫자를 구하려 합니다.

 예를 들어, 숫자 1924에서 수 두 개를 제거하면 [19, 12, 14, 92, 94, 24] 를 만들 수 있습니다. 이 중 가장 큰 숫자는 94 입니다.

 문자열 형식으로 숫자 number와 제거할 수의 개수 k가 solution 함수의 매개변수로 주어집니다. number에서 k 개의 수를 제거했을 때 만들 수 있는 수 중 가장 큰 숫자를 문자열 형태로 return 하도록 solution 함수를 완성하세요.

 [제한 조건]
 number는 1자리 이상, 1,000,000자리 이하인 숫자입니다.
 k는 1 이상 number의 자릿수 미만인 자연수입니다.
 
 [입출력 예]
 number    k    return
 "1924"    2    "94"
 "1231234"    3    "3234"
 "4177252841"    4    "775841"
 */

import Foundation

func solution(_ number:String, _ k:Int) -> String {
    return greedy(number, letter: "", target: number.count - k)
        .compactMap { Int($0) }
        .max()!.description
}

// 중복값 제거 버전
func greedy(_ number: String, letter: String, target: Int) -> Set<String> {
    if letter.count + number.count < target { return [] }
    if letter.count == target { // (letter - target)이 지우고 난 후의 문자 개수가 동일한 경우 그대로 반환
        return [letter]
    }

    var strings = number.map { String($0) } // String을 배열로 나누기
    var answer:[String] = [] // 조합한 문자들을 저장할 곳

    for i in number {
        strings.removeFirst() // 맨 앞자리를 하나씩 지워가면서 재귀함수 호출
        answer += greedy(strings.joined(), letter: letter + String(i), target: target) // 조합한 문자열 저장
    }

    return Set(answer)
}


//func greedy(_ number: String, letter: String, target: Int) -> [String] {
//    if letter.count + number.count < target { return [] }
//    if letter.count == target { // (letter - target)이 지우고 난 후의 문자 개수가 동일한 경우 그대로 반환
//        return [letter]
//    }
//
//    var strings = number.map { String($0) } // String을 배열로 나누기
//    var answer:[String] = [] // 조합한 문자들을 저장할 곳
//
//    for i in number {
//        strings.removeFirst() // 맨 앞자리를 하나씩 지워가면서 재귀함수 호출
//        answer += greedy(strings.joined(), letter: letter + String(i), target: target) // 조합한 문자열 저장
//    }
//
//    return answer
//}

print(solution("1924", 2)) // 94
print(solution("1231234", 3)) // 3234
print(solution("4177252841", 4)) // 775841

print(solution("01273456", 4)) // 7456
