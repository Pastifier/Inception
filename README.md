# Inception
CPP09

```
├── Makefile
├── README.md
├── secrets
│   ├── credentials.txt
│   ├── db_password.txt
│   ├── db_root_password.txt
│   └── README.md
└── srcs
    ├── docker-compose.yml
    └── requirements
        ├── mariadb
        │   ├── docker-entrypoint.sh
        │   └── Dockerfile
        ├── nginx
        │   ├── conf
        │   │   └── nginx.conf
        │   ├── docker-entrypoint.sh
        │   └── Dockerfile
        └── wordpress
            ├── conf
            │   └── www.conf
            ├── docker-entrypoint.sh
            ├── Dockerfile
            └── tools
                └── wp-cli.phar
```
