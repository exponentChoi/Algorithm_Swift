//
//  내리막 길.swift
//  깊이 우선 탐색 (Depth-first Search)
//
//  Created by 최지수 on 2021/12/17.
//

/**
 [문제]
 여행을 떠난 세준이는 지도를 하나 구하였다. 이 지도는 아래 그림과 같이 직사각형 모양이며 여러 칸으로 나뉘어져 있다. 한 칸은 한 지점을 나타내는데 각 칸에는 그 지점의 높이가 쓰여 있으며, 각 지점 사이의 이동은 지도에서 상하좌우 이웃한 곳끼리만 가능하다.

 @그림 1

 현재 제일 왼쪽 위 칸이 나타내는 지점에 있는 세준이는 제일 오른쪽 아래 칸이 나타내는 지점으로 가려고 한다. 그런데 가능한 힘을 적게 들이고 싶어 항상 높이가 더 낮은 지점으로만 이동하여 목표 지점까지 가고자 한다. 위와 같은 지도에서는 다음과 같은 세 가지 경로가 가능하다.

 @그림2
 
 지도가 주어질 때 이와 같이 제일 왼쪽 위 지점에서 출발하여 제일 오른쪽 아래 지점까지 항상 내리막길로만 이동하는 경로의 개수를 구하는 프로그램을 작성하시오.

 [입력]
 첫째 줄에는 지도의 세로의 크기 M과 가로의 크기 N이 빈칸을 사이에 두고 주어진다. 이어 다음 M개 줄에 걸쳐 한 줄에 N개씩 위에서부터 차례로 각 지점의 높이가 빈 칸을 사이에 두고 주어진다. M과 N은 각각 500이하의 자연수이고, 각 지점의 높이는 10000이하의 자연수이다.

 [출력]
 첫째 줄에 이동 가능한 경로의 수 H를 출력한다. 모든 입력에 대하여 H는 10억 이하의 음이 아닌 정수이다.

[예제 입력 1]
4 5
50 45 37 32 30
35 50 40 20 25
30 30 25 17 28
27 24 22 15 10
[예제 출력 1]
3
 
 */

/**
 DP + DFS 문제이다......
 방문했던 곳을 똑같은 방법으로 길을 찾는것은 매우 비효율적인 방법이다.
 */
import Foundation

/// 내리막길 [1520번]
func 내리막길() {
    let size = readLine()!.split(separator: " ").compactMap { Int($0) }
    let directions = [(0, 1), (1, 0), (0, -1), (-1, 0)] // 이동할 방향 (남, 동, 북, 서)
    
    var dp = Array(repeating: Array(repeating: 0, count: size[1]), count: size[0]) // DP용 맵 생성
    let matrix = (0..<size[0]).map { _ in readLine()!.split(separator: " ").compactMap { Int($0) }} // 입력받은 이차원배열
    
    func dfs(_ x: Int, _ y: Int) -> Int {
        if x == size[0] - 1 && y == size[1] - 1 {
            return 1
        }
        
        // 네 방향으로 반복문 실행
        for direction in directions {
            let nx = direction.0 + x
            let ny = direction.1 + y
            
            // 범위를 벗어난 경우 continue
            if size[0] <= nx || nx < 0 || size[1] <= ny || ny < 0 { continue }

            // 다음 방향에 이동한 숫자가 현재보다 낮은 경우에만 진행 (내리막 길)
            if matrix[x][y] > matrix[nx][ny] {
                
                
                if dp[nx][ny] == 0 { // dp가 처음인 경우
                    dp[x][y] += dfs(nx, ny) // dfs로 뽑을 수 있는 경우의 수를 더하여 DP에 저장한다.
                    
                } else if dp[nx][ny] > 0 { // dp가 처음이 아닌 경우
                    // 다음 방향의 좌표에 저장된 경우의 수를 현재 좌표에 더한다.
                    dp[x][y] += dp[nx][ny]
                }
            }
        }
        
        if dp[x][y] == 0 { // 현재 위치에 저장된 값이 0인 경우
            dp[x][y] = -1 // 현재 위치에 해당하는 DP에 -1을 저장한다.
            return 0 // 저장된 값이 없으므로 0을 반환.
        } else {
            return dp[x][y] // dp에 저장된 경우의 수를 반환.
        }
    }
    
    let solution = dfs(0, 0) // dfs 시작!
    
    print(solution == -1 ? 0 : solution) // 최종값 저장.
}
