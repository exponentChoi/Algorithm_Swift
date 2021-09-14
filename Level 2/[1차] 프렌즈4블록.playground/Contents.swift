/**
 난이도: Level 2 - 2018 KAKAO BLIND RECRUITMENT
 
 [문제 설명]
 프렌즈4블록
 블라인드 공채를 통과한 신입 사원 라이언은 신규 게임 개발 업무를 맡게 되었다. 이번에 출시할 게임 제목은 "프렌즈4블록".
 같은 모양의 카카오프렌즈 블록이 2×2 형태로 4개가 붙어있을 경우 사라지면서 점수를 얻는 게임이다.

 [@pang1.png]
 만약 판이 위와 같이 주어질 경우, 라이언이 2×2로 배치된 7개 블록과 콘이 2×2로 배치된 4개 블록이 지워진다. 같은 블록은 여러 2×2에 포함될 수 있으며, 지워지는 조건에 만족하는 2×2 모양이 여러 개 있다면 한꺼번에 지워진다.

 [@pang2.png]
 블록이 지워진 후에 위에 있는 블록이 아래로 떨어져 빈 공간을 채우게 된다.

 [@pang3.png]
 만약 빈 공간을 채운 후에 다시 2×2 형태로 같은 모양의 블록이 모이면 다시 지워지고 떨어지고를 반복하게 된다.
 
 [@pang4.png]

 위 초기 배치를 문자로 표시하면 아래와 같다.

 TTTANT
 RRFACC
 RRRFCC
 TRRRAA
 TTMMMF
 TMMTTJ
 
 각 문자는 라이언(R), 무지(M), 어피치(A), 프로도(F), 네오(N), 튜브(T), 제이지(J), 콘(C)을 의미한다

 입력으로 블록의 첫 배치가 주어졌을 때, 지워지는 블록은 모두 몇 개인지 판단하는 프로그램을 제작하라.

 [입력 형식]
 입력으로 판의 높이 m, 폭 n과 판의 배치 정보 board가 들어온다.
 2 ≦ n, m ≦ 30
 board는 길이 n인 문자열 m개의 배열로 주어진다. 블록을 나타내는 문자는 대문자 A에서 Z가 사용된다.
 
 [출력 형식]
 입력으로 주어진 판 정보를 가지고 몇 개의 블록이 지워질지 출력하라.

 [입출력 예제]
 m    n    board    answer
 4    5    ["CCBDE", "AAADE", "AAABF", "CCBBF"]    14
 6    6    ["TTTANT", "RRFACC", "RRRFCC", "TRRRAA", "TTMMMF", "TMMTTJ"]    15
 
 [예제에 대한 설명]
 입출력 예제 1의 경우, 첫 번째에는 A 블록 6개가 지워지고, 두 번째에는 B 블록 4개와 C 블록 4개가 지워져, 모두 14개의 블록이 지워진다.
 입출력 예제 2는 본문 설명에 있는 그림을 옮긴 것이다. 11개와 4개의 블록이 차례로 지워지며, 모두 15개의 블록이 지워진다.
 */

import Foundation

func solution(_ m:Int, _ n:Int, _ board:[String]) -> Int {
    var boards = board.map { $0.map { String($0)} } // board를 String 하나 단위로 분리한 이차배열
    var pang =  Array(repeating: Array(repeating: 0, count: n), count: m) // 4개가 만들어진 경우 1을 넣기위한 이차배열(boards에서 해당하는 좌표)
    var answer = 0 // 최종 반환 값
    
    while true {
        for i in 1..<m {
            for j in 1..<n {
                // 네모칸이 모두 동일한지 비교한다 또한 비어있는 값인지 확인한다.
                if !boards[i][j].isEmpty && boards[i][j] == boards[i - 1][j] && boards[i][j] ==  boards[i][j - 1] && boards[i][j] == boards[i - 1][j - 1] {
                    // 터진곳을 기록한다.
                    pang[i][j] = 1
                    pang[i][j - 1] = 1
                    pang[i - 1][j] = 1
                    pang[i - 1][j - 1] = 1
                }
            }
        }
        
        if !pang.flatMap({ $0 }).contains(1) { // 4개가 모여 터진것이 하나도 없는 경우 반복문을 즉시 종료한다.
            break
        }
        
        for i in 0..<m {
            for j in 0..<n {
                // 터진 부분만 검사하여 기록한다.
                if pang[i][j] == 1 {
                    pang[i][j] = 0
                    answer += 1
                    boards[i][j] = ""
                    
                    // 가장 아래부터 검사하여 블록을 한칸씩 아래로 떨어뜨린다.
                    for sIndex in stride(from: m - 1, to: 0, by: -1) {
                        if boards[sIndex][j] == "" {
                            boards[sIndex][j] = boards[sIndex - 1][j]
                            boards[sIndex - 1][j] = ""
                        }
                    }
                }
            }
        }
    }
    
    return answer
}


print(solution(4, 5, ["CCBDE", "AAADE", "AAABF", "CCBBF"])) // 14
print(solution(6, 6, ["TTTANT", "RRFACC", "RRRFCC", "TRRRAA", "TTMMMF", "TMMTTJ"])) // 15
print(solution(7, 2, ["AA", "BB", "AA", "BB", "ZZ", "ZZ", "CC"])) // 4
print(solution(6, 6, ["OXXOXX", "OXXXXX", "OOXXXX", "OXXOXX", "OXXXXX", "OOXXXX"])) // 30
print(solution(6, 6, ["AABBEE","AAAEEE","VAAEEV","AABBEE","AACCEE","VVCCEE" ])) // 32
print(solution(3,2, ["AA", "AA", "AB"])) // 4
print(solution(4,2, ["CC", "AA", "AA", "CC"])) // 8
print(solution(6,2, ["DD", "CC", "AA", "AA", "CC", "DD"])) // 12
print(solution(8,2, ["FF", "AA", "CC", "AA", "AA", "CC", "DD", "FF"])) // 8
print(solution(6,2, ["AA", "AA", "CC", "AA", "AA", "DD"])) // 8
print(solution(2,2,["AA", "AA"]) ) // 4
print(solution(2,2, ["AA", "AB"]) ) // 0
