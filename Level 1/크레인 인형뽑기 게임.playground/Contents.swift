/**
 난이도: Level 1..?? (2019 카카오 개발자 겨울 인턴십)
 
 문제설명: 링크로 대체
 https://programmers.co.kr/learn/courses/30/lessons/64061
 
 [제한사항]
 board 배열은 2차원 배열로 크기는 "5 x 5" 이상 "30 x 30" 이하입니다.
 board의 각 칸에는 0 이상 100 이하인 정수가 담겨있습니다.
 0은 빈 칸을 나타냅니다.
 1 ~ 100의 각 숫자는 각기 다른 인형의 모양을 의미하며 같은 숫자는 같은 모양의 인형을 나타냅니다.
 moves 배열의 크기는 1 이상 1,000 이하입니다.
 moves 배열 각 원소들의 값은 1 이상이며 board 배열의 가로 크기 이하인 자연수입니다.
 입출력 예
 board: [[0,0,0,0,0], [0,0,1,0,3], [0,2,5,0,1] ,[4,2,4,4,2], [3,5,1,3,1]]
 moves: [1,5,3,5,1,2,1,4]
 result: 4
 */

import Foundation

func solution(_ board:[[Int]], _ moves:[Int]) -> Int {
    var move = moves // 각 자리 수를 하나씩 제거하기 위해 변수로 사용
    var boards = board // 인형을 뽑은 자리는 0으로 바꿔야 하기 떄문에 변수로 사용
    var stack: [Int] = [] // 뽑은 인형을 하나하나 쌓는 배열
    var count = 0 // 터진 인형의 count를 구하는 변수
    
    // 크레인의 위치가 모두 끝나면 반복문 종료
    while !move.isEmpty {
        let moveX = move.first! // 크레인의 위치 배열 중 첫번 째 항목
        move.removeFirst() // 크레인의 위치 배열 중 첫번 째 항목 지정후 남은 배열에서 제거
        let back = moveX - 1 // 2차원 배열에서 몇번 째 요소인지 확인하기(index가 아닌 위치이므로 -1을 해준다.)
        
        // 2차원 배열의 요소만 구하면 되므로 1차원 배열만큼 반복문을 돌린다.
        for i in 0..<board.count {
            if boards[i][back] != 0 { // 크레인의 위치로 탐색했을 때 0이 아닌경우 인형이다.
                stack.append(boards[i][back]) // 0이 아닌경우 인형이므로 stack에 쌓는다.
                boards[i][back] = 0 // board에서 뽑은 인형은 0으로 바꿔준다.
                break // for문 종료
            } else {
                continue // 인형이 아닌경우 for문 계속 이어간다.
            }
        }
        
        // 쌓인 인형을 비교하기 위해서는 2개 이상이 필요하므로 분기처리 한다.
        if stack.count > 1 {
            let resultPop = popDoll(stack) // 쌓인 인형을 비교 후 stack을 반환해주고, 터진 인형 갯수도 반환해준다. return (stack, count)
            count += resultPop.1 // 터진 인형의 갯수
            stack = resultPop.0 // 비교 후 반환된 stack
            
        }
    }
    
    return count // 최종적으로 터진 인형 갯수
}

// 인형
func popDoll(_ dollStacks: [Int]) -> ([Int], Int) {
    var dolls = dollStacks // 인형 stack
    let lastDoll = dolls.last! // 인형 stack중 마지막 인형
    dolls.removeLast() // stack에서 마지막 인형을 제거 한다. (마지막 인형과 마지막에서 두번 째 인형을 비교하기 위함)
    
    if lastDoll == dolls.last! { // 마지막 인형과 마지막에서 두번 째 인형을 비교한다.
        dolls.removeLast() // 동일한 인형일 경우 마지막 인형도 제거한다.
        return (dolls, 2) // 터트린 인형 stack과 터진 인형 수를 반환한다.
    } else {
        return (dollStacks, 0) // 동일한 인형이 아니므로 초기값을 반환한다.
    }
}

let board = [[0,0,0,0,0], // 보드 2차원 배열
             [0,0,1,0,3],
             [0,2,5,0,1],
             [4,2,4,4,2],
             [3,5,1,3,1]]

let moves = [1,5,3,5,1,2,1,4] // 집게의 위치
// 4, 3, 1, 1, 3, 2, 4

// [0,0,0,0,0],
// [0,0,0,0,0],
// [0,0,5,0,1],
// [0,2,4,0,2],
// [0,5,1,3,1]


print(solution(board, moves))
