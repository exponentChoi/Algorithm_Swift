//
//  쉬운 계단 수.swift
//  Dynamic Programming
//
//  Created by 최지수 on 2021/11/07.
//

/**
 [문제]
 45656이란 수를 보자.

 이 수는 인접한 모든 자리의 차이가 1이다. 이런 수를 계단 수라고 한다.

 N이 주어질 때, 길이가 N인 계단 수가 총 몇 개 있는지 구해보자. 0으로 시작하는 수는 계단수가 아니다.

 [입력]
 첫째 줄에 N이 주어진다. N은 1보다 크거나 같고, 100보다 작거나 같은 자연수이다.

 [출력]
 첫째 줄에 정답을 1,000,000,000으로 나눈 나머지를 출력한다.

 [예제 입력 1]
 1
 [예제 출력 1]
 9
 
 [예제 입력 2]
 2
 [예제 출력 2]
 17
 */

import Foundation

/// 쉬운 계단 수 [10844번]
func 쉬운계단수() {
    let n = Int(readLine()!)! //수의 길이
    var dp = Array(repeating: Array(repeating: 0, count: 10), count: n + 1) // 각 생성할 수 있는 횟수를 이차원 배열로 저장한다.
    let mod = 1_000_000_000

    for i in 1...9 { // 계단수가 1인 경우 0을 제외하고 각 1개씩 계단생성이 가능하다.
        dp[1][i] = 1
    }

    for i in stride(from: 2, through: n, by: 1) {
        for j in 0...9 {
            if j == 0 { // 0인 경우 1로 만들 수 있는 경우의 수만 저장한다.
                dp[i][j] = dp[i - 1][j + 1] % mod
            } else if j == 9 { // 9인 경우 8로 만들 수 있는 경우의 수만 저장한다.
                dp[i][j] = dp[i - 1][j - 1] % mod
            } else { // (i - 1)과 (i + 1)로 만든 경우의 수를 저장한다.
                dp[i][j] = (dp[i - 1][j - 1] + dp[i - 1][j + 1]) % mod
            }
        }
    }
    
    print(dp[n].reduce(0, +) % mod)
}

