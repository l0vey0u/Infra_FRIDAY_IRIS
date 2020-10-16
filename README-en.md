[contributors-shield]: https://img.shields.io/github/contributors/osamhack2020/Infra_FRIDAY_IRIS?style=flat-square
[contributors-url]: https://github.com/osamhack2020/Infra_FRIDAY_IRIS/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/osamhack2020/Infra_FRIDAY_IRIS.svg?style=flat-square
[forks-url]: https://github.com/osamhack2020/Infra_FRIDAY_IRIS/network/members
[stars-shield]: https://img.shields.io/github/stars/osamhack2020/Infra_FRIDAY_IRIS?style=flat-square
[stars-url]: https://github.com/osamhack2020/Infra_FRIDAY_IRIS/stargazers
[issues-shield]: https://img.shields.io/github/issues/osamhack2020/Infra_FRIDAY_IRIS.svg?style=flat-square
[issues-url]: hhttps://github.com/osamhack2020/Infra_FRIDAY_IRIS/issues
[license-shield]: https://img.shields.io/github/license/osamhack2020/Infra_FRIDAY_IRIS.svg?style=flat-square
[license-url]: https://github.com/osamhack2020/Infra_FRIDAY_IRIS/blob/main/LICENSE

[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![Apache 2.0 License][license-shield]][license-url]

<h1 align="center"> I R I S </h1>
<p align="center">
  <img src="https://github.com/osamhack2020/Infra_FRIDAY_IRIS/blob/main/team_logo.png" width="200" alt="team logo">
</p>

## Prolog

[![Food Waste Disposal Costs Problem](https://img.youtube.com/vi/nciqfJ8wz0g/0.jpg)](https://www.youtube.com/watch?v=nciqfJ8wz0g)

There is vicious circle at cafeteria

Overordering -> Over-food production -> A lot of leftover -> Excessive Food Waste Disposal Costs

The number of people who eat dinner on weekends is greatly reduced, while food production remains unchanged.

This leads to a lot of leftovers.

However, the chef cooked according to the number of people scheduled for the official dinner.

To solve this problem, let's find out how many people are actually going to eat dinner using DeepLearning.

Predictions will be effective if only certain patterns are found in cafeteria

This program consists of several  services that interact each other

## Functional Design

### Database
![HA-Database-Infra](https://drive.google.com/uc?export=download&id=1C9Wra6ZUjt2nFJY5dSKY6zYqQoIZ_dBM)

## Prerequisites

* Docker Engine version >= 19.03
* Docker Compose version >= 1.27.4

1. Install docker follow below posts depends on your os

- ["Install Docker at ubuntu 20.04"](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-20-04)
- ["Install Docker at Windows 10"](https://www.wsgvet.com/ubuntu/180?sfl=wr_subject%7C%7Cwr_content&stx=NAS&sst=wr_hit&sod=desc&sop=and&page=1)

2. Docker Compose Installation (Don't need at already installed)

```bash
$ cd scripts
$ ./install_docker-compse.sh
```

## Technique Used

### front-end

 -  Flask
 -  SQLAlchemy

### Database

 - Mysql ( >= 8.0)

### Load balancer

 - HA Proxy

## Installation Process

1. Compose Database

```bash
$ cd database
$ docker-compose up -d --build
# Load Database Scheme
$ docker exec -i main_master_db mysql -u root -pIz0ne!!!! friday < friday.sql
```

## Getting Started

- Further scheduled

## Team Information

- Pyo Sehun (kimpyo9357@naver.com), Github Id: kohari0912
- Jeong Deokho (duckhoim@naver.com), Github Id: l0vey0u

## Copyleft / End User License

### License

This software is licensed under the [Apache 2 license](LICENSE), quoted below.

Copyright 2020. Team IRIS

Licensed under the Apache License, Version 2.0 (the "License"); you may not
use this project except in compliance with the License. You may obtain a copy
of the License at http://www.apache.org/licenses/LICENSE-2.0.

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
License for the specific language governing permissions and limitations under
the License.