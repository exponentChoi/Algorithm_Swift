//
//  RGB거리 2.swift
//  Dynamic Programming
//
//  Created by 최지수 on 2021/09/22.
//

/**
 [문제]
 RGB거리에는 집이 N개 있다. 거리는 선분으로 나타낼 수 있고, 1번 집부터 N번 집이 순서대로 있다.

 집은 빨강, 초록, 파랑 중 하나의 색으로 칠해야 한다. 각각의 집을 빨강, 초록, 파랑으로 칠하는 비용이 주어졌을 때, 아래 규칙을 만족하면서 모든 집을 칠하는 비용의 최솟값을 구해보자.

 1번 집의 색은 2번, N번 집의 색과 같지 않아야 한다.
 N번 집의 색은 N-1번, 1번 집의 색과 같지 않아야 한다.
 i(2 ≤ i ≤ N-1)번 집의 색은 i-1, i+1번 집의 색과 같지 않아야 한다.
 
 [입력]
 첫째 줄에 집의 수 N(2 ≤ N ≤ 1,000)이 주어진다. 둘째 줄부터 N개의 줄에는 각 집을 빨강, 초록, 파랑으로 칠하는 비용이 1번 집부터 한 줄에 하나씩 주어진다. 집을 칠하는 비용은 1,000보다 작거나 같은 자연수이다.

 [출력]
 첫째 줄에 모든 집을 칠하는 비용의 최솟값을 출력한다.

 [예제 입력 1]
 3
 26 40 83
 49 60 57
 13 89 99
 [예제 출력 1]
 110
 */
import Foundation

/// RGB거리 2
func RGB거리2() {
//        let n = 3
//        var rgb = [[26, 40, 83], [49, 60, 57], [13, 89, 99]]
    
    let n = Int(readLine()!)!
    var rgb = (0..<n).compactMap { _ in readLine()!.split(separator: " ").compactMap { Int($0) } }
    rgb.insert([0, 0, 0], at: 0)
    
    var answer = Int.max // 최솟값을 저장하기 위한 변수 (최대값으로 초기화 후 작은값이 등장하면 교체한다.)
    var dp = [[Int]]()
    
    let memories = rgb[1] // 첫 선택에서 색상을 기억하기 위함
    let max = Int.max - 1000

    // 첫 번째를 선택한 후 나머지의 경우의 수를 구한다.
    func setDP() {
        dp = Array(repeating: [0, 0, 0], count: n + 1)
        for i in 1...n {
            dp[i][0] = rgb[i][0] + min(dp[i - 1][1], dp[i - 1][2])
            dp[i][1] = rgb[i][1] + min(dp[i - 1][0], dp[i - 1][2])
            dp[i][2] = rgb[i][2] + min(dp[i - 1][0], dp[i - 1][1])
        }
    }

    rgb[1] = [memories[0], max, max] // 첫 선택이 빨강이 선택된 경우
    setDP()
    answer = min(min(dp[n][1], dp[n][2]), answer) // 최소값 저장

    rgb[1] = [max, memories[1], max] // 첫 선택이 초록이 선택된 경우
    setDP()
    answer = min(min(dp[n][0], dp[n][2]), answer) // 최소값 저장

    rgb[1] = [max, max, memories[2]] // 첫 선택이 파랑인 경우
    setDP()
    answer = min(min(dp[n][1], dp[n][0]), answer) // 최소값 저장
    
    print(answer)
}



