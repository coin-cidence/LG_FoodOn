# 냉장고 고내 정리 서비스_푸디온
![서비스이미지](https://github.com/user-attachments/assets/8f51e3d5-98d6-4293-8cc4-0392abb515c8)

- 배포 URL : 
- Test ID : 
- Test PW : 

<br>

## 1. 프로젝트 소개
푸디온은 냉장고 내부의 식재료를 효율적으로 관리하고 언제 어디서든 실시간으로 확인할 수 있는 스마트한 환경을 제공합니다. 고객의 일상 속 냉장고 정리 스트레스를 해소하며, 더욱 편리한 식재료 관리 경험을 제공합니다.
 
주요 기능:
자동 식재료 인식 및 등록: 무게 센서를 활용한 식품 정보 자동 입력
ThinQ 앱 연동: 냉장고 내부 식품 정보를 앱에서 쉽게 확인 및 관리
위치 및 리스트 확인: 등록된 식재료의 위치 및 목록 실시간 조회
식품 관리 알림: 유통기한 임박 식품 알림, 장기간 사용되지 않은 식재료 알림

<br>

## 2. 팀원 구성 및 역할
공통: 논리 구조 빌드, 웹크롤링 및 전처리, 서비스 앱 화면 구성, 설문 문항 논의, 유스케이스 및 솔루션 구체화

### 도연우(팀장)
- WBS 구조 설계
- DB 설계 및 firestore 연동
- flutter back-end
- 기획 발표, 시연 영상 녹화 및 발표

<br>
    
### 문현지
- flutter 화면 front-end
- flutter back-end
- 최종 발표
<br>

### 이상현
- 화면 설계 총괄
- figma 앱 와이어프레임
- flutter 화면 front-end
- 기기 렌더링 화면 및 영상
  
<br>

### 장수진
- 크롤링 전처리 총괄
- flutter 화면 front-end
- 기능 요구사항 및 서비스 흐름도

<br>

### 김나린
- 설문 폼 총괄
- figma 앱 와이어프레임
- flutter 화면 front-end
- 기능 요구사항 및 빅데이터 분석 정의서

<br>

## 3. 주요 솔루션
- 알림 메세지 생성
	- 유통기한 임박 식품 및 장기 미사용 식품 정보를 알림메세지 화면에서 표시
- 식품 리스트 제공
	- 식품명 선택 시 해당하는 위치 아이콘 하이라이트
	- 아이콘 선택 시 해당하는 식품명 표시
	- 검색 기능 및 리스트 정렬 항목 선택을 통해 식품 필터링
- 식품 상세 정보 제공 및 편집
	- 식품 상세 화면에서 해당하는 식품의 상세제공 표시 및 이름, 유통기한, 장기미사용알림 기간, 알림 활성화 수정 가능
<br>

## 4. 개발 환경
### 푸디온(하드웨어) 이미지 렌더링
<img src="https://img.shields.io/badge/Rhino7-FFD700?style=for-the-badge&logo=Rhino&logoColor=black"/> <img src="https://img.shields.io/badge/KeyShot10-007ACC?style=for-the-badge&logo=Keyshot&logoColor=white"/>

### Front-End
<img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=Flutter&logoColor=white"/> <img src="https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=Dart&logoColor=white"/>

### Back-End
<img src="https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=Firebase&logoColor=black"/> <img src="https://img.shields.io/badge/NoSQL-4EA94B?style=for-the-badge&logo=NoSQL&logoColor=white"/> <img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=Flutter&logoColor=white"/>

### 협업툴
<img src="https://img.shields.io/badge/Figma-F24E1E?style=for-the-badge&logo=Figma&logoColor=white"/> <img src="https://img.shields.io/badge/Notion-000000?style=for-the-badge&logo=Notion&logoColor=white"/> <img src="https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=GitHub&logoColor=white"/>

<br>

## 5. 프로젝트 구조
기기 이미지 렌더링(Rhino7, KeyShot10), 앱 화면 구현(Dart), DB 구축 및 앱 연동(Firebase), 개발자 협업 툴(Figma, GitHub, Notion)
![시스템 아키텍처_ft ie-land](https://github.com/user-attachments/assets/8d217359-f6fe-46c2-9609-f62582d8ccf8)

<br>

## 6. 프로젝트 WBS (2024-10-04 ~ 2024-12-05)
https://docs.google.com/spreadsheets/d/1HO8h-Psc0BDuIP3_VJbJCITzMEcTdW9yRFJUZjVBzs8/edit?gid=0#gid=0
![image](https://github.com/user-attachments/assets/e265a4b1-ac54-4c5a-b5b1-93635bb9bfc0)

<br>

## 7. 유스케이스
[스마트 선반 등록]
1. 고객이 스마트 선반을 구입한다.
2. 스마트 선반 아이콘을 클릭한다.
3. 스마트 선반과 핸드폰을 동일 네트워크에 두고 ThinQ에 IoT 기기를 등록한다.
4. 스마트 선반이 ThinQ 메인화면과 냉장고 상세 화면에 등록된 것을 확인한다.
<br>

[식품 최초 등록]
1. 식품을 스마트 선반에 올려둔다. 
2. H/W에서 무게, 위치 정보가 인식된다.
3. 선반 디스플레이에 인식된 정보를 알려주는 팝업이 뜬다. 
4. 팝업 확인 후 식품명을 음성으로 등록한다. 
5. 등록 완료 후 ThinQ 앱에 정보가 연동된다.
<br>

[등록 식품의 사용]
1. 적재 중이던 식품을 꺼낸다. 
2. 선반 디스플레이에 빈자리를 표시하는 색깔(빨강)로 변경된다.
3. ThinQ 앱에 정보가 연동된다.
<br>

[식품 정보 변경]
1. 식품 사용 후 이전과 비슷한 위치에 다시 적재한다. 
2. 무게, 위치 정보가 인식되면 선반 디스플레이에 변경된 식품 정보의 알림 팝업이 뜬다. 
3. ThinQ 앱에 정보가 연동된다.
<br>

[식품 정보 삭제]
- 수동으로 지워지는 로직 
	1. 선반 디스플레이에서 해당 구역을 터치하여 기존 정보를 삭제한다. 
	2. ThinQ 앱에 정보가 연동된다. 
- 자동으로 지워지는 로직 
	1. 24시간 내에 자리에 재적재가 되지 않는 경우, 해당 식품은 자동 삭제된다. 
	2. ThinQ 앱에 정보가 연동된다.
<br>

[등록 식품의 미사용 (1주일) 알림]
1. 적재된 식품에 대한 무게 변동을 체크한다. 
2. 1주일 이상 무게 변동이 없었던 식품에 대해 ‘장기간 미사용 식품 알림’ 단계로 넘어간다. 
3. 1주일 이상 무게 변동이 없었던 식품에 대해 ThinQ 알림과 선반 디스플레이상 색깔(보라)을 준다. 
4. 무게 정보가 1주일 이상 변동이 없을 시, ThinQ에서 알림으로 ‘식품이 기다리고 있어요’ 알림을 준다.
<br>

[식품 리스트 조회]
1. 등록된 식품을 리스트로 확인한다. 
2. 삭제하고 싶거나 상세 정보를 확인하고 싶은 식품을 슬라이드 한다. 
3. 바로 삭제할 식품은 삭제 아이콘을 눌러 삭제한다. 
4. 상세 정보를 확인하고 싶은 식품은 상세 정보 아이콘을 누른다.
<br>

[식품 상세 정보 확인]
1. 식품 리스트 조회 화면에서 식품 상세 조회 아이콘을 클릭한다. 
2. 수정을 원할 시 수정 버튼을 클릭하여 식품명, 유통기한, 장기 미사용 알림을 수정한다.
3. 식품 삭제를 원하면 삭제 아이콘을 클릭한다. 
4. 식품 알림 설정 버튼 활성화/비활성화를 통해 장기 미사용 식품 알림을 받거나 받지 않는다.
<br>

[식품 알림 메시지 화면]
1. 등록된 식품의 알림 설정을 활성화했을 시 상단 바에 메시지 표시
2. 메시지 클릭 시 메시지가 모여있는 메시지 페이지로 이동
   
<br>

## 8. 서비스 흐름도
https://www.figma.com/board/Y9GgzYTVeu4n8wVslvkmQj/%EC%84%9C%EB%B9%84%EC%8A%A4-%ED%9D%90%EB%A6%84%EB%8F%84?node-id=0-1&node-type=canvas
![image](https://github.com/user-attachments/assets/bab6b0e8-47d1-4e3a-bde2-cad45620431d)

<br>

## 9. ERD
![image](https://github.com/user-attachments/assets/f40f52e3-774b-4c93-bd47-03e25b855bf9)
<br>

## 10. 앱 서비스 화면 구성

![화면설계서1](https://github.com/user-attachments/assets/525fc541-309c-496f-b64c-db9e197ad626)
![화면설계서2](https://github.com/user-attachments/assets/293c4d2c-b3c8-4054-bfc9-0d3c4df2fbbf)
![화면설계서3](https://github.com/user-attachments/assets/1fd890af-e434-4a4a-bfad-d7de810ca387)
![화면설계서4](https://github.com/user-attachments/assets/b4466035-4a05-46ce-876b-102ee2f4db4b)
![화면설계서5](https://github.com/user-attachments/assets/aa41bf1e-6425-4950-ae3b-472b0d3bd91b)
![화면설계서6](https://github.com/user-attachments/assets/a55f0cb7-b599-449e-b503-106e5a85b724)
![화면설계서7](https://github.com/user-attachments/assets/d36e38bc-5cb6-4e88-a89f-9225d0a834eb)
![화면설계서8](https://github.com/user-attachments/assets/9d399fd8-0b1a-4026-a0c5-56e5125ecc51)


<br>

## 11. 트러블 슈팅

<br>

## 12. 개선 목표
- 인공지능 추가
	- 등록한 식품명 인식을 통해 식품 상세 페이지 내 유통기한 기한 자동 등록 기능 구현 
- 홈 화면 UI 개선
	- 사용자가 냉장고 2대 이상일 경우를 고려하여 스마트 선반 등록 시 냉장고를 선택하여 등록할 수 있도록 플로우 개선
- 알림 메세지 기능 개선
	- DB 실시간 연동을 통해 알림 창 화면 상단에 표시 (비동기식)
	- 메세지 창 클릭 시 알림메세지 페이지로 이동할 수 있도록 연결
	- 알림 뱃지 메세지 갯수 표시 비동기식으로 개선
- 로그데이터 추가하는 기능 구현
	- 식품 정보 등록, 삭제, 수정 시 DB 로그 테이블에 반영
- 홈 이동 아이콘 추가
	- 홈 화면으로 바로 이동할 수 있는 기능 모든 앱 화면에 구현
- 알림 활성화 기능 개선
	- 식품 상세 페이지 내 편집 상태가 아닌 경우에도 알림 토글 상태 변경이 반영되도록 수정
   
<br>

## 13. 프로젝트 후기
### 도연우(팀장)
- WBS 구조 설계
- DB 설계 및 firestore 연동
- flutter back-end
- 기획 발표, 시연 영상 녹화 및 발표

<br>
    
### 문현지
이번 프로젝트는 포기하지 않고 끝까지 완주하는 것이 목표였습니다. 수업과 병행하며 짧은 시간을 쪼개 한 달 넘게 아이디에이션과 주제 선정에 몰두했던 게 기억에 남습니다. 초반에 데이터를 더 빠르게 활용했더라면 좋았을 거라는 아쉬움도 있지만, 팀원들이 기획부터 개발까지 적극적으로 참여해줘서 성공적으로 마칠 수 있었습니다. 정말 고마운 마음입니다. 😊 이번 경험으로 스스로 더 많이 시도하고 배우는 자세가 필요하다는 걸 느꼈고, 아이디어를 더 명확하게 전달하는 방법도 배워야겠다고 다짐했습니다. 기술적인 성장뿐 아니라 문제를 해결하는 방식도 개선해야 할 부분이 많았습니다. 짧지만 알찬 두 달이었습니다. 모두 고생 많으셨고, 각자 목표 이루고 더 멋진 모습으로 다시 만나요! 🙌
<br>

### 이상현
플러터 앱 개발을 경험하면서 작은 화면에서의 레이아웃 설계가 쉽지 않다는 점을 깨달았습니다. 비록 많은 화면을 담당하지는 않았지만, 제가 맡은 화면 내에서만이라도 세련된 디자인 효과를 주기 위해 다양한 플러터 기능을 탐색했습니다. 그 결과, 일차원적으로 접근할 수밖에 없었던 화면 디자인에 조금 더 활기를 불어넣을 수 있었습니다. 또한, 데이터 분석 단계에서는 전처리의 중요성을 가장 깊이 실감했던 프로젝트이기도 했습니다.
  
<br>

### 장수진
모든 일이 그렇듯 목표에 비해 아쉬움이 남는 프로젝트지만, 어려운 주제였음에도 과감하게 도전해서 완성시킨 우리팀원들 너무 멋있다고 말하고싶습니다. 크롤링 시 기준을 확실하게 잡아야한다는 것, 소셜 데이터 전처리가 쉽지않다는 것, 화면을 구현하다보면 추가할 기능이 또 생긴다는 것을 배웠습니다.

<br>

### 김나린
짧은 시간 동안 기획부터 구현까지 진행해야 했던 정신없는 한 달이었습니다. 주제가 어렵고 도전적인 만큼 많은 한계에 부딪혔지만, 팀원들과 함께 끊임없이 고민하며 해결 방안을 찾아나가는 과정에서 많은 것을 배울 수 있었습니다. 특히, 아이디어를 빌드하고 실현해나가는 과정에서 명확한 커뮤니케이션의 중요성을 다시 한번 깨달았습니다. 이번 프로젝트를 통해 해보지 않았던 앱 구현까지 도전하며 새로운 기술과 경험을 쌓을 수 있었던 점이 정말 뜻깊었습니다. 혼자였다면 도저히 해낼 수 없었을 일을, 팀원들과 함께해서 완성할 수 있었다는 점이 무엇보다 소중하게 느껴집니다. 함께 고생한 조원들 모두 정말 고생 많으셨고, 덕분에 저도 한 단계 더 성장할 수 있었습니다. 팀원 모두 고맙고, 수고했습니다!

<br>
