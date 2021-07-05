/**
 난이도: Level 2 - 2018 KAKAO BLIND RECRUITMENT
 
 [캐시]
 지도개발팀에서 근무하는 제이지는 지도에서 도시 이름을 검색하면 해당 도시와 관련된 맛집 게시물들을 데이터베이스에서 읽어 보여주는 서비스를 개발하고 있다.
 이 프로그램의 테스팅 업무를 담당하고 있는 어피치는 서비스를 오픈하기 전 각 로직에 대한 성능 측정을 수행하였는데, 제이지가 작성한 부분 중 데이터베이스에서 게시물을 가져오는 부분의 실행시간이 너무 오래 걸린다는 것을 알게 되었다.
 어피치는 제이지에게 해당 로직을 개선하라고 닦달하기 시작하였고, 제이지는 DB 캐시를 적용하여 성능 개선을 시도하고 있지만 캐시 크기를 얼마로 해야 효율적인지 몰라 난감한 상황이다.

 어피치에게 시달리는 제이지를 도와, DB 캐시를 적용할 때 캐시 크기에 따른 실행시간 측정 프로그램을 작성하시오.

 [입력 형식]
 캐시 크기(cacheSize)와 도시이름 배열(cities)을 입력받는다.
 cacheSize는 정수이며, 범위는 0 ≦ cacheSize ≦ 30 이다.
 cities는 도시 이름으로 이뤄진 문자열 배열로, 최대 도시 수는 100,000개이다.
 각 도시 이름은 공백, 숫자, 특수문자 등이 없는 영문자로 구성되며, 대소문자 구분을 하지 않는다. 도시 이름은 최대 20자로 이루어져 있다.
 
 [출력 형식]
 입력된 도시이름 배열을 순서대로 처리할 때, "총 실행시간"을 출력한다.
 
 [조건]
 캐시 교체 알고리즘은 LRU(Least Recently Used)를 사용한다.
 cache hit일 경우 실행시간은 1이다.
 cache miss일 경우 실행시간은 5이다.
 
 [입출력 예제]
 캐시크기(cacheSize)    도시이름(cities)    실행시간
 3    ["Jeju", "Pangyo", "Seoul", "NewYork", "LA", "Jeju", "Pangyo", "Seoul", "NewYork", "LA"]    50
 3    ["Jeju", "Pangyo", "Seoul", "Jeju", "Pangyo", "Seoul", "Jeju", "Pangyo", "Seoul"]    21
 2    ["Jeju", "Pangyo", "Seoul", "NewYork", "LA", "SanFrancisco", "Seoul", "Rome", "Paris", "Jeju", "NewYork", "Rome"]    60
 5    ["Jeju", "Pangyo", "Seoul", "NewYork", "LA", "SanFrancisco", "Seoul", "Rome", "Paris", "Jeju", "NewYork", "Rome"]    52
 2    ["Jeju", "Pangyo", "NewYork", "newyork"]    16
 0    ["Jeju", "Pangyo", "Seoul", "NewYork", "LA"]    25
 */

// - LRU
// 참조 횟수가 가장 적은 페이지를 교체하는 알고리즘이다.
// 만약 교체 대상이 여러 페이지일 경우 가장 오래 사용하지 않은 페이지로 교체한다.

struct Cache {
    var seq: Int // 캐시가 만들어진 시점
    let city: String // 소문자로 변환된 city
    var count: Int // 캐시 사용된 횟수
    
    init(seq: Int, city: String, count: Int) {
        self.seq = seq
        self.city = city.lowercased() // 소문자로 변환
        self.count = count
    }
}

func solution(_ cacheSize:Int, _ cities:[String]) -> Int {
    guard cacheSize > 0 else { return cities.count * 5 } // cache가 1보다 작은경우 모든 실행시간이 5씩 걸린다.

    var runTime = 0 // 실행시간을 담는 변수
    var caches:[Cache] = [] // 캐시를 담는 변수
    
    for i in 0..<cities.count { // city 개수만큼 반복
        let city = cities[i].lowercased() // 모든 city는 소문자로 변환한다.
        
        // 캐시에 해당 도시가 있는지 판단한다.
        if caches.contains(where: { $0.city == city }) { // 캐시에 해당 도시가 있는 경우 !!
            runTime += 1
            
            for cacheIndex in 0..<caches.count {
                if caches[cacheIndex].city == city { // 해당 캐시를 찾아 사용횟수를 1 추가한다.
//                    caches[cacheIndex].count += 1 // 캐시 사용횟수를 추가한다. (사용 횟수는 사용되지 않았다..)
                    caches[cacheIndex].seq = i // 캐시의 seq를 최신으로 변경한다.
                    break
                }
            }
        } else { // 캐시에 해당 도시가 없는 경우
            runTime += 5
            
            if caches.count < cacheSize { // 캐시가 개수를 채우지 못한 경우
                caches.append(.init(seq: i, city: city, count: 1)) // 캐시에 새로운 캐시를 담는다.
                
            } else { // 캐시가 가득 채워진 경우
                // count... (사용 횟수는 사용되지 않았다..)
//                caches.sort(by: { $0.count < $1.count || $0.seq < $1.seq }) // 사용 횟수가 적고, 가장 오래된 캐시를 제거하기 위함.
                caches.sort(by: { $0.seq < $1.seq }) // 사용 횟수가 적고, 가장 오래된 캐시를 제거하기 위함.
                caches.removeFirst()
                caches.append(.init(seq: i, city: city, count: 1)) // 새로운 캐시를 저장한다.
            }
        }
    }
    
    return runTime
}

print(solution(3, ["Jeju", "Pangyo", "Seoul", "NewYork", "LA", "Jeju", "Pangyo", "Seoul", "NewYork", "LA"])) // 50
print(solution(3, ["Jeju", "Pangyo", "Seoul", "Jeju", "Pangyo", "Seoul", "Jeju", "Pangyo", "Seoul"])) // 21
print(solution(2, ["Jeju", "Pangyo", "Seoul", "NewYork", "LA", "SanFrancisco", "Seoul", "Rome", "Paris", "Jeju", "NewYork", "Rome"])) // 60
print(solution(5, ["Jeju", "Pangyo", "Seoul", "NewYork", "LA", "SanFrancisco", "Seoul", "Rome", "Paris", "Jeju", "NewYork", "Rome"])) // 52
print(solution(2, ["Jeju", "Pangyo", "NewYork", "newyork"])) // 16
print(solution(0, ["Jeju", "Pangyo", "Seoul", "NewYork", "LA"])) // 25
print(solution(5, ["SEOUL", "SEOUL", "SEOUL"])) // 7
