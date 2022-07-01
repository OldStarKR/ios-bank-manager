
# 🏦 은행 창구 매니저

## 💾 프로젝트 저장소
>**프로젝트 기간** : 2022-06-27 ~ 2022-06-30
**소개** : 은행에 온 고객의 업무를 처리하는 은행 창구 매니저를 구현하였습니다.
**리뷰어** : [**제이슨**](https://github.com/ehgud0670)

## 👥 팀원
    
| 재재 | 나이든별 |
|:---:|:---:|
|![](https://i.imgur.com/Xa9oBRA.png)|![](https://i.imgur.com/IajxRmr.png)|
|[Github](https://github.com/ZZBAE)|[Github](https://github.com/OldStarKR)|
    

---

## 🕖 타임라인: 시간 순으로 프로젝트의 주요 진행 척도를 표시

### Week 1
- **2022-06-27(월)** 
  - 공개된 프로젝트 STEP1에 대해 논의하고, 전체적인 프로젝트의 청사진 수립
 
- **2022-06-28(화)** - STEP1 PR
  - STEP1 진행: 노드, 연결 리스트, 큐 자료구조 구현

- **2022-06-29(수)**
  - 리뷰어 제이슨과 함께 STEP 1 리뷰
  - STEP2 진행 방향 논의

- **2022-06-30(목)**
  - STEP2 진행: 은행원과 고객 모델 작성, 은행 매니저 컨트롤러 작성
  
- **2022-07-01(금)**
  - Readme.md 작성

---

## ✏️ 프로젝트 내용

### 💻 핵심 기능 경험
- [x] Linked-list 자료구조의 이해 및 구현
- [x] Queue 자료구조의 이해 및 구현
- [x] Generics 개념이해 및 적용
- [x] Queue의 활용
- [x] 타입 추상화 및 일반화


### ⚙️ 구현 기능
- **BankManagerConsoleApp**
    - main : BankManager 인스턴스를 생성하고 시작 메서드를 실행
- **Model**
    - CustomerQueue : 큐 프로토콜을 채택한, 고객 대기열을 나타내는 연결 리스트
    - Client : 고객 모델. 대기번호 프로퍼티를 가지고 있음
    - Clerk : 은행원 모델. 서비스 제공 메서드를 가지고 있음
- **Controller**
    - BankManager : 프로그램의 수행을 전반적으로 컨트롤해주는 객체
- **Utilities**
    - Protocols
        - Queue : 큐 자료구조가 수행해야 할 기능 구현 (`isEmpty`, `peek`, `enqueue`, `dequeue`, `clear`)
    - Node : 연결 리스트의 각 노드를 구현
    - LinkedList : 노드를 연결함으로써 이루어지는 단방향 연결 리스트 구현
- **CustomerQueueTests**
    - CustomerQueueTests : 고객 대기열 큐의 각 메서드에 대한 테스트 코드

---
### 🏀 TroubleShooting
1. **defer { }**
    > defer는 함수가 return까지 한 후에 실행되는 클로저입니다. 작성된 위치와 상관 없이 함수 종료 직전에 실행되는 구문이기 때문에, `BankManager`클래스 안에 `issueTickets`와 `startwork` private 메서드 안에 실행될 수 있게 추가해주었습니다.

2. **usleep -> Thread.sleep(forTimeInterval: 0.7)**
    > 각 고객의 은행 업무를 시작하고 완료하기까지 0.7초의 시간을 설정해줘야 하는 부분이였는데, usleep이라는 메서드를 알게 되었습니다. C에서 유래한 Thread를 재우는 메서드라서 swift에서 사용은 가능한 것 같으나 Thread.sleep(forTimeInterval: 시간) 을 지향한다고 하여 메서드를 변경해주었습니다. usleep을 사용했을 때, 기준을 1000000으로 잡아야하는 상수를 따로 설정해주었는데, Thread.sleep(forTimeInterval:) 메서드를 사용하니 따로 설정해줄 필요가 없어서 코드가 전반적으로 깔끔해지고 가독성도 생긴 것 같습니다.




---

### 참고한 페이지

[Swift Language Guide - Inheritance](https://docs.swift.org/swift-book/LanguageGuide/Inheritance.html)<br>
[Swift Language Guide - Closures](https://docs.swift.org/swift-book/LanguageGuide/Closures.html)<br>
[Swift Language Guide - Generics](https://docs.swift.org/swift-book/LanguageGuide/Generics.html)
