/**
 난이도: Level 2 - Summer/Winter Coding(~2018)
 
 [문제 설명]
 선행 스킬이란 어떤 스킬을 배우기 전에 먼저 배워야 하는 스킬을 뜻합니다.

 예를 들어 선행 스킬 순서가 스파크 → 라이트닝 볼트 → 썬더일때, 썬더를 배우려면 먼저 라이트닝 볼트를 배워야 하고, 라이트닝 볼트를 배우려면 먼저 스파크를 배워야 합니다.

 위 순서에 없는 다른 스킬(힐링 등)은 순서에 상관없이 배울 수 있습니다. 따라서 스파크 → 힐링 → 라이트닝 볼트 → 썬더와 같은 스킬트리는 가능하지만, 썬더 → 스파크나 라이트닝 볼트 → 스파크 → 힐링 → 썬더와 같은 스킬트리는 불가능합니다.

 선행 스킬 순서 skill과 유저들이 만든 스킬트리1를 담은 배열 skill_trees가 매개변수로 주어질 때, 가능한 스킬트리 개수를 return 하는 solution 함수를 작성해주세요.

 [제한 조건]
 스킬은 알파벳 대문자로 표기하며, 모든 문자열은 알파벳 대문자로만 이루어져 있습니다.
 스킬 순서와 스킬트리는 문자열로 표기합니다.
 예를 들어, C → B → D 라면 "CBD"로 표기합니다
 선행 스킬 순서 skill의 길이는 1 이상 26 이하이며, 스킬은 중복해 주어지지 않습니다.
 skill_trees는 길이 1 이상 20 이하인 배열입니다.
 skill_trees의 원소는 스킬을 나타내는 문자열입니다.
 skill_trees의 원소는 길이가 2 이상 26 이하인 문자열이며, 스킬이 중복해 주어지지 않습니다.
 
 [입출력 예]
 [skill]    [skill_trees]                                              [return]
 "CBD"    ["BACDE", "CBADF", "AECB", "BDA"]      2
 
 [입출력 예 설명]
 "BACDE": B 스킬을 배우기 전에 C 스킬을 먼저 배워야 합니다. 불가능한 스킬트립니다.
 "CBADF": 가능한 스킬트리입니다.
 "AECB": 가능한 스킬트리입니다.
 "BDA": B 스킬을 배우기 전에 C 스킬을 먼저 배워야 합니다. 불가능한 스킬트리입니다.
 */

import Foundation

func solution(_ skill:String, _ skill_trees:[String]) -> Int {
    let flow = Array(skill)
    var answer = skill_trees.count
    
    skill_trees.forEach {
        let skill_tree = Array($0)
        var index = -1 // 스킬 배우는 순서중 사용된 스킬의 인덱스
        
        for i in skill_tree.indices {
            let s = skill_tree[i]
            if flow.contains(s) {
                let flowIndex = flow.firstIndex(of: s)!
                
                if index == -1 && flowIndex != 0 { // 스킬 배우기가 처음인데, 스킬 베우는 순서중 첫 번째가 아닌 경우
                    answer -= 1
                    break
                } else if flowIndex < index { // 배우려는 스킬이 스킬 배우는 순서보다 앞인 경우
                    answer -= 1
                    break
                } else if abs(index - flowIndex) != 1 { // 배우려는 스킬이 중간과정을 건너 뛴 경우
                    answer -= 1
                    break
                } else {
                    index = flowIndex
                }
            }
        }
    }

    return answer
}

print(solution("CBD", ["BACDE", "CBADF", "AECB", "BDA"])) // 2
print(solution("CBD", ["CED"])) // 0
