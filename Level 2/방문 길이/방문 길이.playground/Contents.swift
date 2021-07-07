/**
 난이도: Level 2 - Summer/Winter Coding(~2018)
 
 [문제 설명]
 게임 캐릭터를 4가지 명령어를 통해 움직이려 합니다. 명령어는 다음과 같습니다.

 U: 위쪽으로 한 칸 가기
 D: 아래쪽으로 한 칸 가기
 R: 오른쪽으로 한 칸 가기
 L: 왼쪽으로 한 칸 가기

 캐릭터는 좌표평면의 (0, 0) 위치에서 시작합니다. 좌표평면의 경계는 왼쪽 위(-5, 5), 왼쪽 아래(-5, -5), 오른쪽 위(5, 5), 오른쪽 아래(5, -5)로 이루어져 있습니다.
 #[방문길이1_qpp9l3.png]

 예를 들어, "ULURRDLLU"로 명령했다면
 #[방문길이2_lezmdo.png]

 1번 명령어부터 7번 명령어까지 다음과 같이 움직입니다.
 #[방문길이3_sootjd.png]

 8번 명령어부터 9번 명령어까지 다음과 같이 움직입니다.
 #[방문길이4_hlpiej.png]

 이때, 우리는 게임 캐릭터가 지나간 길 중 캐릭터가 처음 걸어본 길의 길이를 구하려고 합니다. 예를 들어 위의 예시에서 게임 캐릭터가 움직인 길이는 9이지만, 캐릭터가 처음 걸어본 길의 길이는 7이 됩니다. (8, 9번 명령어에서 움직인 길은 2, 3번 명령어에서 이미 거쳐 간 길입니다)

 단, 좌표평면의 경계를 넘어가는 명령어는 무시합니다.

 예를 들어, "LULLLLLLU"로 명령했다면
 #[방문길이5_nitjwj.png]

 1번 명령어부터 6번 명령어대로 움직인 후, 7, 8번 명령어는 무시합니다. 다시 9번 명령어대로 움직입니다.
 #[방문길이6_nzhumd.png]

 이때 캐릭터가 처음 걸어본 길의 길이는 7이 됩니다.

 명령어가 매개변수 dirs로 주어질 때, 게임 캐릭터가 처음 걸어본 길의 길이를 구하여 return 하는 solution 함수를 완성해 주세요.

 [제한사항]
 dirs는 string형으로 주어지며, 'U', 'D', 'R', 'L' 이외에 문자는 주어지지 않습니다.
 dirs의 길이는 500 이하의 자연수입니다.
 
 [입출력 예]
 dirs                       answer
 "ULURRDLLU"     7
 "LULLLLLLU"       7
 */


import Foundation

func solution(_ dirs:String) -> Int {
    var loads:[String] = [] // 걸어온 길
    var location:[Int] = [0,0] // 좌표 (X,Y)
    
    for str in dirs {
        let subLocation:[Int] = location // 출발점을 기록하는 좌표
        var distance = "" // 이동거리 (큰 좌표에서 작은좌표를 이은 선)
        
        if str == "U" && location[1] < 5 { // Up -> Y좌표가 5를 넘지 않는다.
            location[1] += 1 // Y좌표 1 증가
            distance = (location + subLocation).description // 좌표가 좌상단에서 우하단으로 이동한것으로 통일시킨다.
            
        } else if str == "L" && location[0] > -5 { // Left -> X가 -5 밑으로 내려가지 않는다.
            location[0] -= 1 // X좌표 1 감소
            distance = (location + subLocation).description // 좌표가 좌상단에서 우하단으로 이동한것으로 통일시킨다.
            
        } else if str == "R" && location[0] < 5 { // Right -> X가 5를 넘지 않는다.
            location[0] += 1 // X좌표 1 증가
            distance = (subLocation + location).description // 좌표가 좌상단에서 우하단으로 이동한것으로 통일시킨다.
            
        } else if str == "D" && location[1] > -5 { // Down -> Y가 -5 밑으로 내려가지 않는다.
            location[1] -= 1 // Y좌표 1 감소
            distance = (subLocation + location).description // 좌표가 좌상단에서 우하단으로 이동한것으로 통일시킨다.
        }
        
        // 좌표범위 내에서 이동한 경우만 기록한다.
        if !distance.isEmpty {
            loads.append(distance) // 이동한 좌표들을 기록한다.
        }
    }
    
//    loads.forEach { print($0)} // 지나온 행적 콘솔 로그로 확인하기
    
    // 중복값 제거
    return Set(loads).count
}

print(solution("ULURRDLLU")) // 7
print(solution("LULLLLLLU")) // 7
print(solution("LRLRLRLRLR")) // 1
print(solution("UDUDUDUDUD")) // 1
