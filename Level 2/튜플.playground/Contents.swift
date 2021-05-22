/**
 난이도: Level 1 (2019 카카오 개발자 겨울 인턴십)
 
 [문제 설명]
 셀수있는 수량의 순서있는 열거 또는 어떤 순서를 따르는 요소들의 모음을 튜플(tuple)이라고 합니다. n개의 요소를 가진 튜플을 n-튜플(n-tuple)이라고 하며, 다음과 같이 표현할 수 있습니다.

 (a1, a2, a3, ..., an)
 튜플은 다음과 같은 성질을 가지고 있습니다.

 중복된 원소가 있을 수 있습니다. ex : (2, 3, 1, 2)
 원소에 정해진 순서가 있으며, 원소의 순서가 다르면 서로 다른 튜플입니다. ex : (1, 2, 3) ≠ (1, 3, 2)
 튜플의 원소 개수는 유한합니다.
 원소의 개수가 n개이고, 중복되는 원소가 없는 튜플 (a1, a2, a3, ..., an)이 주어질 때(단, a1, a2, ..., an은 자연수), 이는 다음과 같이 집합 기호 '{', '}'를 이용해 표현할 수 있습니다.

 {{a1}, {a1, a2}, {a1, a2, a3}, {a1, a2, a3, a4}, ... {a1, a2, a3, a4, ..., an}}
 예를 들어 튜플이 (2, 1, 3, 4)인 경우 이는

 {{2}, {2, 1}, {2, 1, 3}, {2, 1, 3, 4}}
 와 같이 표현할 수 있습니다. 이때, 집합은 원소의 순서가 바뀌어도 상관없으므로

 {{2}, {2, 1}, {2, 1, 3}, {2, 1, 3, 4}}
 {{2, 1, 3, 4}, {2}, {2, 1, 3}, {2, 1}}
 {{1, 2, 3}, {2, 1}, {1, 2, 4, 3}, {2}}
 는 모두 같은 튜플 (2, 1, 3, 4)를 나타냅니다.

 특정 튜플을 표현하는 집합이 담긴 문자열 s가 매개변수로 주어질 때, s가 표현하는 튜플을 배열에 담아 return 하도록 solution 함수를 완성해주세요.

 [제한사항]
 s의 길이는 5 이상 1,000,000 이하입니다.
 s는 숫자와 '{', '}', ',' 로만 이루어져 있습니다.
 숫자가 0으로 시작하는 경우는 없습니다.
 s는 항상 중복되는 원소가 없는 튜플을 올바르게 표현하고 있습니다.
 s가 표현하는 튜플의 원소는 1 이상 100,000 이하인 자연수입니다.
 return 하는 배열의 길이가 1 이상 500 이하인 경우만 입력으로 주어집니다.
 [입출력 예]
 s                                                  result
 "{{2},{2,1},{2,1,3},{2,1,3,4}}"      [2, 1, 3, 4]
 "{{1,2,3},{2,1},{1,2,4,3},{2}}"      [2, 1, 3, 4]
 "{{20,111},{111}}"                       [111, 20]
 "{{123}}"                                    [123]
 "{{4,2,3},{3},{2,3,4,1},{2,3}}"      [3, 2, 4, 1]
 
 */

import Foundation

func solution(_ s:String) -> [Int] {
    let convertStr = s.components(separatedBy: ["{", "}", ","]) // 숫자들만 추출하기
    var result: [String: Int] = [:]
    
    // 각 숫자별로 있는 수만큼 Dictionary에 추가하기
    convertStr.forEach {
        if result[$0] == nil {
            result[$0] = 0
        } else {
            result[$0]! += 1
        }
    }
    
    // 많이 있는 숫자만큼 정렬하고, Int로 형 변환 후 반환한다.
    return result.sorted(by: { $0.value > $1.value }).compactMap { Int($0.key) }
}

print(solution("{{2},{2,1},{2,1,3},{2,1,3,4}}"))
print(solution("{{1,2,3},{2,1},{1,2,4,3},{2}}"))
print(solution("{{20,111},{111}}"))
print(solution("{{123}}"))
print(solution("{{4,2,3},{3},{2,3,4,1},{2,3}}"))


// MARK: - 다른사람 문제풀이
func solution2(_ s:String) -> [Int] {
    var result: [Int] = []

    var sets = s.split(omittingEmptySubsequences: true, whereSeparator: { "}".contains($0) }).map {
        $0.split(omittingEmptySubsequences: true, whereSeparator: { "{,".contains($0) }).map { Int($0)! }
    }

    sets.sort { (lhs, rhs) -> Bool in
        lhs.count < rhs.count
    }

    sets.forEach {
        result.append(Array(Set($0).subtracting(result)).first!)
    }

    return result
}

print(solution2("{{2},{2,1},{2,1,3},{2,1,3,4}}"))
print(solution2("{{1,2,3},{2,1},{1,2,4,3},{2}}"))
print(solution2("{{20,111},{111}}"))
print(solution2("{{123}}"))
print(solution2("{{4,2,3},{3},{2,3,4,1},{2,3}}"))
