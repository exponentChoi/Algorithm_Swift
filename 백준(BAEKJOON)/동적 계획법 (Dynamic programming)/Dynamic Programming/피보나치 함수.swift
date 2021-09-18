//
//  피보나치 함수.swift
//  Dynamic Programming
//
//  Created by 최지수 on 2021/09/18.
//

/**
 
 예제 입력 1
 3
 0
 1
 3
 
 예제 출력 1
 1 0
 0 1
 1 2
 */

import Foundation

/// 피보나치 함수
func 피보나치함수() {
    let n = Int(readLine()!)!
    let testCase = (0..<n).compactMap { _ in Int(readLine()!) }
    var dp = [(1, 0), (0, 1)]
    
    for i in (2...40) {
        dp.append((dp[i - 2].0 + dp[i - 1].0, dp[i - 2].1 + dp[i - 1].1))
    }
    
    for tc in testCase {
        print("\(dp[tc].0) \(dp[tc].1)")
    }
}
