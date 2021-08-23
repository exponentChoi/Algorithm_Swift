# 메뉴 리뉴얼 풀이

## 풀이 과정
course의 배열 개수만큼 반복문을 돌려 orders를 조합하여 해당하는 값만 반환하도록 했다.  
orders를 조합할 때 재귀 함수를 사용하여 course만큼 조합하도록 하였다.

## Flow
1. course의 수보다 order string의 count가 작은 경우 filter 했다. (불필요한 조합을 하지 않기 위함)
2. filter 후 개수가 0인 경우 다음 course로 넘어갔다. (불필요한 로직을 실행하지 않기 위함)
3. filter 한 orders를 반복문을 돌려 문자들을 조합했다. (이때 String을 오름차순으로 정렬한 후 재귀 함수를 사용했다)
4. 조합한 문자들을 가지고 Dictionary에 저장했고, 저장할 때 count를 추가했다. (문자별 주문한 횟수를 보기 위함)
5. 저장된 Dictionary에서 가장 많이 주문한 조합의 횟수를 추출하고, 추출한 횟수와 같은 값들만 filter 했다.
6. filter 한 값의 [String]을 전역변수인 answer에 추가했다.
7. 최종적으로 answer를 오름차순으로 정렬한 후 반환하였다.

## 새롭게 알게 된 것
1. Dictionary의 default value 생성이 가능하다. 
```swift
// 기존 사용하던 Dictionary 방식.
var parameters:[String: Int] = [:]

if parameters["key"] == nil {
    parameters["key"] = 0
} else {
    parameters["key"]! += 1
}
```

```swift
// 새롭게 알게 된 Dictionary 방식.
var parameters:[String: Int] = [:]
parameters["key", default: 0] += 1
```
