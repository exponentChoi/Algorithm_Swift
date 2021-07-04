/**
 난이도: Level 2 - 정렬
 
 [문제 설명]
 H-Index는 과학자의 생산성과 영향력을 나타내는 지표입니다. 어느 과학자의 H-Index를 나타내는 값인 h를 구하려고 합니다. 위키백과1에 따르면, H-Index는 다음과 같이 구합니다.

 어떤 과학자가 발표한 논문 n편 중, h번 이상 인용된 논문이 h편 이상이고 나머지 논문이 h번 이하 인용되었다면 h의 최댓값이 이 과학자의 H-Index입니다.

 어떤 과학자가 발표한 논문의 인용 횟수를 담은 배열 citations가 매개변수로 주어질 때, 이 과학자의 H-Index를 return 하도록 solution 함수를 작성해주세요.

 [제한사항]
 과학자가 발표한 논문의 수는 1편 이상 1,000편 이하입니다.
 논문별 인용 횟수는 0회 이상 10,000회 이하입니다.
 
 [입출력 예]
 citations              return
 [3, 0, 6, 1, 5]     3
 
 [입출력 예 설명]
 이 과학자가 발표한 논문의 수는 5편이고, 그중 3편의 논문은 3회 이상 인용되었습니다. 그리고 나머지 2편의 논문은 3회 이하 인용되었기 때문에 이 과학자의 H-Index는 3입니다.
 */

import Foundation


// H-index 산출 방법
// 1. 내림차순으로 숫자 정렬
// 2. 해당 순위보다 숫자가 낮은경우 앞순위(해당 순위 - 1)가 H-index 이다.
func solution(_ citations:[Int]) -> Int {
    let sort = citations.sorted(by: >) // 내림차순 정렬
    var answer = citations.count // H-Index
    
    for i in 1...sort.count {
        let valueIndex = i - 1
        
        if i > sort[valueIndex] {
            answer = valueIndex
            break
        }
    }
    
    return answer
}

print("Solution 1")
print(solution([3, 0, 6, 1, 5]))
print(solution([53, 26, 20, 13, 10, 4, 2]))
print(solution([22,42]))
/**
 테스트 1 〉    통과 (1.38ms, 16.6MB)
 테스트 2 〉    통과 (1.63ms, 16.3MB)
 테스트 3 〉    통과 (1.39ms, 16.5MB)
 테스트 4 〉    통과 (1.11ms, 16.5MB)
 테스트 5 〉    통과 (1.57ms, 16.6MB)
 테스트 6 〉    통과 (2.11ms, 16.6MB)
 테스트 7 〉    통과 (0.62ms, 16.5MB)
 테스트 8 〉    통과 (0.23ms, 16.4MB)
 테스트 9 〉    통과 (0.32ms, 16.2MB)
 테스트 10 〉    통과 (0.86ms, 16.3MB)
 테스트 11 〉    통과 (2.32ms, 16.6MB)
 테스트 12 〉    통과 (0.34ms, 16.4MB)
 테스트 13 〉    통과 (1.89ms, 16.4MB)
 테스트 14 〉    통과 (1.70ms, 16.4MB)
 테스트 15 〉    통과 (1.95ms, 16.3MB)
 테스트 16 〉    통과 (0.10ms, 16.6MB)
 */




// MARK: - 살짝 다른 코드 속도는 비슷할듯 함
func solution2(_ citations:[Int]) -> Int {
    let sort = citations.sorted(by: >) // 내림차순 정렬
    var answer = 0 // H-Index
    
    for i in 1...sort.count {
        if i > sort[i - 1] { // value가 순위보다 큰 경우
            break
        }
        
        answer += 1
    }
    
    return answer
}

print("\nSolution 2")
print(solution2([3, 0, 6, 1, 5]))
print(solution2([53, 26, 20, 13, 10, 4, 2]))
print(solution2([22,42]))
/**
 테스트 1 〉    통과 (1.37ms, 16.6MB)
 테스트 2 〉    통과 (1.63ms, 16.3MB)
 테스트 3 〉    통과 (1.40ms, 16.5MB)
 테스트 4 〉    통과 (1.14ms, 16.5MB)
 테스트 5 〉    통과 (1.56ms, 16.4MB)
 테스트 6 〉    통과 (1.99ms, 16.6MB)
 테스트 7 〉    통과 (0.70ms, 16.4MB)
 테스트 8 〉    통과 (0.22ms, 16.3MB)
 테스트 9 〉    통과 (0.31ms, 16.3MB)
 테스트 10 〉    통과 (0.87ms, 16.4MB)
 테스트 11 〉    통과 (2.33ms, 16.4MB)
 테스트 12 〉    통과 (0.33ms, 16.4MB)
 테스트 13 〉    통과 (2.05ms, 16.6MB)
 테스트 14 〉    통과 (1.81ms, 16.2MB)
 테스트 15 〉    통과 (2.05ms, 16.6MB)
 테스트 16 〉    통과 (0.09ms, 16.6MB)
 */
