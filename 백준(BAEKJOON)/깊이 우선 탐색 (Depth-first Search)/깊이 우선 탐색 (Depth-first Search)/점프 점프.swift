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

/// 점프 점프 [14248번]
func 점프점프() {
    let bridge = Int(readLine()!)!
    let jumps = readLine()!.split(separator: " ").compactMap { Int($0) }
    let start = Int(readLine()!)! // 출발점
    var visits = Set<Int>()
    
    for i in 0..<jumps.count {
        var copy = jumps
        copy.remove(at: i)
        visits = visits.union(dfs(start: start - 1, jump: jumps[i], jumps: copy, bridge: bridge, visits: []))
    }
    
    let filter = visits.filter { $0 > 0 && $0 <= bridge }
    print(filter.count)
}

func dfs(start: Int, jump: Int, jumps: [Int], bridge: Int, visits: Set<Int>) -> Set<Int> {
    if jumps.isEmpty { return Set([start]) }
    
    var visit = visits
    visit.insert(start)
    
    for i in 0..<jumps.count {
        var copy = jumps
        copy.remove(at: i)
        
        if start + jump <= bridge {
            visit = visit.union(dfs(start: start + jump, jump: jumps[i], jumps: copy, bridge: bridge, visits: visit))
            visit = visit.union(dfs(start: start + jump, jump: -jumps[i], jumps: copy, bridge: bridge, visits: visit))
        }
        
        if start - jump >= bridge {
            visit = visit.union(dfs(start: start - jump, jump: jumps[i], jumps: copy, bridge: bridge, visits: visit))
            visit = visit.union(dfs(start: start - jump, jump: -jumps[i], jumps: copy, bridge: bridge, visits: visit))
        }
    }
    
    return visit
}
