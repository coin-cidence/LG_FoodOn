# 냉장고 고내 정리 서비스_푸디온
![서비스이미지](https://github.com/user-attachments/assets/8f51e3d5-98d6-4293-8cc4-0392abb515c8)

- 배포 URL : 
- Test ID : 
- Test PW : 

<br>

## 1. 프로젝트 소개

- ㅇㅇㅇ
- ㅇㅇㅇ
- ㅇㅇㅇ
- ㅇㅇㅇ

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
- flutter 화면 front-end
- flutter back-end
- 최종 발표
<br>

### 이상현
- figma 앱 와이어프레임
- flutter 화면 front-end
- 기기 렌더링 화면 및 영상
  
<br>

### 장수진
- 크롤링 전처리 총괄
- flutter 화면 front-end
- 요구사항 정의 및 서비스 흐름도

<br>

### 김나린
- 설문 폼 총괄
- figma 앱 와이어프레임
- flutter 화면 front-end

<br>
