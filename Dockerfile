# 1. 기반이 되는 OS 이미지 선택
FROM ubuntu:20.04

# 2. 설치 과정에서 사용자 입력을 요구하지 않도록 설정
ENV DEBIAN_FRONTEND=noninteractive

# 3. Apache 및 필요한 패키지 설치
RUN apt-get update && apt-get install -y \
    apache2 \
    && rm -rf /var/lib/apt/lists/*

# 4. Apache가 80포트를 사용함을 명시
EXPOSE 80

# 5. 컨테이너가 시작될 때 Apache를 백그라운드가 아닌 포그라운드에서 실행 (컨테이너 유지용)
CMD ["apache2ctl", "-D", "FOREGROUND"]