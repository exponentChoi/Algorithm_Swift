/**
 난이도: Level 2
 
 [문제 설명]
 1와 0로 채워진 표(board)가 있습니다. 표 1칸은 1 x 1 의 정사각형으로 이루어져 있습니다. 표에서 1로 이루어진 가장 큰 정사각형을 찾아 넓이를 return 하는 solution 함수를 완성해 주세요. (단, 정사각형이란 축에 평행한 정사각형을 말합니다.)

 [예를 들어]
 1    2    3    4
 ㅡ ㅡ ㅡ ㅡ ㅡ
 0    1    1    1
 1    1    1    1
 1    1    1    1
 0    0    1    0
 가 있다면 가장 큰 정사각형은

 1    2    3    4
 ㅡ ㅡ ㅡ ㅡ ㅡ
 0    #    #    #
 1    #    #    #
 1    #    #    #
 0    0    1    0
 가 되며 넓이는 9가 되므로 9를 반환해 주면 됩니다.

 제한사항
 표(board)는 2차원 배열로 주어집니다.
 표(board)의 행(row)의 크기 : 1,000 이하의 자연수
 표(board)의 열(column)의 크기 : 1,000 이하의 자연수
 표(board)의 값은 1또는 0으로만 이루어져 있습니다.
 입출력 예
 board                                                               answer
 [[0,1,1,1],[1,1,1,1],[1,1,1,1],[0,0,1,0]]      9
 [[0,0,1,1],[1,1,1,1]]                                       4
 */
import Foundation

func solution(_ board:[[Int]]) -> Int {
    var copy = board // width를 저장할 board 복사본
    
    // 행이 하나인 경우 정사각형의 크기는 1이다.
    if board.count == 1 || board.first?.count == 1 {
        for i in 0..<board.count { // filter를 사용하면 모든 숫자를 비교하기 때문에 오래걸린다.
            for j in 0..<board[i].count {
                if board[i][j] == 1 { // 1이 하나라도 포함되면 넓이 1 반환.
                    return 1
                }
            }
        }
        
        return 0
    }
    
    var maxWidth = board[0][0] // 0 또는 1이 현재 가장 큰 width가 된다.
    
    for i in 1..<board.count {
        for j in 1..<board[i].count {
            if board[i][j] == 1 { // 1인 경우에만 정사각형 만드는 조건이 성립된다.
                
                // 위, 왼위, 왼쪽 중 가장 작은 수를 현재 숫자에 더한다.
                // 만약 0이 포함되어있으면 정사각형이 아니므로 0이 추가된다.
                copy[i][j] += min(copy[i - 1][j], copy[i][j - 1], copy[i - 1][j - 1])
                
                maxWidth = max(maxWidth, copy[i][j]) // 바로 위에서 더한값과 저장되어있는 width값을 비교하여 큰 숫자를 저장한다.
            }
        }
    }
    
    // pow(밑: Double, 지수: Int) -> Double (거듭제곱 구하는 함수)
    return Int(pow(Double(maxWidth), 2))
}


print(solution([[0,1,1,1],[1,1,1,1],[1,1,1,1],[0,0,1,0]])) // 9
print(solution([[0,0,1,1],[1,1,1,1]])) // 4
print(solution([[1,0],[0,0]])) // 1
print(solution([[1],[0]])) // 1
print(solution([[0],[0],[1]])) // 1
print(solution([[0,1,0,0]])) // 1
