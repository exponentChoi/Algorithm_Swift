/**
 Level 3 - 깊이/너비 우선 탐색(DFS/BFS)

 [문제 설명]
 네트워크란 컴퓨터 상호 간에 정보를 교환할 수 있도록 연결된 형태를 의미합니다. 예를 들어, 컴퓨터 A와 컴퓨터 B가 직접적으로 연결되어있고, 컴퓨터 B와 컴퓨터 C가 직접적으로 연결되어 있을 때 컴퓨터 A와 컴퓨터 C도 간접적으로 연결되어 정보를 교환할 수 있습니다. 따라서 컴퓨터 A, B, C는 모두 같은 네트워크 상에 있다고 할 수 있습니다.

 컴퓨터의 개수 n, 연결에 대한 정보가 담긴 2차원 배열 computers가 매개변수로 주어질 때, 네트워크의 개수를 return 하도록 solution 함수를 작성하시오.

 [제한사항]
 컴퓨터의 개수 n은 1 이상 200 이하인 자연수입니다.
 각 컴퓨터는 0부터 n-1인 정수로 표현합니다.
 i번 컴퓨터와 j번 컴퓨터가 연결되어 있으면 computers[i][j]를 1로 표현합니다.
 computer[i][i]는 항상 1입니다.
 
 [입출력 예]
 [n]    [computers]                                    [return]
 3          [[1, 1, 0], [1, 1, 0], [0, 0, 1]]       2
 3          [[1, 1, 0], [1, 1, 1], [0, 1, 1]]       1
 
 [입출력 예 설명]
 [예제 #1]
 아래와 같이 2개의 네트워크가 있습니다.
 @image0.png

 [예제 #2]
 아래와 같이 1개의 네트워크가 있습니다.
 @image1.png
 */

import Foundation

func solution(_ n:Int, _ computers:[[Int]]) -> Int {
    var linked: [Bool] = Array(repeating: false, count: n) // 연결 상태를 저장하는 변수
    var network: Int = 0
    
    // 해당 컴퓨터와 연결된 컴퓨터를 찾고, 그 컴퓨터와 연결된 컴퓨터를 탐색해 linked를 true로 바꿔준다.
    func bfs(_ computer: Int) {
        linked[computer] = true
        
        for i in 0..<n {
            // 컴퓨터가 연결되어 있고, 서로 연결이 안되어있는 상태인지 확인한다.
            if computers[computer][i] == 1 && linked[i] == false {
                bfs(i)
            }
        }
    }
    
    for i in 0..<n {
        if !linked[i] { // 연결이 안된경우
            network += 1
            bfs(i)
        }
    }
    
    return network
}

print(solution(3, [[1, 1, 0], [1, 1, 0], [0, 0, 1]])) // 2
print(solution(3, [[1, 1, 0], [1, 1, 1], [0, 1, 1]])) // 1
print(solution(4, [[1, 0, 0, 1], [0, 1, 1, 0], [0, 1, 1, 1],[1, 0, 1, 1]])) // 1
