//
//  피보나치 수 2.swift
//  Dynamic Programming
//
//  Created by 최지수 on 2021/09/20.
//

/**
 [문제]
 피보나치 수는 0과 1로 시작한다. 0번째 피보나치 수는 0이고, 1번째 피보나치 수는 1이다. 그 다음 2번째 부터는 바로 앞 두 피보나치 수의 합이 된다.

 이를 식으로 써보면 Fn = Fn-1 + Fn-2 (n ≥ 2)가 된다.

 n=17일때 까지 피보나치 수를 써보면 다음과 같다.

 0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 610, 987, 1597

 n이 주어졌을 때, n번째 피보나치 수를 구하는 프로그램을 작성하시오.

 [입력]
 첫째 줄에 n이 주어진다. n은 90보다 작거나 같은 자연수이다.

 [출력]
 첫째 줄에 n번째 피보나치 수를 출력한다.

 [예제 입력 1]
 10
 [예제 출력 1]
 55
 */

/**
 피보나치 수열은 한줄로도 가능하다.
 n이 90일 때 2_880_067_194_370_816_120 이므로 Int에 들어간다. unsigned(UInt)로 하면 더 좋을까??
 */
import Foundation

/// 피보나치 수 2 [2748번]
func 피보나치수2() {
    let dp = (2..<(Int(readLine()!)! + 1)).reduce(into: [0, 1], { $0.append($0[$1 - 2] + $0[$1 - 1]) })
    print(dp.last!)
}

