/**
 난이도: Level 1
 
 [문제 설명]
 주어진 숫자 중 3개의 수를 더했을 때 소수가 되는 경우의 개수를 구하려고 합니다. 숫자들이 들어있는 배열 nums가 매개변수로 주어질 때, nums에 있는 숫자들 중 서로 다른 3개를 골라 더했을 때 소수가 되는 경우의 개수를 return 하도록 solution 함수를 완성해주세요.

 [제한사항]
 nums에 들어있는 숫자의 개수는 3개 이상 50개 이하입니다.
 nums의 각 원소는 1 이상 1,000 이하의 자연수이며, 중복된 숫자가 들어있지 않습니다.
 
 [입출력 예]
 nums               result
 [1,2,3,4]        1
 [1,2,7,6,4]     4
 
 [입출력 예 설명]
 
 [입출력 예 #1]
 [1,2,4]를 이용해서 7을 만들 수 있습니다.

 [입출력 예 #2]
 [1,2,4]를 이용해서 7을 만들 수 있습니다.
 [1,4,6]을 이용해서 11을 만들 수 있습니다.
 [2,4,7]을 이용해서 13을 만들 수 있습니다.
 [4,6,7]을 이용해서 17을 만들 수 있습니다.
 */

import Foundation

func solution(_ nums:[Int]) -> Int {
    let sums = sumAll(nums)
    return sums.filter { isPrime($0) }.count // 소수인 것만 필터링한 후 갯수 반환
}

// 모든 수의 합을 더하는 함수
func sumAll(_ nums:[Int]) -> [Int] {
    var a = 0 // 첫번 째 index
    var b = 1 // 두번 째 index
    var c = 2 // 세번 째 index
    var answer:[Int] = [] // 세가지 수의 합을 저장하는 배열
    
    while true {
        answer.append(nums[a] + nums[b] + nums[c]) //
        if c != nums.count - 1 { // c를 마지막 index까지 증가시킨다.
            c += 1
        } else if b != nums.count - 2 { // b를 마지막에서 두번째 index까지 증가시킨다.
            b += 1
            c = b + 1 // c가 맨 끝까지 돌고난 후, b 바로 다음의 index가 되어야 모든 수를 더하기가 가능함.
        } else if a != nums.count - 3 { // a를 마지막에서 데번째 index까지 증가시킨다.
            a += 1
            b = a + 1 // 48번줄 설명과 동일
            c = b + 1 // 48번줄 설명과 동일
        } else {
            break
        }
    }
    
    return answer
}

// 소수 구하기 함수
func isPrime(_ num: Int) -> Bool {
    guard num >= 2 else { return false } // 1은 소수가 아니고 2부터 소수이므로 guard문 작성
    
    for i in 2..<num {
        if num % i == 0 { // 에라토스테네스의 체를 활용한 for문 작성
            return false
        }
    }
    
    return true
}
print(solution([1,2,3,4]))
print(solution([1,2,7,6,4]))
