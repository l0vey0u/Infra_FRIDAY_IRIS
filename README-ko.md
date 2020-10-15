### Docker로 구현한 MYSQL HA 구조
---
사용법
```bash
# 이미지를 빌드하면서 컨테이너 구성
$ docker-compose up -d --build
# 만들어진 볼륨 및 컨테이너를 삭제하면서 컨테이너 구성 해제
$ docker-compose down -v
```

구성
- Master Node(main) - Master Node(sub)

  HA Proxy가 health check를 주기적으로 진행하다 main node가 down 된 것을 발견하면 모든 요청을 sub node로 전환하여 fail over를 구성합니다.
- Master Node(main) - Slave Node

  HA Proxy가 Round-robin을 통해 후보군들을 사용하여 부하 분산을 진행합니다.

  또한 Slave에게 Read를 전담하고 Master만 Write가 가능하게 함으로써 읽기 / 쓰기에 대한 요청을 분산시켜 두었고 

  Read가 요청에 대부분일 것으로 예상되어 Read는 3개의 노드 모두 후보군으로 두고 가중치만 slave가 압도적으로 높게 두었습니다.
  
> Notice

Github Codespace 등의 codespace 환경에선 codespace branch 소스를 활용하시길 바랍니다.

volume mount 쪽에서 파일을 폴더로 마운트 하는 문제가 있는데 해결 법을 모르겠어서 Dockerfile에 Copy로 이미 완성된 이미지로 컨테이너가 생성되도록 하여 임시조치 하였습니다.

해결 방법을 아시면 duckhoim@naver.com으로 메일 부탁드립니다.