/**
 난이도: Level 1
 
 [문제 설명]
 단어 s의 가운데 글자를 반환하는 함수, solution을 만들어 보세요. 단어의 길이가 짝수라면 가운데 두글자를 반환하면 됩니다.

 [재한사항]
 s는 길이가 1 이상, 100이하인 스트링입니다.
 
 [입출력 예]
 s                return
 "abcde"      "c"
 "qwer"        "we"
 */

func solution(_ s:String) -> String {
    
    let isEven = s.count % 2 == 0 // true ? 짝수 : 홀수
    let half = s.count / 2 // 가운데 숫자 index
    
    return !isEven ? s.subString(at: half) : s.subString(at: half - 1) + s.subString(at: half)
}

extension String {
    func subString(at index: Int) -> String {
        return String(self[self.index(self.startIndex, offsetBy: index)])
    }
}

print(solution("abcde")) // "c"
print(solution("qwer"))  // "we"
