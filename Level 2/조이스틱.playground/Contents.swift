/**
 난이도: Level 2 - 탐욕법(Greedy)
 
 [문제 설명]
 조이스틱으로 알파벳 이름을 완성하세요. 맨 처음엔 A로만 이루어져 있습니다.
 ex) 완성해야 하는 이름이 세 글자면 AAA, 네 글자면 AAAA

 조이스틱을 각 방향으로 움직이면 아래와 같습니다.

 ▲ - 다음 알파벳
 ▼ - 이전 알파벳 (A에서 아래쪽으로 이동하면 Z로)
 ◀ - 커서를 왼쪽으로 이동 (첫 번째 위치에서 왼쪽으로 이동하면 마지막 문자에 커서)
 ▶ - 커서를 오른쪽으로 이동
 예를 들어 아래의 방법으로 "JAZ"를 만들 수 있습니다.

 - 첫 번째 위치에서 조이스틱을 위로 9번 조작하여 J를 완성합니다.
 - 조이스틱을 왼쪽으로 1번 조작하여 커서를 마지막 문자 위치로 이동시킵니다.
 - 마지막 위치에서 조이스틱을 아래로 1번 조작하여 Z를 완성합니다.
 따라서 11번 이동시켜 "JAZ"를 만들 수 있고, 이때가 최소 이동입니다.
 만들고자 하는 이름 name이 매개변수로 주어질 때, 이름에 대해 조이스틱 조작 횟수의 최솟값을 return 하도록 solution 함수를 만드세요.

 [제한 사항]
 name은 알파벳 대문자로만 이루어져 있습니다.
 name의 길이는 1 이상 20 이하입니다.
 
 [입출력 예]
 name    return
 "JEROEN"    56
 "JAN"    23
 */

import Foundation

// 이 문제의 관건은 이동횟수가 가장 적은수를 찾는 것이다.
func solution(_ name:String) -> Int {
    var answer = 0 // 각 문자의 자리수마다 가장 짧은 값들의 합
    let names = name.map { str -> String.Element in
        if str != "A" { // A가 아닌 경우 조이스틱을 올린것과 내린것 중 가장 짧은 횟수를 추가한다.
            let ascii = str.asciiValue! // Unicode
            answer += Int(min(ascii - 65, 91 - ascii)) // 65: A, 90: Z
        }
        
        return str
    }
    
    var minMove = names.count - 1 // 0부터 오른쪽으로만 이동했을 경우의 이동한 수 (AAAA는 3움직이는게 최고이다.)
    
    // 이동거리가 가장 짧은 경우의 수를 구하는 반복문
    for i in names.indices {
        if names[i] != "A" { // A가 아닌 경우 이동거리중 가장 짧은 경우의 수를 구한다.
            var nextIndex = i + 1
            
            // A를 몇번 건너뛰는지 반복한다.
            while nextIndex < names.count && names[nextIndex] == "A" {
                nextIndex += 1
            }
            
            let move = (i * 2) + names.count - nextIndex // (가다가 되돌아온 상황) + (우측으로 갈 수 있는 거리 - 이동한 거리)
            minMove = min(minMove, move) // 이동횟수가 적은것을 저장
        }
    }
    
    return answer + minMove // 문자 변경한 수 + 이동한 수
}


print(solution("AAAAAAA")) // 6
print(solution("JEROEN")) // 56
print(solution("JAN")) // 23
print(solution("ABBA")) // 5
print(solution("ABCKC")) // 19

