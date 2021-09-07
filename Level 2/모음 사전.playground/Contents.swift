/**
 난이도: Level 2 - 위클리 챌린지 [5주차_모음사전]

 
 [문제 설명]
 사전에 알파벳 모음 'A', 'E', 'I', 'O', 'U'만을 사용하여 만들 수 있는, 길이 5 이하의 모든 단어가 수록되어 있습니다. 사전에서 첫 번째 단어는 "A"이고, 그다음은 "AA"이며, 마지막 단어는 "UUUUU"입니다.

 단어 하나 word가 매개변수로 주어질 때, 이 단어가 사전에서 몇 번째 단어인지 return 하도록 solution 함수를 완성해주세요.

 [제한사항]
 word의 길이는 1 이상 5 이하입니다.
 word는 알파벳 대문자 'A', 'E', 'I', 'O', 'U'로만 이루어져 있습니다.
 
 [입출력 예]
 word            result
 "AAAAE"      6
 "AAAE"        10
 "I"                1563
 "EIO"           1189
 
 [입출력 예 설명]
 [입출력 예 #1]

 사전에서 첫 번째 단어는 "A"이고, 그다음은 "AA", "AAA", "AAAA", "AAAAA", "AAAAE", ... 와 같습니다. "AAAAE"는 사전에서 6번째 단어입니다.

 [입출력 예 #2]
 "AAAE"는 "A", "AA", "AAA", "AAAA", "AAAAA", "AAAAE", "AAAAI", "AAAAO", "AAAAU"의 다음인 10번째 단어입니다.

 [입출력 예 #3]
 "I"는 1563번째 단어입니다.

 [입출력 예 #4]
 "EIO"는 1189번째 단어입니다.
 */
import Foundation

// MARK: - 무지성 풀이법...  아래 풀이추가
func solution(_ word:String) -> Int {
    let alphabet = ["A", "E", "I", "O", "U"] // 사용 가능한 알파벳
    var answer = -1
    var isFind = false
    var w = [String]() {
        didSet {
            if oldValue.joined() == word {
                isFind = true
            }
        }
    }
    
    loop:for a in alphabet.indices {
        if isFind { break loop }
        answer += 1
        let A = alphabet[a]
        w = [A]
        let aw = [A]

        for b in alphabet.indices {
            if isFind { break loop }
            answer += 1
            let B = alphabet[b]
            w = aw
            w.append(B)
            let bw = w

            for c in alphabet.indices {
                if isFind { break loop }
                answer += 1
                let C = alphabet[c]
                w = bw
                w.append(C)
                let cw = w

                for d in alphabet.indices {
                    if isFind { break loop }
                    answer += 1
                    let D = alphabet[d]
                    w = cw
                    w.append(D)
                    let dw = w

                    for e in alphabet.indices {
                        if isFind { break loop }
                        answer += 1
                        let E = alphabet[e]
                        w = dw
                        w.append(E)
                    }
                }
            }
        }
    }
    
    return answer
}

print("- solution (무지성 풀이법)")
print(solution("AAAAE")) // 6
print(solution("AAAE")) // 10
print(solution("I")) // 1563
print(solution("EIO")) // 1189
print(solution("UUUUU")) // 3905


// MARK: - 다른 풀이방법
func solution2(_ word:String) -> Int {
    let vowelCount = [781, 156, 31, 6, 1] // 각 자리수별 다음모음으로 이동할 수 있는 숫자이다.
    // AAAAA 에서 AAAAE가 되기 위해 [AAAAA, AAAAE] 1번 움직였다.
    // AAAA에서 AAAE가 되기 위해 [AAAA, AAAAA, AAAAE, AAAAI, AAAAO, AAAAU, AAAE] 6번 움직였다.
    // AAA에서 AAE가 되기 위해 [AAA, AAAA, AAAAA, ... AAAUU, AAE] 31번 움직였다.
    // 위와같은 방식으로 몇번 움직이는지 미리 계산 후 정리한다.
    
    
    // Dictionary가 검색할 때 속도가 더 빠르다.
    // 아래 둘 다 결과는 같다.
    
    // Dictionary를 사용했다. (Key를 검색해서 숫자를 추출하는)
    let vowels = ["A": 0, "E": 1, "I": 2, "O": 3, "U": 4]
    return word.enumerated().map { vowelCount[$0.offset] * vowels[String($0.element)]! }.reduce(word.count, +)
    
    // Array를 사용했다. (string으로 몇 번째 index인지 추출하는 방식) - (0...n)일 경우에만 사용 가능 (Dictionary가 빠름)
//    let vowels = ["A", "E", "I", "O", "U"]
//    return word.enumerated().map { vowelCount[$0.offset] * vowels.firstIndex(of: String($0.element))! }.reduce(word.count, +)
}

print("\n\n- solution 2 (엄청난 변태 알고리즘)")
print(solution2("AAAAE")) // 6
print(solution2("AAAE")) // 10
print(solution2("I")) // 1563
print(solution2("EIO")) // 1189
print(solution2("UUUUU")) // 3905



// MARK: - 숫자를 추출하기...(0...n)일 경우에만 사용 가능
let test1 = ["apple", "banana", "carrot", "dog", "eat"]
let test2 = ["apple": 0, "banana": 1, "carrot": 2, "dog": 3, "eat": 4]

test1.compactMap { test1.firstIndex(of: $0) } // 0, 1, 2, 3, 4
test2.compactMap { test2[$0.key] } // 0, 1, 2, 3, 4 (순서 상관없음)
