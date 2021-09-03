/**
 난이도: Level 2 - 2018 KAKAO BLIND RECRUITMENT
 
 [문제 설명]
 라디오를 자주 듣는 네오는 라디오에서 방금 나왔던 음악이 무슨 음악인지 궁금해질 때가 많다. 그럴 때 네오는 다음 포털의 '방금그곡' 서비스를 이용하곤 한다. 방금그곡에서는 TV, 라디오 등에서 나온 음악에 관해 제목 등의 정보를 제공하는 서비스이다.

 네오는 자신이 기억한 멜로디를 가지고 방금그곡을 이용해 음악을 찾는다. 그런데 라디오 방송에서는 한 음악을 반복해서 재생할 때도 있어서 네오가 기억하고 있는 멜로디는 음악 끝부분과 처음 부분이 이어서 재생된 멜로디일 수도 있다. 반대로, 한 음악을 중간에 끊을 경우 원본 음악에는 네오가 기억한 멜로디가 들어있다 해도 그 곡이 네오가 들은 곡이 아닐 수도 있다. 그렇기 때문에 네오는 기억한 멜로디를 재생 시간과 제공된 악보를 직접 보면서 비교하려고 한다. 다음과 같은 가정을 할 때 네오가 찾으려는 음악의 제목을 구하여라.

 방금그곡 서비스에서는 음악 제목, 재생이 시작되고 끝난 시각, 악보를 제공한다.
 네오가 기억한 멜로디와 악보에 사용되는 음은 C, C#, D, D#, E, F, F#, G, G#, A, A#, B 12개이다.
 각 음은 1분에 1개씩 재생된다. 음악은 반드시 처음부터 재생되며 음악 길이보다 재생된 시간이 길 때는 음악이 끊김 없이 처음부터 반복해서 재생된다. 음악 길이보다 재생된 시간이 짧을 때는 처음부터 재생 시간만큼만 재생된다.
 음악이 00:00를 넘겨서까지 재생되는 일은 없다.
 조건이 일치하는 음악이 여러 개일 때에는 라디오에서 재생된 시간이 제일 긴 음악 제목을 반환한다. 재생된 시간도 같을 경우 먼저 입력된 음악 제목을 반환한다.
 조건이 일치하는 음악이 없을 때에는 “(None)”을 반환한다.
 입력 형식
 입력으로 네오가 기억한 멜로디를 담은 문자열 m과 방송된 곡의 정보를 담고 있는 배열 musicinfos가 주어진다.

 m은 음 1개 이상 1439개 이하로 구성되어 있다.
 musicinfos는 100개 이하의 곡 정보를 담고 있는 배열로, 각각의 곡 정보는 음악이 시작한 시각, 끝난 시각, 음악 제목, 악보 정보가 ','로 구분된 문자열이다.
 음악의 시작 시각과 끝난 시각은 24시간 HH:MM 형식이다.
 음악 제목은 ',' 이외의 출력 가능한 문자로 표현된 길이 1 이상 64 이하의 문자열이다.
 악보 정보는 음 1개 이상 1439개 이하로 구성되어 있다.
 출력 형식
 조건과 일치하는 음악 제목을 출력한다.

 [입출력 예시]
 m                       musicinfos                                                         answer
 "ABCDEFG"    ["12:00,12:14,HELLO,CDEFGAB", "13:00,13:05,WORLD,ABCDEF"]    "HELLO"
 
 "CC#BCC#BCC#BCC#B"    ["03:00,03:30,FOO,CC#B", "04:00,04:08,BAR,CC#BCC#BCC#B"]
 "FOO"

 "ABC"    ["12:00,12:14,HELLO,C#DEFGAB", "13:00,13:05,WORLD,ABCDEF"]
 "WORLD"
 
 [설명]
 첫 번째 예시에서 HELLO는 길이가 7분이지만 12:00부터 12:14까지 재생되었으므로 실제로 CDEFGABCDEFGAB로 재생되었고, 이 중에 기억한 멜로디인 ABCDEFG가 들어있다.
 세 번째 예시에서 HELLO는 C#DEFGABC#DEFGAB로, WORLD는 ABCDE로 재생되었다. HELLO 안에 있는 ABC#은 기억한 멜로디인 ABC와 일치하지 않고, WORLD 안에 있는 ABC가 기억한 멜로디와 일치한다.
 */
import Foundation

func solution(_ m:String, _ musicinfos:[String]) -> String {
    var answer = "(None)"
    
    // 기억하고 있는 멜로디 저장
    let remember = m.reduce(into: [String](), { result, element in
        let str = String(element)
        str == "#" ? result[result.count - 1] += "#" : result.append(str)
    })
    
    loop:for musicinfo in musicinfos {
        let info = musicinfo.components(separatedBy: ",") // 정보 분리
        var runTime = runTimes(info[0], info[1]) // 음악 재생시간 구하기
        
        let separatedCode = info[3].map { String($0) } // 주어진 코드를 하나씩 분리한다.
        var code = [String]() // 코드를 정리하여 담는다.
        var index = 0
        
        while code.count < runTime { // 정리한 악보
            let value = separatedCode[index % separatedCode.count] // 분리된 악보를 순서대로 검색한다.
            if value == "#" {
                code[code.count - 1] += "#"
            } else {
                code.append(value)
            }
            
            index += 1
        }
        
        var rIndex = 0 // remember에 참조하기 위한 index
        for i in 0..<code.count { // code와 하나씩 일치하는지 비교한다.
            if remember.count <= rIndex { // rIndex가 기억하고 있는것과 일치한 경우 반복분을 종료한다.
                answer = info[2]
                break loop
            }
            
            if remember[rIndex] == code[i] { // 값이 같은 경우
                rIndex += 1
            } else {
                rIndex = 0
            }
        }
    }
    
    return answer
}

/// 시간차이 구하기 format: "HH:mm"
func runTimes(_ start: String, _ end: String) -> Int {
    let s = start.components(separatedBy: ":").compactMap { Int($0) }
    let e = end.components(separatedBy: ":").compactMap { Int($0) }
    
    return abs((e[0] * 60) + e[1]) - ((s[0] * 60) + s[1])
    
    // 프로그래머스에서 DateFormatter() 사용이 안된다..
//    let dateFormatter = DateFormatter()
//    dateFormatter.dateFormat = "HH:mm"
//
//    guard let a = dateFormatter.date(from: start),
//          let b = dateFormatter.date(from: end) else {
//        return 0
//    }
//
//    return Int(b.timeIntervalSince(a) / 60)
}



print(solution("ABCDEFG", ["12:00,12:14,HELLO,CDEFGAB", "13:00,13:05,WORLD,ABCDEF"])) // "HELLO"
print(solution("CC#BCC#BCC#BCC#B", ["04:00,04:08,BAR,CC#BCC#BCC#B", "03:00,03:30,FOO,CC#B", "04:00,04:08,BAR,CC#BCC#BCC#B"])) // "FOO"
print(solution("ABC", ["12:00,12:14,HELLO,C#DEFGAB", "13:00,13:05,WORLD,ABCDEF"])) // "WORLD"
print(solution("AAAA#", ["12:00,12:14,HELLO,AAA#A#A"]))
