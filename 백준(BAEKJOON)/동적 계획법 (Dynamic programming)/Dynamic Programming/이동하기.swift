//
//  이동하기.swift
//  Dynamic Programming
//
//  Created by 최지수 on 2021/11/01.
//

/**
 [문제]
 준규는 N×M 크기의 미로에 갇혀있다. 미로는 1×1크기의 방으로 나누어져 있고, 각 방에는 사탕이 놓여져 있다. 미로의 가장 왼쪽 윗 방은 (1, 1)이고, 가장 오른쪽 아랫 방은 (N, M)이다.

 준규는 현재 (1, 1)에 있고, (N, M)으로 이동하려고 한다. 준규가 (r, c)에 있으면, (r+1, c), (r, c+1), (r+1, c+1)로 이동할 수 있고, 각 방을 방문할 때마다 방에 놓여져있는 사탕을 모두 가져갈 수 있다. 또, 미로 밖으로 나갈 수는 없다.

 준규가 (N, M)으로 이동할 때, 가져올 수 있는 사탕 개수의 최댓값을 구하시오.

 [입력]
 첫째 줄에 미로의 크기 N, M이 주어진다. (1 ≤ N, M ≤ 1,000)

 둘째 줄부터 N개 줄에는 총 M개의 숫자가 주어지며, r번째 줄의 c번째 수는 (r, c)에 놓여져 있는 사탕의 개수이다. 사탕의 개수는 0보다 크거나 같고, 100보다 작거나 같다.

 [출력]
 첫째 줄에 준규가 (N, M)으로 이동할 때, 가져올 수 있는 사탕 개수를 출력한다.

 [예제 입력 1]
 3 4
 1 2 3 4
 0 0 0 5
 9 8 7 6
 [예제 출력 1]
 31
 
 [예제 입력 2]
 3 3
 1 0 0
 0 1 0
 0 0 1
 [예제 출력 2]
 3
 
 [예제 입력 3]
 4 3
 1 2 3
 6 5 4
 7 8 9
 12 11 10
 [예제 출력 3]
 47
 */

import Foundation

/// 이동하기 [11048번]
func 이동하기() {
    let size = readLine()!.split(separator: " ").compactMap { Int($0) }
    var board = [[Int]]() // 2차원 형태의 board를 미리 생성한다.
    
    for _ in 0..<size[0] {
        board.append(readLine()!.split(separator: " ").compactMap { Int($0) })
    }
    
    // 첫 칸부터 차근차근 더해가는 형식
    for i in 0..<size[0] {
        for j in 0..<size[1] {
            if (i == 0 && j == 0 ) { continue } // 0일 때 구할것이 없으므로 패스
            if (i == 0) { // (r+1, c)
                board[i][j] += board[i][j - 1]
            } else if j == 0 { // (r, c+1)
                board[i][j] += board[i - 1][j]
            } else { // (r+1, c+1)
                board[i][j] += max(board[i - 1][j], board[i][j - 1])
            }
        }
    }
    
    print(board.last!.max()!)
}
