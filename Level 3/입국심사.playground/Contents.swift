/**
 Level 3 - 이분탐색
 
 [문제 설명]
 n명이 입국심사를 위해 줄을 서서 기다리고 있습니다. 각 입국심사대에 있는 심사관마다 심사하는데 걸리는 시간은 다릅니다.

 처음에 모든 심사대는 비어있습니다. 한 심사대에서는 동시에 한 명만 심사를 할 수 있습니다. 가장 앞에 서 있는 사람은 비어 있는 심사대로 가서 심사를 받을 수 있습니다. 하지만 더 빨리 끝나는 심사대가 있으면 기다렸다가 그곳으로 가서 심사를 받을 수도 있습니다.

 모든 사람이 심사를 받는데 걸리는 시간을 최소로 하고 싶습니다.

 입국심사를 기다리는 사람 수 n, 각 심사관이 한 명을 심사하는데 걸리는 시간이 담긴 배열 times가 매개변수로 주어질 때, 모든 사람이 심사를 받는데 걸리는 시간의 최솟값을 return 하도록 solution 함수를 작성해주세요.

 [제한사항]
 입국심사를 기다리는 사람은 1명 이상 1,000,000,000명 이하입니다.
 각 심사관이 한 명을 심사하는데 걸리는 시간은 1분 이상 1,000,000,000분 이하입니다.
 심사관은 1명 이상 100,000명 이하입니다.
 
 [입출력 예]
 [n]    [times]    [return]
  6       [7, 10]      28
 
 [입출력] 예 설명
 가장 첫 두 사람은 바로 심사를 받으러 갑니다.

 7분이 되었을 때, 첫 번째 심사대가 비고 3번째 사람이 심사를 받습니다.

 10분이 되었을 때, 두 번째 심사대가 비고 4번째 사람이 심사를 받습니다.

 14분이 되었을 때, 첫 번째 심사대가 비고 5번째 사람이 심사를 받습니다.

 20분이 되었을 때, 두 번째 심사대가 비지만 6번째 사람이 그곳에서 심사를 받지 않고 1분을 더 기다린 후에 첫 번째 심사대에서 심사를 받으면 28분에 모든 사람의 심사가 끝납니다.
 */

/**
 출처 - https://tngusmiso.tistory.com/37
 
 1분 차이동안 완료되는 사람의 수가 여러명일 수 있음을 고려하기
 사실 나는 '몇분동안 n명을 해결할 수 있는가'에만 집중해서 mid분동안 n명일 경우를 반환 조건으로 두었다.

 하지만 예를들어, n = 3, times = [1, 1, 2] 일 경우 답은 2이다.
 하지만 2분동안 총 5명이 완료, 1분동안 총 2명이 완료할 수 있으므로

 즉, 1분 사이에 완료될 수 있는 사람이 여러명이 될 수 있기 때문에 딱 n명으로 떨어지지 않는 경우가 생기는 것이다.

 따라서
 mid분 동안 n명 이상이고, mid-1분동안 n명 미만이면 => mid 반환
 mid분 동안 n명 이상이고, mid-1분동안 n명 이상이면 => start ~ mid-1 탐색
 mid분 동안 n명 미만이고, mid+1분동안 n명 이상이면 -> mid+1 반환
 mid분 동안 n명 미만이고, mid+1분동안 n명 미만이면 -> mid+1 ~ end 탐색
 */

import Foundation

func solution(_ n:Int, _ times:[Int]) -> Int64 {

    // 이진탐색
    func binarySearch(start: Int64, end: Int64) -> Int64 {
        if start > end { return -1 } // 잘못된 입력이 들어오면 -1 반환
        
        let mid = (start + end) / 2
        let midSum = available(in: mid)
        
        // midSum >= n 일 경우
        if midSum >= n {
            if available(in: mid - 1) < n {
                return mid
            }
            return binarySearch(start: 0, end: mid - 1)
        }
        
        // midSum < n 일 경우
        if available(in: mid + 1) >= n {
            return mid + 1
        }
        return binarySearch(start: mid + 1, end: end)
    }
    
    // minute(분) 동안 총 몇명의 사람이 입국 심사대를 통과할 수 있는지 반환
    func available(in minute: Int64) -> Int64 {
        var sum: Int64 = 0
        
        for i in 0..<times.count {
            sum += minute / Int64(times[i])
        }
        return sum
    }
    
    let min = Int64(times.min()!)
    let max = Int64(n * times.max()!)
    return binarySearch(start: min, end: max)
}

print(solution(6, [7, 10])) // 28
print(solution(3, [1, 1, 2])) // 2
