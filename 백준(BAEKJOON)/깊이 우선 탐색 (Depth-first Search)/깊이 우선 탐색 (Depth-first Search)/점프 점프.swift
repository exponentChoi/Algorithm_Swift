//
//  점프 점프.swift
//  깊이 우선 탐색 (Depth-first Search)
//
//  Created by 최지수 on 2021/12/13.
//

/**
 [문제]
 영우는 개구리다 개굴개굴개굴

 영우는 지금 n개의 돌이 일렬로 놓여있는 돌다리에 있다. 그리고 돌다리의 돌에는 숫자가 하나씩 적혀있다. 영우는 이 숫자가 적혀있는 만큼 왼쪽이나 오른쪽으로 점프할 수 있는데, 이때 돌다리 밖으로 나갈 수는 없다.

 영우는 이 돌다리에서 자기가 방문 가능한 돌들의 개수를 알고 싶어한다. 방문 가능하다는 것은 현재위치에서 다른 돌을 적절히 밟아 해당하는 위치로 이동이 가능하다는 뜻이다.

 현재 위치가 주어졌을 때, 영우가 방문 가능한 돌들의 개수를 출력하시오.

 [입력]
 첫 번째 줄에는 돌다리의 돌 개수 n이 주어진다.(1≤n≤100,000) 돌의 번호는 왼쪽부터 1번에서 n번이다. 다음 줄에는 그 위치에서 점프할 수 있는 거리 Ai가 주어진다.(1≤Ai≤100,000)

 다음 줄에는 출발점 s가 주어진다.(1≤s≤n)

 [출력]
 영우가 방문 가능한 돌들의 개수를 출력하시오.

 [예제 입력 1]
 5
 1 4 2 2 1
 3
 [예제 출력 1]
 5
 */
import Foundation

/**
 DFS문제로 분류되어 있지만 DFS로 풀이를 해보면 시간초과가 발생한다.
 */

/// 점프 점프 [14248번]
//func 점프점프() {
//    let bridge = Int(readLine()!)! // 돌다리의 돌 개수
//    let jumps = readLine()!.split(separator: " ").compactMap { Int($0) } // 점프할 수 있는 거리
//    let start = Int(readLine()!)! - 1 // 출발점
//    var visits = Set<Int>()
//
//    for i in 0..<jumps.count {
//        var copy = jumps
//        copy.remove(at: i)
//        visits = visits.union(dfs(start: start, jump: jumps[i], jumps: copy, bridge: bridge, visits: []))
//    }
//
//    print(visits.count)
//}
//
//func dfs(start: Int, jump: Int, jumps: [Int], bridge: Int, visits: Set<Int>) -> Set<Int> {
//    if start < 1 || start > bridge { return visits}
//    if jumps.isEmpty { return Set([start]) }
//
//    var visit = visits
//    visit.insert(start)
//
//    for i in 0..<jumps.count {
//        var copy = jumps
//        copy.remove(at: i)
//
//        if start + jump > bridge || start - jump < 0 || visit.contains(start + jump) || visit.contains(start - jump) {
//            continue
//        }
//
//        visit = visit.union(dfs(start: start + jump, jump: jumps[i], jumps: copy, bridge: bridge, visits: visit))
//        visit = visit.union(dfs(start: start - jump, jump: jumps[i], jumps: copy, bridge: bridge, visits: visit))
//    }
//
//    return visit
//}

/// 점프 점프 [14248번]
func 점프점프() {
    let bridge = Int(readLine()!)! // 돌다리의 돌 개수
    let jumps = readLine()!.split(separator: " ").compactMap { Int($0) } // 점프할 수 있는 거리
    let start = Int(readLine()!)! - 1 // 출발점
    var visited = (0..<bridge).map { _ in false } // 각 자리마다 방문여부
    var queue = [Int]() // 돌다리 위에 올라간 후 다음으로 이동하기 위해 대기중인 위치를 저장하는 큐
    var result = 0
    
    func bfs(current: Int) {
        queue.append(current)
        visited[current] = true
        result += 1
        
        while !queue.isEmpty { // queue의 대기가 다 사라질 때 까지.
            let node = queue.removeFirst()
            
            for i in [-jumps[node], jumps[node]] { // 왼쪽과 오른쪽으로 가기 위해 음수, 양수를 사용
                let jump = node + i
                
                // 점프한 곳이 (돌다리 범위 밖인 경우 and 아직 방문하지 않은 경우)
                // 이미 방문한 경우라면 굳이 또 방문할 필요가 없다. (BFS 특징)
                if 0 <= jump && jump < bridge && visited[jump] == false {
                    queue.append(jump)
                    result += 1
                    visited[jump] = true
                }
            }
        }
    }
    
    bfs(current: start)
    print(result)
}


