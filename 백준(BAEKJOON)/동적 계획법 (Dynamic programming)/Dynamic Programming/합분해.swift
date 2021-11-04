//
//  합분해.swift
//  Dynamic Programming
//
//  Created by 최지수 on 2021/11/04.
//

/**
 [문제]
 0부터 N까지의 정수 K개를 더해서 그 합이 N이 되는 경우의 수를 구하는 프로그램을 작성하시오.

 덧셈의 순서가 바뀐 경우는 다른 경우로 센다(1+2와 2+1은 서로 다른 경우). 또한 한 개의 수를 여러 번 쓸 수도 있다.

 [입력]
 첫째 줄에 두 정수 N(1 ≤ N ≤ 200), K(1 ≤ K ≤ 200)가 주어진다.

 [출력]
 첫째 줄에 답을 1,000,000,000으로 나눈 나머지를 출력한다.

 [예제 입력 1]
 20 2
 [예제 출력 1]
 21
 
 [예제 입력 2]
 6 4
 [예제 출력 2]
 84
 */

/**
 나의 생각
 - 1개가 필요할 때
 (0개의 i) + (1개의 i -1)

 - 2개가 필요할 때
 (1개의 i) + (2개의 i - 1)
 
 - 3개가 필요할 때
 (2개의 i) + (3개의 i - 1)
 
 */

import Foundation

/// 합분해 [2225번]
func 합분해() {
    let nk = readLine()!.split(separator: " ").map{Int(String($0))!}
    let n = nk[0]
    let k = nk[1]
    var dp = Array(repeating: Array(repeating: 0, count: n + 1), count: k + 1)

    for i in 0...k { // 모든 첫 번째는 한가지의 경우밖에 없다.
        dp[i][0] = 1
    }

    for i in 1...k {
        for j in 1...n {
            dp[i][j] = (dp[i - 1][j] + dp[i][j - 1]) % 1_000_000_000
        }
    }

    print(dp[k][n])
}
