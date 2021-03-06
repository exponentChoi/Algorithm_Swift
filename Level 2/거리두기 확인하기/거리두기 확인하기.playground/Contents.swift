/**
 난이도: Level 2 - 2021 카카오 채용연계형 인턴십
 
 [문제 설명]
 개발자를 희망하는 죠르디가 카카오에 면접을 보러 왔습니다.

 코로나 바이러스 감염 예방을 위해 응시자들은 거리를 둬서 대기를 해야하는데 개발 직군 면접인 만큼
 아래와 같은 규칙으로 대기실에 거리를 두고 앉도록 안내하고 있습니다.

 대기실은 5개이며, 각 대기실은 5x5 크기입니다.
 거리두기를 위하여 응시자들 끼리는 맨해튼 거리가 2 이하로 앉지 말아 주세요.
 [맨해튼 거리]
 - 두 테이블 T1, T2가 행렬 (r1, c1), (r2, c2)에 각각 위치하고 있다면, T1, T2 사이의 맨해튼 거리는 |r1 - r2| + |c1 - c2| 입니다. ↩
 
 단 응시자가 앉아있는 자리 사이가 파티션으로 막혀 있을 경우에는 허용합니다.
 예를 들어,

 @PXP.png    PX_XP.png    PX_OP.png  [Resources 확인하기]
 위 그림처럼 자리 사이에 파티션이 존재한다면 맨해튼 거리가 2여도 거리두기를 지킨 것입니다.    위 그림처럼 파티션을 사이에 두고 앉은 경우도 거리두기를 지킨 것입니다.    위 그림처럼 자리 사이가 맨해튼 거리 2이고 사이에 빈 테이블이 있는 경우는 거리두기를 지키지 않은 것입니다.
 @P.png    O.png    X.png [Resources 확인하기]
 응시자가 앉아있는 자리(P)를 의미합니다.    빈 테이블(O)을 의미합니다.    파티션(X)을 의미합니다.
 5개의 대기실을 본 죠르디는 각 대기실에서 응시자들이 거리두기를 잘 기키고 있는지 알고 싶어졌습니다. 자리에 앉아있는 응시자들의 정보와 대기실 구조를 대기실별로 담은 2차원 문자열 배열 places가 매개변수로 주어집니다. 각 대기실별로 거리두기를 지키고 있으면 1을, 한 명이라도 지키지 않고 있으면 0을 배열에 담아 return 하도록 solution 함수를 완성해 주세요.

 [제한사항]
 places의 행 길이(대기실 개수) = 5
 places의 각 행은 하나의 대기실 구조를 나타냅니다.
 places의 열 길이(대기실 세로 길이) = 5
 places의 원소는 P,O,X로 이루어진 문자열입니다.
 places 원소의 길이(대기실 가로 길이) = 5
 P는 응시자가 앉아있는 자리를 의미합니다.
 O는 빈 테이블을 의미합니다.
 X는 파티션을 의미합니다.
 입력으로 주어지는 5개 대기실의 크기는 모두 5x5 입니다.
 return 값 형식
 1차원 정수 배열에 5개의 원소를 담아서 return 합니다.
 places에 담겨 있는 5개 대기실의 순서대로, 거리두기 준수 여부를 차례대로 배열에 담습니다.
 각 대기실 별로 모든 응시자가 거리두기를 지키고 있으면 1을, 한 명이라도 지키지 않고 있으면 0을 담습니다.
 
 [입출력 예]
 places
 [["POOOP", "OXXOX", "OPXPX", "OOXOX", "POXXP"],
 ["POOPX", "OXPXP", "PXXXO", "OXXXO", "OOOPP"],
 ["PXOPX", "OXOXP", "OXPOX", "OXXOP", "PXPOX"],
 ["OOOXX", "XOOOX", "OOOXX", "OXOOX", "OOOOO"],
 ["PXPXP", "XPXPX", "PXPXP", "XPXPX", "PXPXP"]]
 
 result
 [1, 0, 1, 1, 1]
 */

import Foundation

func solution(_ places:[[String]]) -> [Int] {
    var answer:[Int] = []
    
    places.forEach { place in
        let newPlace = place.map { $0.map { String($0) }} // 문자열을 하나씩 분리하기
        answer.append(distance(newPlace))
    }
        
    return answer
}


func distance(_ places:[[String]]) -> Int {
    let dx = [1, 2, 0, 0, 1, -1] // x좌표를 이동하여 확인하기 위함. (-1은 왼쪽 아래의 경우도 확인을 해야하기 때문)
    let dy = [0, 0, 1, 2, 1, 1] // y좌표를 이동하여 확인하기 위함.
    
    for row in 0..<5 {
        for col in 0..<5 {
            if places[row][col] == "P" {
                for i in 0..<dx.count {

                    let (x, y) = (row + dx[i], col + dy[i])
                
                    // x, y 범위가 벗어나지 않고, (x,y)가 "P"인 경우
                    if (0..<5).contains(x) && (0..<5).contains(y) && places[x][y] == "P" {
                        if abs(row - x) + abs(col - y) == 1 { // 맨해튼거리가 0인경우 거리두기를 지키지 않은것임.
                            return 0
                        }
                        if row == x { // 같은 row에 있는 경우
                            if places[row][col + 1] != "X" { // 가운데가 "X(파티션)"인지 확인
                                return 0
                            }
                        } else if col == y {  // 같은 col에 있는 경우
                            if places[row + 1][col] != "X" { // 가운데가 "X(파티션)"인지 확인
                                return 0
                            }
                        } else {
                            if row > x { // row가 x보다 앞에 있는 경우
                                // 대각선 사이에 파티션이 두개가 있는지 파악하여 없으면 0 반환
                                if places[row - 1][col] != "X" || places[row][col + 1] != "X"{
                                    return 0
                                }
                            } else {
                                // 대각선 사이에 파티션이 두개가 있는지 파악하여 없으면 0 반환
                                if places[row + 1][col] != "X" || places[row][col + 1] != "X"{
                                    return 0
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    return 1
}



print(solution([["POOOP", "OXXOX", "OPXPX", "OOXOX", "POXXP"],
                ["POOPX", "OXPXP", "PXXXO", "OXXXO", "OOOPP"],
                ["PXOPX", "OXOXP", "OXPOX", "OXXOP", "PXPOX"],
                ["OOOXX", "XOOOX", "OOOXX", "OXOOX", "OOOOO"],
                ["PXPXP", "XPXPX", "PXPXP", "XPXPX", "PXPXP"],
                ["PPPOO","PXXXX","OOOOO","OOOOO","OOOOO"]])) // [1, 0, 1, 1, 1, 0]

print(solution([["XPOOO",
                 "PXXXX",
                 "OOOOO",
                 "OOOPX",
                 "OOOXP"]]))
