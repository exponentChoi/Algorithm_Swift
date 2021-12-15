//
//  바이러스.swift
//  깊이 우선 탐색 (Depth-first Search)
//
//  Created by 최지수 on 2021/12/15.
//

/**
 [문제]
 신종 바이러스인 웜 바이러스는 네트워크를 통해 전파된다. 한 컴퓨터가 웜 바이러스에 걸리면 그 컴퓨터와 네트워크 상에서 연결되어 있는 모든 컴퓨터는 웜 바이러스에 걸리게 된다.

 예를 들어 7대의 컴퓨터가 <그림 1>과 같이 네트워크 상에서 연결되어 있다고 하자. 1번 컴퓨터가 웜 바이러스에 걸리면 웜 바이러스는 2번과 5번 컴퓨터를 거쳐 3번과 6번 컴퓨터까지 전파되어 2, 3, 5, 6 네 대의 컴퓨터는 웜 바이러스에 걸리게 된다. 하지만 4번과 7번 컴퓨터는 1번 컴퓨터와 네트워크상에서 연결되어 있지 않기 때문에 영향을 받지 않는다.

 어느 날 1번 컴퓨터가 웜 바이러스에 걸렸다. 컴퓨터의 수와 네트워크 상에서 서로 연결되어 있는 정보가 주어질 때, 1번 컴퓨터를 통해 웜 바이러스에 걸리게 되는 컴퓨터의 수를 출력하는 프로그램을 작성하시오.

 [입력]
 첫째 줄에는 컴퓨터의 수가 주어진다. 컴퓨터의 수는 100 이하이고 각 컴퓨터에는 1번 부터 차례대로 번호가 매겨진다. 둘째 줄에는 네트워크 상에서 직접 연결되어 있는 컴퓨터 쌍의 수가 주어진다. 이어서 그 수만큼 한 줄에 한 쌍씩 네트워크 상에서 직접 연결되어 있는 컴퓨터의 번호 쌍이 주어진다.

 [출력]
 1번 컴퓨터가 웜 바이러스에 걸렸을 때, 1번 컴퓨터를 통해 웜 바이러스에 걸리게 되는 컴퓨터의 수를 첫째 줄에 출력한다.

 [예제 입력 1]
 7
 6
 1 2
 2 3
 1 5
 5 2
 5 6
 4 7
 [예제 출력 1]
 4
 */

import Foundation

/// 바이러스 [2606번]
func 바이러스() {
    let computer = Int(readLine()!)! // 컴퓨터의 수
    let network = Int(readLine()!)! // 컴퓨터 쌍의 수
    var connected = [Int: [Int]]() // 각 컴퓨터의 번호와 연결된 목록
    for i in 1...computer {
        connected[i] = []
    }
    
    for _ in 0..<network {
        let paired = readLine()!.split(separator: " ").compactMap { Int($0) } // 쌍으로 연결된 항목
        connected[paired[0]]?.append(paired[1]) // 각 번호에 연결목록 추가
        connected[paired[1]]?.append(paired[0]) // 각 번호에 연결목록 추가
    }
    
    var infecteds: Set<Int> = [1] // 감염된 컴퓨터 저장(중복 x)
    
    func dfs(_ key: Int) {
        if let paired = connected[key] { // 쌍으로 연결된 항목이 있는 경우에만
            for i in 0..<paired.count {
                let infect = paired[i] // 해당 번호와 연결되어 있다면 감염이다.
                if !infecteds.contains(infect) { // 감염 목록에 있다면 pass
                    infecteds.insert(infect) // 감염 목록에 추가한다.
                    dfs(infect) // 감염된 컴퓨터와 연결된 컴퓨터를 찾으러 간다.
                }
            }
        }
    }
    
    dfs(1) // 1번 컴퓨터가 감염되었으므로 1번으로 시작한다.
    
    print(infecteds.count - 1) // 1번이 숙주이고, 1번이 감염시킨 개수는 1번을 뺀 개수를 출력한다.
}


