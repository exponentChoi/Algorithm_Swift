/**
 난이도: Level 1 - 2018 KAKAO BLIND RECRUITMENT
 [문제 설명]
 비밀지도
 네오는 평소 프로도가 비상금을 숨겨놓는 장소를 알려줄 비밀지도를 손에 넣었다. 그런데 이 비밀지도는 숫자로 암호화되어 있어 위치를 확인하기 위해서는 암호를 해독해야 한다. 다행히 지도 암호를 해독할 방법을 적어놓은 메모도 함께 발견했다.

 지도는 한 변의 길이가 n인 정사각형 배열 형태로, 각 칸은 "공백"(" ") 또는 "벽"("#") 두 종류로 이루어져 있다.
 전체 지도는 두 장의 지도를 겹쳐서 얻을 수 있다. 각각 "지도 1"과 "지도 2"라고 하자. 지도 1 또는 지도 2 중 어느 하나라도 벽인 부분은 전체 지도에서도 벽이다. 지도 1과 지도 2에서 모두 공백인 부분은 전체 지도에서도 공백이다.
 "지도 1"과 "지도 2"는 각각 정수 배열로 암호화되어 있다.
 암호화된 배열은 지도의 각 가로줄에서 벽 부분을 1, 공백 부분을 0으로 부호화했을 때 얻어지는 이진수에 해당하는 값의 배열이다.

 네오가 프로도의 비상금을 손에 넣을 수 있도록, 비밀지도의 암호를 해독하는 작업을 도와줄 프로그램을 작성하라.
 
 [입력 형식]
 입력으로 지도의 한 변 크기 n 과 2개의 정수 배열 arr1, arr2가 들어온다.

 1 ≦ n ≦ 16
 arr1, arr2는 길이 n인 정수 배열로 주어진다.
 정수 배열의 각 원소 x를 이진수로 변환했을 때의 길이는 n 이하이다. 즉, 0 ≦ x ≦ 2n - 1을 만족한다.
 출력 형식
 원래의 비밀지도를 해독하여 '#', 공백으로 구성된 문자열 배열로 출력하라.

 [입출력 예제]
 매개변수       값
 n                  5
 arr1             [9, 20, 28, 18, 11]
 arr2             [30, 1, 21, 17, 28]
 출력             ["#####","# # #", "### #", "# ##", "#####"]
 */

func solution(_ n:Int, _ arr1:[Int], _ arr2:[Int]) -> [String] {
    var answer: [String] = []
    
    let binaries1 = arr1.compactMap { Int(String($0, radix: 2)) }.map { digit($0, n: n) } // 2진법으로 치환
    let binaries2 = arr2.compactMap { Int(String($0, radix: 2)) }.map { digit($0, n: n) } // 2진법으로 치환

    for i in 0..<n { // n수 만큼 반복
        answer.append(combine(binaries1[i], binaries2[i]))
    }
    
    return answer
}

// 2진수 n자리 맞추기 (ex: n이 5인 경우: 200 -> 00200)
func digit(_ binary: Int, n: Int) -> String {
    let binaryStr = String(binary)
    guard binaryStr.count != n else { return binaryStr }
    var result = binaryStr
    
    while result.count != n {
        result = "0" + result
    }
    
    return result
}

// 이진수 합치기
func combine(_ arr1: String, _ arr2: String) -> String {
    var answer = ""

    arr1.enumerated().forEach { ar1Index, ar1Str in
        arr2.enumerated().forEach { ar2Index, ar2Str in
            if ar1Index == ar2Index { // arr1의 index와 arr2의 index가 같은 경우에만 실행
                if (ar1Str == "1" || ar2Str == "1") {
                    answer += "#" // "1"이 포함되면 벽
                } else {
                    answer += " "
                }
            }
        }
    }

    return answer
}

print(solution(5,
               [9, 20, 28, 18, 11],
               [30, 1, 21, 17, 28]))


// 101 - 5
// 010 - 2
// 111 - 5 OR 2
// 100111 - (5 OR 2) OR (2를 좌측 쉬프트 4만큼)
print(String((5|2)|2<<4, radix: 2))


// MARK: - 다른풀이 분석
func solution2(_ n:Int, _ arr1:[Int], _ arr2:[Int]) -> [String] {
    /**
     1. arr1과 arr2를 OR 비교하여 2진법으로 변환
     2. arr1, arr2, 2를 OR 하는 이유는 자릿수가 부족한 경우를 위해서다. 예를들어 00111인 경우 111만 남기 때문에 100111을 만든다.
     3. 위에서 뽑은 string을 "1"인지 비교하여 "#" 또는 " "으로 치환한다.
     4. 좌측으로 쉬프트하여 총 n+1자리수가 되었으니 1번째부터 비교하여 쌓는다.
     (ex: 5 | 2 = 00111 이다. 그럼 Int인 경우 앞자리 00은 사라지게 된다. 그래서 2(00010)를 해당 자리수만큼 좌측쉬프트 한 후 100111을 만들고, 치환할 때는 인덱스 1부터 비교한다.
     */
    return (0..<n).map { String( // 2를 n-1만큼 왼쪽으로 이동시키는 이유는
        String(arr1[$0]|arr2[$0]|2<<(n - 1), radix: 2) // 2를 n-1만큼 왼쪽으로 이동시키는 이유는 첫자리가 0인경우를 대비하기 위함... 예를들어 00111인 경우 111만 남기 때문에 100111을 만든다.
            .map { $0 == "1" ? "#" : " "}[1...n]
    )}
}

print(solution2(5,
               [9, 20, 28, 18, 11],
               [30, 1, 21, 17, 28]))
