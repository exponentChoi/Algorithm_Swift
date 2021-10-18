//
//  동전 2.swift
//  Dynamic Programming
//
//  Created by 최지수 on 2021/10/18.
//

/**
 [문제]
 n가지 종류의 동전이 있다. 이 동전들을 적당히 사용해서, 그 가치의 합이 k원이 되도록 하고 싶다. 그러면서 동전의 개수가 최소가 되도록 하려고 한다. 각각의 동전은 몇 개라도 사용할 수 있다.

 사용한 동전의 구성이 같은데, 순서만 다른 것은 같은 경우이다.

 [입력]
 첫째 줄에 n, k가 주어진다. (1 ≤ n ≤ 100, 1 ≤ k ≤ 10,000) 다음 n개의 줄에는 각각의 동전의 가치가 주어진다. 동전의 가치는 100,000보다 작거나 같은 자연수이다. 가치가 같은 동전이 여러 번 주어질 수도 있다.

 [출력]
 첫째 줄에 사용한 동전의 최소 개수를 출력한다. 불가능한 경우에는 -1을 출력한다.

 [예제 입력 1]
 3 15
 1
 5
 12
 [예제 출력 1]
 3
 */

import Foundation

/// 동전 2 [2294번]
func 동전2() {
    let input = readLine()!.split(separator: " ").compactMap { Int($0) }
    let coins = (0..<input[0]).compactMap { _ in Int(readLine()!) }
    let k = input[1]
    
    var dp = Array(repeating: Int.max, count: k + 1)
    dp[0] = 0
    
    for coin in coins {
        if coin > k { // K보다 큰경우 pass
            continue
        }
        
        for i in coin...k { // coin부터 시작하는 이유는? => coin으로 만들 수 있는 값을 찾아야 하기 때문
            // dp[i - coin] => 해당 coin으로 만들 수 있는 방법
            // dp[i - coin]이 조합이 가능한지 파악해야한다.
            // dp[i - coin]의 최초값은 dp[0]이다. dp[i - coin]은 coin의 배수를 확인하거나, 이전에 사용된 값으로 만들 수 있는지 파악이 가능하다.
            
            if dp[i - coin] < Int.max && dp[i] > (dp[i - coin] + 1) {
                dp[i] = dp[i - coin] + 1 // dp[i]보다 작은 경우에만 경우를 추가하여 저장한다.
            }
        }
    }
    
    print(dp[k] == Int.max ? -1 : dp[k]) // dp[k]를 구성하는것이 불가능하다면 -1을 반환
}
