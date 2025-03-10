# 냉장고 고내 관리 서비스_푸디온
![서비스이미지](https://github.com/user-attachments/assets/8f51e3d5-98d6-4293-8cc4-0392abb515c8)

<br>

## 1. 프로젝트 소개
- 가정 내 보유율이 높은 냉장고를 타겟팅하여 새로운 IoT 기술의 추가를 통해 고객과의 접점 확대를 목표로 함. 
- 설문조사 결과 냉장고 관리에 있어 '뒤쪽에 있는 식품을 찾기 어렵다', '유통기한이 지나 폐기하는 경우가 많다', '식품의 존재나 위치를 기억하기 어렵다' 순으로 응답이 많았음.
- 크롤링 결과 '예산 낭비 감소를 위한 냉파', '유통기한이 지난 식재료 폐기', '냉장고 정리 용기 관심' 등의 핵심 행동 패턴을 도출함.
- 고객에게 냉장고 내 정리와 관리 상태 유지, 식재료의 효율적인 활용 등을 제공하기 위해 무게 정보를 기반으로 하는 스마트한 선반 솔루션을 제공해보고자자 함. 


<br>

## 2. 팀원 구성 및 역할
공통: 논리 구조 빌드, 웹크롤링 및 전처리, 서비스 앱 화면 구성, 설문 문항 논의, 유스케이스 및 솔루션 구체화
<table>
	<tr>
		<td width="20%" align="center">
			<a href="https://github.com/coin-cidence">😺도연우😺 <br>(팀장)</a>
		</td>
		<td width="20%" align="center">
			<a href="https://github.com/Moonhyunjiii">🐶문현지🐶 </a>
		</td>
		<td width="20%" align="center">
			<a href="https://github.com/alex230825">🚗이상현🚗 </a> <br>
		</td>
		<td width="20%" align="center">
			<a href="https://github.com/sujin0303-debug">🐯장수진🐯 </a> <br>
		</td>
		<td width="20%" align="center">
			<a href="https://github.com/linaekim">🪼김나린🪼 </a> <br>
		</td>
	</tr>
	<tr>
		<td width="20%" align="center">
			<img src="./images/readme/연우_i.jpg" width="120px" alt="도연우사진">
		</td>
		<td width="20%" align="center">
			<img src="./images/readme/현지_i.jpg" width="120px" alt="문현지사진">
		</td>
		<td width="20%" align="center">
			<img src="./images/readme/상현_i.jpg" width="120px" alt="이상현사진">
		</td>
		<td width="20%" align="center">
			<img src="./images/readme/수진_i.png" width="120px" alt="장수진사진">
		</td>
		<td width="20%" align="center">
			<img src="./images/readme/나린_i.jpg" width="120px" alt="김나린사진">
		</td>
	</tr>
	<tr>
		<td width="20%" align="left">
			- WBS 구조 설계<br>
			- DB 설계 및 firestore 연동<br>
			- flutter back-end<br>
			- 기획 발표, 시연 영상 녹화 및 발표
		</td>
		<td width="20%" align="left">
			- flutter 화면 front-end<br>
			- flutter back-end<br>
			- 최종 발표
		</td>
		<td width="20%" align="left">
			- 화면 설계 총괄<br>
			- figma 앱 와이어프레임<br>
			- flutter 화면 front-end<br>
			- 기기 렌더링 화면 및 영상
		</td>
		<td width="20%" align="left">
			- 크롤링 전처리 총괄<br>
			- flutter 화면 front-end<br>
			- 기능 요구사항 및 서비스 흐름도
		</td>
		<td width="20%" align="left">
			- 설문 폼 총괄<br>
			- figma 앱 와이어프레임<br>
			- flutter 화면 front-end<br>
			- 기능 요구사항 및 빅데이터 분석 정의서
		</td>
	</tr>
</table>

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
	
<div align="center">

### 푸디온(하드웨어) 이미지 렌더링

<img src="https://img.shields.io/badge/Rhino7-FFD700?style=for-the-badge&logo=Rhino&logoColor=black"/> 
<img src="https://img.shields.io/badge/KeyShot10-007ACC?style=for-the-badge&logo=Keyshot&logoColor=white"/>

### Front-End

<img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=Flutter&logoColor=white"/> 
<img src="https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=Dart&logoColor=white"/>

### Back-End

<img src="https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=Firebase&logoColor=black"/> 
<img src="https://img.shields.io/badge/NoSQL-4EA94B?style=for-the-badge&logo=NoSQL&logoColor=white"/> 
<img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=Flutter&logoColor=white"/>

### 협업툴

<img src="https://img.shields.io/badge/Figma-F24E1E?style=for-the-badge&logo=Figma&logoColor=white"/> 
<img src="https://img.shields.io/badge/Notion-000000?style=for-the-badge&logo=Notion&logoColor=white"/> 
<img src="https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=GitHub&logoColor=white"/>

</div>

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


https://github.com/user-attachments/assets/03703f07-487b-43fc-9f42-d12112e75c98



https://github.com/user-attachments/assets/79af0c0f-b2f6-402f-87f4-dc58fc610c8f




<br>

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

## 10. 앱 서비스 화면

#### i. 앱 화면 설계서

![화면설계서1](https://github.com/user-attachments/assets/525fc541-309c-496f-b64c-db9e197ad626)
![화면설계서2](https://github.com/user-attachments/assets/293c4d2c-b3c8-4054-bfc9-0d3c4df2fbbf)
![화면설계서3](https://github.com/user-attachments/assets/1fd890af-e434-4a4a-bfad-d7de810ca387)
![화면설계서4](https://github.com/user-attachments/assets/b4466035-4a05-46ce-876b-102ee2f4db4b)
![화면설계서5](https://github.com/user-attachments/assets/aa41bf1e-6425-4950-ae3b-472b0d3bd91b)
![화면설계서6](https://github.com/user-attachments/assets/a55f0cb7-b599-449e-b503-106e5a85b724)
![화면설계서7](https://github.com/user-attachments/assets/d36e38bc-5cb6-4e88-a89f-9225d0a834eb)
![화면설계서8](https://github.com/user-attachments/assets/9d399fd8-0b1a-4026-a0c5-56e5125ecc51)

<br>

#### ii. 안드로이드 앱 시연

https://github.com/user-attachments/assets/ea38d8db-beb3-4b92-b490-af07d604bb72


<br>

## 11. 트러블 슈팅
### 1. 서비스 기획
 
#### - 주제 선정
문제점: 초기 아이디어 도출 과정에서 새로운 기획에 대한 부담감이 컸음. 구체적인 페인포인트를 찾기 어려웠고, 팀원들이 문제의 본질에 대한 이해가 부족해 아이디어 발전이 느리게 진행됨.
<br>
해결방법: 주제를 작게 나누어 더 구체적이고 세부적인 문제에 접근하는 방법을 선택함. 팀원들이 각자의 파트에 대해 연구하고 페인포인트를 분석하여 문제의 핵심을 파악한 뒤, 다시 전체적인 큰 그림을 합치는 방식으로 접근하여 난이도를 낮춤. 이를 통해 팀원 모두가 주제에 대한 이해도를 높이고 효율적으로 아이디어를 발전시킬 수 있었음.
 
#### - 솔루션 우선 접근 문제
문제점: 초기 아이디어 도출 과정에서 솔루션을 먼저 떠올리고 나서 문제를 맞추는 경향이 있었음. 문제에 대한 깊은 이해 없이 솔루션을 설정하다 보니, 해결하고자 하는 문제의 본질을 놓치는 경우가 발생함.
<br>
해결방법: 문제 중심 접근법을 채택하여, 문제 자체를 충분히 이해하고 정의한 후에 솔루션을 논의하는 방향으로 전환함. 문제 정의 과정에서 "왜 이 문제가 발생하는가?", "사용자에게 어떤 영향을 미치는가?"와 같은 질문을 통해 문제를 깊이 탐구하고 페인포인트를 명확히 이해하도록 함. 문제를 명확히 정의한 뒤에 팀원들이 해결책을 제안하는 방식으로 아이디어를 발전시킴.
 
#### - 문제와 솔루션의 불일치 문제
문제점: 솔루션이 존재했지만 그것이 해결하려는 문제와 명확하게 일치하지 않는 경우가 있었음. 특히, 솔루션이 목표로 하는 사용자의 페인포인트를 정확히 해결하지 못하는 상황이 발생함.
<br>
해결방법: 문제와 솔루션의 적합성을 지속적으로 검증하기 위해, 페인포인트에 대해 심층 인터뷰 및 설문조사를 진행하여 사용자 니즈를 명확히 파악함. 이러한 데이터를 바탕으로 솔루션이 실제로 문제를 해결할 수 있는지 검토하고, 필요할 경우 솔루션을 사용자 요구에 맞춰 수정함. 이 과정에서 사용자 피드백을 반영하여 솔루션의 유효성을 강화하고, 사용자 맞춤형 솔루션을 개발하도록 개선함.
 
### 2. 데이터 전처리
 
#### - 데이터 수집량 부족 문제
문제점: 약 1,000개의 데이터를 수집하였으나, 분석에 필요한 데이터 양이 충분하지 않다는 피드백을 받음. 특히 데이터가 제한적일 경우, 분석 결과의 신뢰도와 일관성에 문제가 발생할 수 있었음.
<br>
해결방법: 다양한 소스에서 데이터를 추가로 수집하여 데이터의 양과 다양성을 확장함. 추가로 맘카페 2곳, 다이렉트결혼준비, 정리 관련 카페, 네이버 카페, 지식인, 브런치 등 여러 플랫폼을 통해 약 11,000건의 데이터를 수집함. 이를 통해 데이터의 신뢰도와 분석의 일관성을 높였고, 다양한 사용자 그룹의 의견을 반영할 수 있게 되었음.
 
#### - 불용어 처리 문제
문제점: 초기 데이터 전처리 과정에서 불용어가 제대로 제거되지 않아, 모델 학습 시 잡음으로 작용하여 분석 품질에 악영향을 미침. 불필요한 단어들이 남아 있어 분석 결과의 신뢰성을 떨어뜨렸음.
<br>
해결방법: 불용어 목록을 재정비하고 이를 텍스트 파일로 저장하여 재사용성을 높였음. 또한, 불용어를 제거하는 과정에서 남는 공백이나 중복된 공백을 정제하여 데이터의 품질을 개선함. 이러한 과정을 통해 데이터셋의 일관성을 확보하고, 분석 결과의 정확성을 높임.
 
#### - 문서 벡터화와 토픽 수 결정 문제
문제점: Doc2Vec을 활용한 문서 벡터화 과정에서 적절하지 않은 벡터가 생성되는 문제가 발생하거나, LDA 모델에서 최적의 토픽 수를 결정하는 과정에서 어려움을 겪음. 특히, 최적의 토픽 수를 찾기 위해 사용한 Elbow Method나 Coherence Score 그래프에서 명확한 기준을 찾기 어려웠음.
<br>
해결방법: 벡터화의 성능을 개선하기 위해 Doc2Vec 모델의 하이퍼파라미터(vector_size, alpha, epochs 등)를 조정함. 또한, LDA 모델의 최적 토픽 수를 결정하기 위해 Perplexity Score와 Coherence Score를 함께 고려하여 그래프가 완만하게 변하기 시작하는 지점을 선택함. 이를 통해 보다 일관된 벡터와 최적의 토픽 수를 도출할 수 있었음.
 
### 3. 개발
 
#### - 리스트와 그리드 간 데이터 불일치 문제
문제점: 리스트에서 특정 아이템을 삭제했을 때, 그리드 영역에서 해당 아이템의 좌표 데이터가 삭제되지 않는 문제가 발생함. 이로 인해 사용자 경험의 일관성이 떨어지고, UI 상의 혼란을 초래함.
<br>
해결방법: 데이터 삭제 시, filteredFoodData, allFoodData, highlightedLocations 등 모든 데이터 소스에서 해당 데이터를 일관되게 삭제하도록 수정함. 이를 통해 리스트와 그리드 간의 데이터 불일치를 해결하고, 사용자 경험을 개선할 수 있었음.
 
#### - 하이라이트 기능 문제
문제점: 그리드의 특정 셀을 클릭하여 좌표를 하이라이트할 때, 다시 클릭해도 하이라이트가 해제되지 않거나 예기치 않은 방식으로 동작하는 문제가 발생함. 이로 인해 사용자가 하이라이트 상태를 정확하게 파악하기 어려웠음.
<br>
해결방법: 하이라이트 해제 조건을 명확히 하고, 이미 하이라이트된 좌표를 다시 클릭했을 때 해제되도록 조건문을 수정함. 또한, highlightedLocations 리스트를 정확하게 업데이트하여 선택/해제 상태가 일관되도록 처리하여 문제를 해결함.
 
### - 데이터 필터링 로직 문제
문제점: 필터링 옵션("가나다순", "오래된순" 등)을 변경했을 때 필터링 결과가 제대로 반영되지 않거나, 예상과 다른 동작이 발생함. 이는 filteredFoodData와 allFoodData 간의 관계를 정확히 처리하지 못하거나, 필터링 상태가 올바르게 반영되지 않기 때문이었음.
<br>
해결방법: 필터링을 적용할 때 filteredFoodData를 항상 allFoodData로부터 복사하여 시작하도록 수정함. 이를 통해 데이터의 원본이 변하지 않도록 하고, setState 호출 시점에서 데이터가 정확하게 반영되도록 보장하여 필터링 결과가 일관되게 나타나도록 조정함.
 
#### - Firestore 데이터 불러오기 실패 및 반복 호출 문제
문제점: Firestore 쿼리를 통해 데이터를 가져오지 못하거나, FutureBuilder가 반복 호출되어 Firestore 쿼리가 무한히 호출되는 문제가 발생함. 이로 인해 앱바에서 선반 이름이 "이름 없음"으로만 표시되거나, 로딩 상태가 반복됨.
<br>
해결방법: Firestore 쿼리 조건을 점검하고, 데이터베이스와 쿼리 조건의 일치 여부를 확인함. FutureBuilder의 future를 initState에서 한 번만 초기화하여 반복적인 상태 갱신을 방지하고, 쿼리 결과가 정확하게 업데이트되었는지 setState로 관리함.
 
#### - 데이터가 없을 때 다이얼로그 반복 호출 문제
문제점: Firestore에서 데이터가 없는 경우 다이얼로그가 반복 호출되며 동일한 메시지가 계속 출력되는 문제가 발생함. 이는 사용자 경험을 저해하고, 불필요한 반복 작업을 유발했음.
<br>
해결방법: WidgetsBinding.instance.addPostFrameCallback을 사용하여 다이얼로그 호출을 데이터 상태 변화 이후 한 번만 이루어지도록 수정함. 또한, 호출된 상태를 관리하는 플래그를 추가하여 다이얼로그가 중복으로 호출되지 않도록 조정함. 이를 통해 사용자 경험을 개선하고, 불필요한 상태 변경을 최소화함.
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
### 😺도연우😺
고내 정리라는 주제는 사용자 친화적인 솔루션을 구현해내기 어려운 주제라고 생각합니다. 기획부터 솔루션단까지 정말 많은 아이디에이션과 논의가 필요했는데, 포기하지 않고 끝까지 같이 달려준 팀원들 덕분에 최선의 결과물을 낼 수 있었습니다. 개인적으로는 처음 접한 firestore의 연동과 flutter 백엔드 작업이 가장 힘들었고 성장한 경험이었습니다. 시간이 더 있었다면 인공지능 모델을 추가해봤어도 좋았을 것 같은데 조금 아쉬움이 남습니다. 팀장으로 프로젝트를 진행하면서 부담도 많이 되었는데, 부족함이 많았지만 모두 잘 따라와줘서 너무 고맙습니다. 다들 너무 수고했고 앞으로의 일들에도 좋은 결과 있기를 진심으로 바랍니다 💪
<br>
    
### 🐶문현지🐶
이번 프로젝트는 포기하지 않고 끝까지 완주하는 것이 목표였습니다. 수업과 병행하며 짧은 시간을 쪼개 한 달 넘게 아이디에이션과 주제 선정에 몰두했던 게 기억에 남습니다. 초반에 데이터를 더 빠르게 활용했더라면 좋았을 거라는 아쉬움도 있지만, 팀원들이 기획부터 개발까지 적극적으로 참여해줘서 성공적으로 마칠 수 있었습니다. 정말 고마운 마음입니다. 😊 이번 경험으로 스스로 더 많이 시도하고 배우는 자세가 필요하다는 걸 느꼈고, 아이디어를 더 명확하게 전달하는 방법도 배워야겠다고 다짐했습니다. 기술적인 성장뿐 아니라 문제를 해결하는 방식도 개선해야 할 부분이 많았습니다. 짧지만 알찬 두 달이었습니다. 모두 고생 많으셨고, 각자 목표 이루고 더 멋진 모습으로 다시 만나요! 🙌
<br>

### 🚗이상현🚗
플러터 앱 개발을 경험하면서 작은 화면에서의 레이아웃 설계가 쉽지 않다는 점을 깨달았습니다. 비록 많은 화면을 담당하지는 않았지만, 제가 맡은 화면 내에서만이라도 세련된 디자인 효과를 주기 위해 다양한 플러터 기능을 탐색했습니다. 그 결과, 일차원적으로 접근할 수밖에 없었던 화면 디자인에 조금 더 활기를 불어넣을 수 있었습니다. 또한, 데이터 분석 단계에서는 전처리의 중요성을 가장 깊이 실감했던 프로젝트이기도 했습니다.
<br>

### 🐯장수진🐯
모든 일이 그렇듯 목표에 비해 아쉬움이 남는 프로젝트지만, 어려운 주제였음에도 과감하게 도전해서 완성시킨 우리팀원들 너무 멋있다고 말하고싶습니다. 크롤링 시 기준을 확실하게 잡아야한다는 것, 소셜 데이터 전처리가 쉽지않다는 것, 화면을 구현하다보면 추가할 기능이 또 생긴다는 것을 배웠습니다.
<br>

### 🪼김나린🪼
짧은 시간 동안 기획부터 구현까지 진행해야 했던 정신없는 한 달이었습니다. 주제가 어렵고 도전적인 만큼 많은 한계에 부딪혔지만, 팀원들과 함께 끊임없이 고민하며 해결 방안을 찾아나가는 과정에서 많은 것을 배울 수 있었습니다. 특히, 아이디어를 빌드하고 실현해나가는 과정에서 명확한 커뮤니케이션의 중요성을 다시 한번 깨달았습니다. 이번 프로젝트를 통해 해보지 않았던 앱 구현까지 도전하며 새로운 기술과 경험을 쌓을 수 있었던 점이 정말 뜻깊었습니다. 혼자였다면 도저히 해낼 수 없었을 일을, 팀원들과 함께해서 완성할 수 있었다는 점이 무엇보다 소중하게 느껴집니다. 함께 고생한 조원들 모두 정말 고생 많으셨고, 덕분에 저도 한 단계 더 성장할 수 있었습니다. 팀원 모두 고맙고, 수고했습니다!
