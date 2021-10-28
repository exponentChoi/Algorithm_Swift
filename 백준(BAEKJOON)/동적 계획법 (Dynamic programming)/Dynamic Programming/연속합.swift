//
//  연속합.swift
//  Dynamic Programming
//
//  Created by 최지수 on 2021/10/27.
//

/**
 [문제]
 n개의 정수로 이루어진 임의의 수열이 주어진다. 우리는 이 중 연속된 몇 개의 수를 선택해서 구할 수 있는 합 중 가장 큰 합을 구하려고 한다. 단, 수는 한 개 이상 선택해야 한다.

 예를 들어서 10, -4, 3, 1, 5, 6, -35, 12, 21, -1 이라는 수열이 주어졌다고 하자. 여기서 정답은 12+21인 33이 정답이 된다.

 [입력]
 첫째 줄에 정수 n(1 ≤ n ≤ 100,000)이 주어지고 둘째 줄에는 n개의 정수로 이루어진 수열이 주어진다. 수는 -1,000보다 크거나 같고, 1,000보다 작거나 같은 정수이다.

 [출력]
 첫째 줄에 답을 출력한다.

 [예제 입력 1]
 10
 10 -4 3 1 5 6 -35 12 21 -1
 [예제 출력 1]
 33
 
 [예제 입력 2]
 10
 2 1 -4 3 4 -4 6 5 -5 1
 [예제 출력 2]
 14
 
 [예제 입력 3]
 5
 -1 -2 -3 -4 -5
 [예제 출력 3]
 -1
 */

import Foundation

/// 연속합 [1912번]
func 연속합() {
    /* 시간초과 발생
    let _ = readLine()
    let numbers = readLine()!.split(separator: " ").compactMap { Int($0) }
    var maxNumber = Int.min
     
    for i in numbers.indices {
        for j in i..<numbers.count {
            maxNumber = max(maxNumber, numbers[i...j].reduce(0, +))
        }
    }
     
    print(maxNumber)
    */
    
    let _ = readLine()
    let numbers = readLine()!.split(separator: " ").compactMap { Int($0) }
    var maxNumber = numbers.max()!
    var sum = 0
    
    for number in numbers {
        sum += number
        sum = max(sum, number) // 저장된 숫자들과 현재 숫자를 비교하여 큰 값을 저장한다.
        maxNumber = max(sum, maxNumber) // 최초의 max값과 더해진 숫자들을 비교하여 큰값을 저장한다.
    }
    
    print(maxNumber)
}



