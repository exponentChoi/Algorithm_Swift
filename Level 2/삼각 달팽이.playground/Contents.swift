/**
 난이도: Level 2
 
 [문제 설명]
 정수 n이 매개변수로 주어집니다. 다음 그림과 같이 밑변의 길이와 높이가 n인 삼각형에서 맨 위 꼭짓점부터 반시계 방향으로 달팽이 채우기를 진행한 후, 첫 행부터 마지막 행까지 모두 순서대로 합친 새로운 배열을 return 하도록 solution 함수를 완성해주세요.

 Resources/examples.png 참고

 제한사항
 n은 1 이상 1,000 이하입니다.
 입출력 예
 n      result
 4      [1,2,9,3,10,8,4,5,6,7]
 5      [1,2,12,3,13,11,4,14,15,10,5,6,7,8,9]
 6      [1,2,15,3,16,14,4,17,21,13,5,18,19,20,12,6,7,8,9,10,11]
 입출력 예 설명
 */

import Foundation

func solution(_ n:Int) -> [Int] {
    
    // 0으로 만든 피라미드 모양의 2차원 배열
    var pyramidArray = (0..<n).map { (0...$0).map { _ in 0 }}

    // 방향을 지정하는 타입
    enum Step {
        case down
        case right
        case up
    }
    
    var step: Step = .down // 피라미드에 숫자 쌓는 방식 (아래, 오른쪽, 위로)
    var num = 0 // 순차적으로 증가할 숫자
    var whileCount = 0 // down, right를 순차적으로 사용할 수 있도록 count를 저장한다.
    var downCount = 0 // 한바퀴가 돌고난 후 down을 1씩 증가시킨다.
    var rightCount = 0 // up에서 사용하기 위해 한바퀴가 돌고난 후 1 증가시킨다.
    var upCount = 2 // up이 몇번 증가했는지 알기 위해 한바퀴가 돌고난 후 1 증가시킨다.

    while true {
        switch step {
        case .down: // down
            if whileCount >= pyramidArray.count - downCount {
                break
            }
            
            for i in stride(from: whileCount, to: pyramidArray.count - downCount, by: +1) {
                num += 1
                pyramidArray[i][downCount] = num
            }

            step = .right
            whileCount += 1
        case .right: // right
            if whileCount >= pyramidArray.count - downCount {
                break
            }
            
            for i in stride(from: whileCount, to: pyramidArray.count - downCount, by: +1) {
                num += 1
                pyramidArray[pyramidArray.count - (downCount + 1)][i - downCount] = num
            }

            
            step = .up
            whileCount += 1
        case .up: // up
            if (rightCount * 2) >= pyramidArray.count - upCount {
                break
            }
            
            for i in stride(from: pyramidArray.count - upCount, to: (rightCount * 2), by: -1) {
                num += 1
                pyramidArray[i][pyramidArray[i].count - (upCount - 1)] = num
            }

            step = .down
            rightCount += 1
            downCount += 1
            upCount += 1
        }
    }
    
    
    
    print("-----------------")
    
    pyramidArray.forEach {
        print($0)
    }
    print("-----------------")
    
    
    var answer:[Int] = []
    
    pyramidArray.forEach {
        $0.forEach { i in
            answer.append(i)
        }
    }
    
    return answer
}

print(solution(4))
print(solution(5))
print(solution(6))
print(solution(7))
print(solution(8))
print(solution(9))
