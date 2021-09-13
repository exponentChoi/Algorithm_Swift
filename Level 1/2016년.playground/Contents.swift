/**
 난이도: Level 1
 
 [문제 설명]
 2016년 1월 1일은 금요일입니다. 2016년 a월 b일은 무슨 요일일까요? 두 수 a ,b를 입력받아 2016년 a월 b일이 무슨 요일인지 리턴하는 함수, solution을 완성하세요. 요일의 이름은 일요일부터 토요일까지 각각 SUN,MON,TUE,WED,THU,FRI,SAT

 입니다. 예를 들어 a=5, b=24라면 5월 24일은 화요일이므로 문자열 "TUE"를 반환하세요.

 {제한 조건}
 2016년은 윤년입니다.
 2016년 a월 b일은 실제로 있는 날입니다. (13월 26일이나 2월 45일같은 날짜는 주어지지 않습니다)
 
 [입출력 예]
 a    b      result
 5    24    "TUE"
 */

import Foundation

func solution(_ a:Int, _ b:Int) -> String {
    let weekday = ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"]
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    
    guard let date = dateFormatter.date(from: "2016-\(a)-\(b)") else { return "" }
    let day = Calendar.current.component(.weekday, from: date)
    
    // 또는 dateFormatter의 "EE"를 이용하여 요일 추출하기
    
    return weekday[day - 1]
}

print(solution(5, 24))


// Date 에서 년,월,일,요일 정보 가져오기
let today = Date()
let year = Calendar.current.component(.year, from: today)
let month = Calendar.current.component(.month, from: today)
let day = Calendar.current.component(.day, from: today)
let weekday = Calendar.current.component(.weekday, from: today)
let weekOfMonth = Calendar.current.component(.weekOfMonth, from: today)
let weekOfYear = Calendar.current.component(.weekOfYear, from: today)

print(year, month, day, weekday, weekOfMonth, weekOfYear)


// MARK: - TODO 다른사람 풀이... 분석해볼 것
func solution2(_ a:Int, _ b:Int) -> String {

    let w = ["THU", "FRI", "SAT", "SUN", "MON", "TUE", "WED"] // 2016년 1월 1일 (금요일) -> THU가 0 index인 이유
    let monthDay = [ 31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31] // 각 월의 일수 만큼
    let totalDay = monthDay[0..<a-1].reduce(0, +) + b // 4월까지의 일수를 더하고 5월에 일수를 더해서 1월 1일부터의 일수를 더한다.

    print("monthDay: \(monthDay[0..<a-1])")
    return w[totalDay % 7] // 총합한 일수를 7로 나눈 나머지 값으로 w Array의 값을 뽑는다.
}

solution2(5, 24)
