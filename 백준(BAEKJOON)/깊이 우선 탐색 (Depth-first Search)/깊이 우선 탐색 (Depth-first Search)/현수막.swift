//
//  현수막.swift
//  깊이 우선 탐색 (Depth-first Search)
//
//  Created by 최지수 on 2021/12/20.
//

/**
 [문제]
 ANT가 처음 알고리즘 대회를 개최하게 되면서 현수막을 내걸었다.

 저번 학기 영상처리 수업을 듣고 배웠던 지식을 최대한 응용 해보고 싶은 혁진이는 이 현수막에서 글자가 몇 개인지 알아보는 프로그램을 만들려 한다.

 혁진이는 우선 현수막에서 글자인 부분은 1, 글자가 아닌 부분은 0으로 바꾸는 필터를 적용하여 값을 만드는데 성공했다.

 그런데 혁진이는 이 값을 바탕으로 글자인 부분 1이 상, 하, 좌, 우, 대각선으로 인접하여 서로 연결되어 있다면 한 개의 글자라고 생각만 하였다.

 혁진이가 필터를 적용하여 만든 값이 입력으로 주어졌을 때, 혁진이의 생각대로 프로그램을 구현하면 글자의 개수가 몇 개인지 출력하여라.

 [입력]
 첫 번째 줄에는 현수막의 크기인 M와 N가 주어진다. (1 ≤ M, N ≤ 250)

 두 번째 줄부터 M+1 번째 줄까지 현수막의 정보가 1과 0으로 주어지며, 1과 0을 제외한 입력은 주어지지 않는다.

 [출력]
 혁진이의 생각대로 프로그램을 구현했을 때, 현수막에서 글자의 개수가 몇 개인지 출력하여라.

[예제 입력 1]
8 19
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
0 0 0 1 0 0 0 1 0 0 0 1 0 1 1 1 1 1 0
0 0 1 0 1 0 0 1 1 0 0 1 0 0 0 1 0 0 0
0 1 0 0 0 1 0 1 0 1 0 1 0 0 0 1 0 0 0
0 1 1 1 1 1 0 1 0 1 0 1 0 0 0 1 0 0 0
0 1 0 0 0 1 0 1 0 0 1 1 0 0 0 1 0 0 0
0 1 0 0 0 1 0 1 0 0 0 1 0 0 0 1 0 0 0
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
[예제 출력 1]
3
 */
import Foundation

/// 현수막 [14716번]
func 현수막() {
    let size = readLine()!.split(separator: " ").compactMap { Int($0) }
    let directions = [(-1, -1), (0, -1), (1, -1),
                      (-1, 0), (1, 0),
                      (-1, 1), (0, 1), (1, 1)] // 상, 하, 좌, 우, 대각선들
    
    var banner = (0..<size[0]).map { _ in
        return readLine()!.split(separator: " ").compactMap { Int($0) }
    }
    
    var word = Set<String>() // 각 글자의 시작점들을 저장한다.
    
    func dfs(_ x: Int, y: Int, tag: String) {
        if 0 > x || x >= size[0] || 0 > y || y >= size[1] || banner[x][y] == 0 { return }
        banner[x][y] = 0
        word.insert(tag)
        
        for direction in directions {
            let nx = x + direction.0
            let ny = y + direction.1
            
            dfs(nx, y: ny, tag: tag)
        }
    }
    
    for i in 0..<banner.count {
        for j in 0..<banner[i].count {
            dfs(i, y: j, tag: "\(i), \(j)")
        }
    }

    print(word.count)
}
