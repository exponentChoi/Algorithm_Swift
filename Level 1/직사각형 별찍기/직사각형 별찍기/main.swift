//
//  main.swift
//  직사각형 별찍기
//
//  Created by 최지수 on 2021/08/31.
//


/**
 난이도: Level 1
 [문제 설명]
 이 문제에는 표준 입력으로 두 개의 정수 n과 m이 주어집니다.
 별(*) 문자를 이용해 가로의 길이가 n, 세로의 길이가 m인 직사각형 형태를 출력해보세요.

 [제한 조건]
 n과 m은 각각 1000 이하인 자연수입니다.
 [예시]
 입력 => 5 3

 [출력]
  *****
  *****
  *****
 */
import Foundation

let n = readLine()!.components(separatedBy: [" "]).compactMap { Int($0) }

(0..<n[1]).forEach { _ in
    print(Array(repeating: "*", count: n[0]).joined())
}
