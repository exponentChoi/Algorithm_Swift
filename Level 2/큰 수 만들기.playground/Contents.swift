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

// MARK: - performance test !!
private func bench(index: String = "", benchFunc: () -> ()) {
    let startTime = CFAbsoluteTimeGetCurrent()
    benchFunc()
    let processTime = CFAbsoluteTimeGetCurrent() - startTime
    print("Process Time [\(index)] = \(processTime)")
}


// MARK: - stack에 쌓아서 큰 숫자들을 저장
// ([1,2,3,4,5], 2)가 주어졌을 때 3자리수를 만들어야 한다.
// 1. stack에 Index마다 가장 큰 숫자를 저장하고.
// 2. 같은 Index일 때 더 큰 숫자가 있는 경우 교체한다.
// 단점: 끝까지 비교하기 때문에 시간이 좀 더 걸림.
func solution2(_ number:String, _ k:Int) -> String {
    let nums = number.map { String($0) } // String을 각 배열로 만든다.
    var stack = [nums[0]] // stack, 첫번 째 항목 삽입
    var count = 0
    
    for i in 1..<nums.count {
        
        stack.append(nums[i])
        var last = stack.count - 1 // stack의 마지막 index

        if stack[last - 1] < stack[last] { // 최근 저장한 value가 바로 앞 저장한 값보다 큰 경우 (시간을 줄이기 위해 분기처리함)
            while stack.count != 1 && stack[last - 1] < stack[last] && count < k {
                stack.swapAt(last, last - 1) // last Index와 (last - 1) Index의 위치를 바꾼다.
                stack.removeLast() // 바꾸고 난 후 마지막 값은 제거한다.
                last = stack.count - 1
                count += 1 // 제거한 숫자
            }
        }
    }
    
    return stack.joined() // stack에 저장한 string값을 전부 합친다.
}

// MARK: - 지운 갯수가 k와 동일하다면 반복문을 멈추고 나머지 string을 저장한다.
// 숫자 끝까지 반복하지 않아 속도가 빠르다.
func solution3(_ number:String, _ k:Int) -> String {
    let nums = number.map { String($0) } // String을 각 배열로 만든다.
    var max = "" // 가장 큰 숫자를 저장하는 변수
    var answer = "" // 최종 결과값을 저장
    var startIndex = 0 // 문자를 비교하기 위한 시작 Index
    var endIndex = k // k 개수만큼만 비교해서 추가해주면 된다.
    
    for _ in 0..<nums.count - k {
        if startIndex == endIndex { // 시작과 끝이 같다면 비교할 것 없이 뒷자리의 배열들을 전부 추가하면 된다.
            answer += nums[startIndex..<nums.count].joined()
            break
        }
        
        for i in startIndex...endIndex {
            if nums[i] == "9" { // value가 9인 경우 가장 큰 숫자이므로 바로 break (시간을 줄여야한다.)
                max = nums[i] // 가장 큰 수 저장
                startIndex = i + 1 // 가장 큰 숫자 다음부터 비교하기 위함
                break
            } else if nums[i] > max || nums[i] == "9" { // 저장한 max값보다 i가 큰 경우
                max = nums[i] // 가장 큰 수 저장
                startIndex = i + 1 // 가장 큰 숫자 다음부터 비교하기 위함
            }
        }
        
        answer += max // 가장 큰 숫자를 최종 결과값에 추가한다.
        max = "" // 추가 완료한 후 초기화
        endIndex += 1
    }
    
    return answer
}

// MARK: - 성능 비교
DispatchQueue.global().sync {
    bench(index: "solution 2", benchFunc: {
        print(solution2("1924", 2)) // 94
        print(solution2("1231234", 3)) // 3234
        print(solution2("4177252841", 4)) // 775841
        print(solution2("01273456", 4)) // 7456
    })
    
    bench(index: "solution 3", benchFunc: {
        print(solution3("1924", 2)) // 94
        print(solution3("1231234", 3)) // 3234
        print(solution3("4177252841", 4)) // 775841
        print(solution3("01273456", 4)) // 7456
    })
}


// MARK: - 시간초과 발생.. 이건 모든 경우의 수를 구하는 BFS임.
func solution(_ number:String, _ k:Int) -> String {
    return combine(number, letter: "", target: number.count - k)
        .compactMap { Int($0) }
        .max()!.description
}

func combine(_ number: String, letter: String, target: Int) -> Set<String> {
    if letter.count + number.count < target { return [] }
    if letter.count == target { // (letter - target)이 지우고 난 후의 문자 개수가 동일한 경우 그대로 반환
        return [letter]
    }

    var strings = number.map { String($0) } // String을 배열로 나누기
    var answer:[String] = [] // 조합한 문자들을 저장할 곳

    for i in number {
        strings.removeFirst() // 맨 앞자리를 하나씩 지워가면서 재귀함수 호출
        answer += combine(strings.joined(), letter: letter + String(i), target: target) // 조합한 문자열 저장
    }

    return Set(answer)
}

//print(solution("1924", 2)) // 94
//print(solution("1231234", 3)) // 3234
//print(solution("4177252841", 4)) // 775841
//print(solution("01273456", 4)) // 7456
