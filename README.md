### MYSQL HA Infra impl by docker
---
Usage
```bash
# Start with build
$ docker-compose up -d --build
# Stop with remove
$ docker-compose down -v
```

Composition
- Master Node(main) - Master Node(sub)

  When HA Proxy detect main node is dead, connection request will be go to sub node 
- Master Node(main) - Slave Node

  HA Proxy split Read / Write Request, Slave Node do read mainly and not write ( Don't Write to Slave!!!! )
- HA Proxy Round-robin Loadbalancing

  Give Weight to act properly
  Read : slave >>>>>> sub master > main master
  Write : sub master > main master
  
> Notice

At Codespace use source that codespace branch

I don't know why docker-compose mount file as directory at codespace...

So Instead Volume mount, I make dockerfile what already set image by 'copy'