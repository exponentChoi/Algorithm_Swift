//
//  숫자판 점프.swift
//  깊이 우선 탐색 (Depth-first Search)
//
//  Created by 최지수 on 2021/12/11.
//

/**
 [문제]
 5×5 크기의 숫자판이 있다. 각각의 칸에는 숫자(digit, 0부터 9까지)가 적혀 있다. 이 숫자판의 임의의 위치에서 시작해서, 인접해 있는 네 방향으로 다섯 번 이동하면서, 각 칸에 적혀있는 숫자를 차례로 붙이면 6자리의 수가 된다. 이동을 할 때에는 한 번 거쳤던 칸을 다시 거쳐도 되며, 0으로 시작하는 000123과 같은 수로 만들 수 있다.

 숫자판이 주어졌을 때, 만들 수 있는 서로 다른 여섯 자리의 수들의 개수를 구하는 프로그램을 작성하시오.

 [입력]
 다섯 개의 줄에 다섯 개의 정수로 숫자판이 주어진다.

 [출력]
 첫째 줄에 만들 수 있는 수들의 개수를 출력한다.

 [예제 입력 1]
 1 1 1 1 1
 1 1 1 1 1
 1 1 1 1 1
 1 1 1 2 1
 1 1 1 1 1
 [예제 출력 1]
 15
 */

import Foundation

/// 숫자판 점프 [2210번]
func 숫자판점프() {
//    let matrix = [["1", "1", "1", "1", "1"],
//                  ["1", "1", "1", "1", "1"],
//                  ["1", "1", "1", "1", "1"],
//                  ["1", "1", "1", "2", "1"],
//                  ["1", "1", "1", "1", "1"]]
    let matrix = (0..<5).compactMap { _ in readLine()!.split(separator: " ").map { String($0) }}
    var set = Set<String>() // 중복을 제거하기 위해 Set 사용
    let direction = [(0,1),(1,0),(0,-1),(-1,0)] // 방향

    func dfs(_ start: (Int, Int), str: String) {
        guard str.count < 6 else { // 글자가 6자리인 경우 함수 종료
            set.insert(str)
            return
        }
        
        for i in 0..<4 { // 방향이 총 네개이므로 4번 돌린다.
            let next = (start.0 + direction[i].0 , start.1 + direction[i].1) // 이동할 방향
            
            // 다음으로 진행할 방향이 범위를 벗어난 경우 패스한다.
            if next.0 >= 5 || next.1 >= 5 || next.0 < 0 || next.1 < 0 { continue }
            
            // 다음 방향을 적용 후 숫자를 더해준다.
            dfs((next.0, next.1), str: str + matrix[next.0][next.1])
        }
    }
    
    for i in 0..<5 {
        for j in 0..<5 {
            dfs((i, j), str: matrix[i][j])
        }
    }

    print(set.count) // 최종으로 저장된 개수를 출력한다.
}

