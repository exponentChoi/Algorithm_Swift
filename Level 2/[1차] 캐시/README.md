- LRU(Least Recently Used)
가장 오래 사용하지 않은 페이지를 교체하는 알고리즘이다.
현재 가장 많은 운영체제가 채택한 알고리즘으로 가장 효율이 좋다고 평가받고 있다.

- LFU(Least Frequently Used)
참조 횟수가 가장 적은 페이지를 교체하는 알고리즘이다.
만약 교체 대상이 여러 페이지일 경우 가장 오래 사용하지 않은 페이지로 교체한다.

- Solution(...) 함수를 작성한 이유
LRU와 LFU를 혼동하여 발생한 실수이다.
가장 적게 사용된 캐시를 삭제하고, 사용된 횟수가 같은 경우에는 가장 오래된 캐시를 삭제하도록 설계하였다. (LFU)


이후 가장 오래된 캐시만 삭제하도록 설계하여 완료하였다. (LRU)
