/**
 난이도: Level 2 - 깊이/너비 우선 탐색(DFS/BFS)

 [문제 설명]
 n개의 음이 아닌 정수가 있습니다. 이 수를 적절히 더하거나 빼서 타겟 넘버를 만들려고 합니다. 예를 들어 [1, 1, 1, 1, 1]로 숫자 3을 만들려면 다음 다섯 방법을 쓸 수 있습니다.

 -1+1+1+1+1 = 3
 +1-1+1+1+1 = 3
 +1+1-1+1+1 = 3
 +1+1+1-1+1 = 3
 +1+1+1+1-1 = 3
 사용할 수 있는 숫자가 담긴 배열 numbers, 타겟 넘버 target이 매개변수로 주어질 때 숫자를 적절히 더하고 빼서 타겟 넘버를 만드는 방법의 수를 return 하도록 solution 함수를 작성해주세요.

 [제한사항]
 주어지는 숫자의 개수는 2개 이상 20개 이하입니다.
 각 숫자는 1 이상 50 이하인 자연수입니다.
 타겟 넘버는 1 이상 1000 이하인 자연수입니다.
 입출력 예
 numbers              target    return
 [1, 1, 1, 1, 1]      3           5
 */

// [1,2,3,4]일 때 모든 경우의 수
//  1 + 2 + 3 + 4 | -1 + 2 + 3 + 4
//            - 4 |            - 4
//        - 3 + 4 |        - 3 + 4
//            - 4 |            - 4
// -------------- | --------------
//  1 - 2 + 3 + 4 | -1 - 2 + 3 + 4
//            - 4 |            - 4
//        - 3 + 4 |        - 3 + 4
//            - 4 |            - 4

import Foundation

func solution(_ numbers:[Int], _ target:Int) -> Int {
    return DFS(index: 0, total: 0, numbers: numbers, target: target)
}

/// - Parameters:
///     - index: numbers의 value를 찾기 위함 (0..numbers.count)
///     - total: index에 해당하는 numbers를 더한 값
///     - numbers: 주어진 숫자 배열
///     - target: 구해야 할 숫자
func DFS(index: Int, total: Int, numbers: [Int], target: Int) -> Int {
    if index == numbers.count { // index가 마지막인 경우
        // total과 target을 비교하여 일치하는 경우 1을 반환한다.
        return total == target ? 1 : 0
    }
    
    var count = 0 // 모든 경우의 수의 합에서 target과 일치한 갯수만큼 저장한다.
    count += DFS(index: index + 1, total: total + numbers[index], numbers: numbers, target: target)
    count += DFS(index: index + 1, total: total - numbers[index], numbers: numbers, target: target)
    
    return count
}


print(solution([1, 1, 1, 1, 1], 3))
//print(solution([1,2,3,4], 4))
//print(solution([1,2,3], 3))
