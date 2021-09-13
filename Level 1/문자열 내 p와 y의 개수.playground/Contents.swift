/**
 난이도: Level 1
 
 [문제 설명]
 대문자와 소문자가 섞여있는 문자열 s가 주어집니다. s에 'p'의 개수와 'y'의 개수를 비교해 같으면 True, 다르면 False를 return 하는 solution를 완성하세요. 'p', 'y' 모두 하나도 없는 경우는 항상 True를 리턴합니다. 단, 개수를 비교할 때 대문자와 소문자는 구별하지 않습니다.

 예를 들어 s가 "pPoooyY"면 true를 return하고 "Pyy"라면 false를 return합니다.

 [제한사항]
 문자열 s의 길이 : 50 이하의 자연수
 문자열 s는 알파벳으로만 이루어져 있습니다.
 
 [입출력 예]
 [s]                      [answer]
 "pPoooyY"            true
 "Pyy"                     false
 */

import Foundation

func solution(_ s:String) -> Bool {
    let lower = s.lowercased() // 모든 문자 소문자로 치환
    
    guard lower.contains("p") || lower.contains("y") else { return true }
    
    var n = 0
    lower.forEach {
        if $0 == "p" {
            n += 1
        } else if $0 == "y" {
            n -= 1
        }
    }
    
    return n == 0 ? true : false
}

print(solution("pPoooyY"))
print(solution("Pyy"))


// MARK: - 다른사람 문제 풀이
func solution2(_ s:String) -> Bool {
    let lower = s.lowercased() // 모든 문자 소문자로 치환
    
    print("p로 나눈 배열: \(lower.components(separatedBy: "p"))")
    print("y로 나눈 배열: \(lower.components(separatedBy: "y"))")
    
//    components(separatedBy: String) -> [String] = 포함된 문자로 분리하여 갯수 비교한다..
    return lower.components(separatedBy: "p").count == lower.components(separatedBy: "y").count
}


print(solution2("pPoooyY"))
print(solution2("Pyy"))
