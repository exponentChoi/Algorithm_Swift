/**
 난이도: Level 2
 
 [문제 설명]
 JadenCase란 모든 단어의 첫 문자가 대문자이고, 그 외의 알파벳은 소문자인 문자열입니다. 문자열 s가 주어졌을 때, s를 JadenCase로 바꾼 문자열을 리턴하는 함수, solution을 완성해주세요.

 [제한 조건]
 s는 길이 1 이상인 문자열입니다.
 s는 알파벳과 공백문자(" ")로 이루어져 있습니다.
 첫 문자가 영문이 아닐때에는 이어지는 영문은 소문자로 씁니다. ( 첫번째 입출력 예 참고 )
 
 [입출력 예]
 [s]                                        [return]
 "3people unFollowed me"      "3people Unfollowed Me"
 "for the last week"                  "For The Last Week"
 */
import Foundation

func solution(_ s:String) -> String {
   return s.components(separatedBy: " ") // " "을 기준으로 배열생성
    .map { (String($0).first?.uppercased() ?? "") + String($0.dropFirst()).lowercased() } // 첫글자는 대문자로(없으면 빈칸), 첫번째를 제외하고 소문자로 변환
    .joined(separator: " ") // " "을 넣어 문자열 생성
}


print(solution("3people unFollowed me")) // "3people Unfollowed Me"
print(solution("for the last week")) // "For The Last Week"
print(solution("  ")) // "  "
print(solution(" F f f3 2f F3 2F")) // " F F F3 2f F3 2f"
