/**
 Level 3 - 해시
 
 [문제 설명]
 스트리밍 사이트에서 장르 별로 가장 많이 재생된 노래를 두 개씩 모아 베스트 앨범을 출시하려 합니다. 노래는 고유 번호로 구분하며, 노래를 수록하는 기준은 다음과 같습니다.

 속한 노래가 많이 재생된 장르를 먼저 수록합니다.
 장르 내에서 많이 재생된 노래를 먼저 수록합니다.
 장르 내에서 재생 횟수가 같은 노래 중에서는 고유 번호가 낮은 노래를 먼저 수록합니다.
 노래의 장르를 나타내는 문자열 배열 genres와 노래별 재생 횟수를 나타내는 정수 배열 plays가 주어질 때, 베스트 앨범에 들어갈 노래의 고유 번호를 순서대로 return 하도록 solution 함수를 완성하세요.

 [제한사항]
 genres[i]는 고유번호가 i인 노래의 장르입니다.
 plays[i]는 고유번호가 i인 노래가 재생된 횟수입니다.
 genres와 plays의 길이는 같으며, 이는 1 이상 10,000 이하입니다.
 장르 종류는 100개 미만입니다.
 장르에 속한 곡이 하나라면, 하나의 곡만 선택합니다.
 모든 장르는 재생된 횟수가 다릅니다.
 
 [입출력 예]
 genres                                                                 plays                                       return
 ["classic", "pop", "classic", "classic", "pop"]    [500, 600, 150, 800, 2500]    [4, 1, 3, 0]
 
 [입출력 예 설명]
 classic 장르는 1,450회 재생되었으며, classic 노래는 다음과 같습니다.

 고유 번호 3: 800회 재생
 고유 번호 0: 500회 재생
 고유 번호 2: 150회 재생
 pop 장르는 3,100회 재생되었으며, pop 노래는 다음과 같습니다.

 고유 번호 4: 2,500회 재생
 고유 번호 1: 600회 재생
 따라서 pop 장르의 [4, 1]번 노래를 먼저, classic 장르의 [3, 0]번 노래를 그다음에 수록합니다.
 */

/**
 [나의 생각]
 문제를 꼼꼼하게 읽어봐야 한다.
 문제 설명에서 첫줄을 읽지 않았다면 노래를 두 개씩 모으는 것을 놓칠 수 있다.
 */

import Foundation

func solution(_ genres:[String], _ plays:[Int]) -> [Int] {
    typealias indexPlays = (Int, Int) // Index, Plays
    
    var genreRank = [String: Int]() // 장르별 재생된 횟수를 저장
    var musics = [String: [indexPlays]]() // 장르별 index와 재생 횟수를 저장한다.
    var answer = [Int]()
    
    // musics, genreRank에 데이터 삽입
    for i in genres.indices {
        if musics[genres[i]] == nil { // musics에 해당 genre가 비어있는 경우
            musics[genres[i]] = [(i, plays[i])]
        } else {
            musics[genres[i]]?.append((i, plays[i]))
        }
        
        genreRank[genres[i], default: 0] += plays[i] // genre별 재생횟수를 추가한다.
    }
    
    // 가장 많이 재생된 횟수로 sort 하고 그 중에서 많이 재생된 index를 반환한다.
    genreRank.sorted(by: { $0.value > $1.value })
        .forEach { element in
            let sort = musics[element.key]!.sorted(by: { $0.1 > $1.1 }) // 가장 많이 재생된 횟수로 정렬한다.
            for i in sort.indices {
                if i > 1 { break } // 2곡이 초과되었다면 break
                answer.append(sort[i].0)
            }
        }
    
    return answer
}

print(solution(["classic", "pop", "classic", "classic", "pop"], [500, 600, 150, 800, 2500])) // [4, 1, 3, 0]
