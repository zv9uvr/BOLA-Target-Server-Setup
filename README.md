# 환경설정 및 BOLA 취약점 기본 실습

1\. Docker 윈도우/맥 버전 설치.

* 공통: 설치 후 반드시 실행 중인지 확인
* Windows: 설정(Settings > Resources > WSL Integration)에서 사용하는 WSL 배포판(Ubuntu 등)이 활성화되어 있는지 확인.
* Mac: Settings > Resources > File Sharing에서 프로젝트 디렉토리 경로 추가.
ex) /프로젝트 디렉토리 경로 -> /username/project directory root (반드시 영문 폴더로 만들 것)

2\. Dockerfile과 docker-compose.yml 파일을 폴더에 넣고, 해당 폴더에서 터미널을 실행합니다.

* Windows: 폴더 빈 공간 우클릭 > '터미널에서 열기' 클릭.
* Mac: 1번에서 설정한 공유 폴더 경로로 이동한 뒤 터미널 실행. (경로가 다르면 파일 공유 권한 에러가 날 수 있으니 주의할 것.)

3\. 터미널에서 ``docker-compose up -d --build`` 입력.

4\. ``docker ps`` 를 입력했을 때 target-api-server 가 목록에 보인다면 BOLA 취약점 타겟 서버 정상 가동된 것.

5\. 크롬에서 http://localhost:8080/ 를 입력했을 때 Apache2 Ubuntu Default Page가 뜬다면 환경 설정 완료.

6\. ``docker exec -it target-api-server /bin/bash`` 를 입력해서 컨테이너 내부에 접속.

7\. ``mkdir -p /var/www/html/api`` 를 입력하여 데이터 디렉토리 생성.

8\. 내 정보(101)와 다른 유저의 정보(102, 103 등) 생성
```
echo '{"id": 101, "name": "Nayeon", "role": "admin"}' > /var/www/html/api/101
echo '{"id": 102, "name": "Songhee", "role": "user"}' > /var/www/html/api/102
echo '{"id": 103, "name": "Yoonhee", "role": "user"}' > /var/www/html/api/103
```

9\. 크롬 주소창에 http://localhost:8080/api/101, http://localhost:8080/api/102, http://localhost:8080/api/103 를 각각 입력하며 유저의 정보가 보이는지 확인.


> 이렇게 일반 유저의 입장에서 브라우저로 접속했을 때, 주소창의 숫자만 바꿨는데도 다른 유저의 정보가 보이는 것이 BOLA(객체 수준 권한 위반)라는 취약점이다. 
