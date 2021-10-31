//
//  가장 긴 감소하는 부분 수열.swift
//  Dynamic Programming
//
//  Created by 최지수 on 2021/10/31.
//

/**
 [문제]
 수열 A가 주어졌을 때, 가장 긴 감소하는 부분 수열을 구하는 프로그램을 작성하시오.

 예를 들어, 수열 A = {10, 30, 10, 20, 20, 10} 인 경우에 가장 긴 감소하는 부분 수열은 A = {30, 20, 10}  이고, 길이는 3이다.

 [입력]
 첫째 줄에 수열 A의 크기 N (1 ≤ N ≤ 1,000)이 주어진다.

 둘째 줄에는 수열 A를 이루고 있는 Ai가 주어진다. (1 ≤ Ai ≤ 1,000)

 [출력]
 첫째 줄에 수열 A의 가장 긴 감소하는 부분 수열의 길이를 출력한다.

 [예제 입력 1]
 6
 10 30 10 20 20 10
 [예제 출력 1]
 3
 */
import Foundation

/// 가장 긴 감소하는 부분 수열 [11722번]
func 가장_긴_감소하는_부분_수열() {
    let n = Int(readLine()!)!
    var dp = Array(repeating: 1, count: n) // 최소 한개로 시작한다.
    let sequence = readLine()!.split(separator: " ").compactMap { Int($0) }
    
    for i in 1..<n { // 수열 길이만큼 반복한다.
        for j in 0..<i { // i이전 수들 중 i보다 큰 수를 찾기 위함
            if sequence[i] < sequence[j] { // sequence[0...j]중 sequence[i]보다 개수가 적으면 교체
                dp[i] = max(dp[i], dp[j] + 1) // dp[i]는 최소 1이고 (0..<i)반복문을 돌면서 높은 수로 변경된다. (dp[j] + 1)은 (이전 개수 + 현재 개수)
            }
        }
    }
    
    print(dp.max()!) // 저장한 길이 중 가장 큰 길이를 출력
}


