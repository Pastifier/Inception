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

```
ariadb  | DB_NAME=wordpress
mariadb  | DB_USER=ebinjama
mariadb  | MYSQL_ROOT_USER=root
mariadb  | First boot detected. Initializing database...
mariadb  | /usr/bin/mysql_install_db: Deprecated program name. It will be removed in a future release, use 'mariadb-install-db' instead
mariadb  |  * Creating a new MySQL database ...Installing MariaDB/MySQL system tables in '/var/lib/mysql' ...
mariadb  | OK
mariadb  | 
mariadb  | To start mariadbd at boot time you have to copy
mariadb  | support-files/mariadb.service to the right place for your system
mariadb  | 
mariadb  | 
mariadb  | Two all-privilege accounts were created.
mariadb  | One is root@localhost, it has no password, but you need to
mariadb  | be system 'root' user to connect. Use, for example, sudo mysql
mariadb  | The second is mysql@localhost, it has no password either, but
mariadb  | you need to be the system 'mysql' user to connect.
mariadb  | After connecting you can set the password, if you would need to be
mariadb  | able to connect as any of these users with a password and without sudo
mariadb  | 
mariadb  | See the MariaDB Knowledgebase at https://mariadb.com/kb
mariadb  | 
mariadb  | You can start the MariaDB daemon with:
mariadb  | cd '/usr' ; /usr/bin/mariadbd-safe --datadir='/var/lib/mysql'
mariadb  | 
mariadb  | You can test the MariaDB daemon with mariadb-test-run.pl
mariadb  | cd '/usr/mariadb-test' ; perl mariadb-test-run.pl
mariadb  | 
mariadb  | Please report any problems at https://mariadb.org/jira
mariadb  | 
mariadb  | The latest information about MariaDB is available at https://mariadb.org/.
mariadb  | 
mariadb  | Consider joining MariaDB's strong and vibrant community:
mariadb  | https://mariadb.org/get-involved/
mariadb  | 
mariadb  |  [ ok ]
mariadb  | mkdir: can't create directory '/sys/fs/cgroup/openrc.fsck': Read-only file system
mariadb  |  * Checking local filesystems  ... [ ok ]
mariadb  | mkdir: can't create directory '/sys/fs/cgroup/openrc.root': Read-only file system
mariadb  |  * Remounting filesystems ... [ ok ]
mariadb  | mkdir: can't create directory '/sys/fs/cgroup/openrc.localmount': Read-only file system
mariadb  |  * Mounting local filesystems ... [ ok ]
mariadb  | mkdir: can't create directory '/sys/fs/cgroup/openrc.mariadb': Read-only file system
mariadb  | /usr/bin/mysqld_safe: Deprecated program name. It will be removed in a future release, use 'mariadbd-safe' instead
mariadb  |  * Starting mariadb ...250815 07:28:00 mysqld_safe Logging to syslog.
mariadb  | 250815 07:28:00 mysqld_safe Starting mariadbd daemon with databases from /var/lib/mysql
mariadb  |  [ ok ]
mariadb  | Waiting for MariaDB to accept connections...
mariadb  | ✅ MariaDB is ready
mariadb  | Creating database 'wordpress'...
mariadb  | mysql: Deprecated program name. It will be removed in a future release, use '/usr/bin/mariadb' instead
mariadb  | Creating user 'ebinjama'@'localhost'...
mariadb  | mysql: Deprecated program name. It will be removed in a future release, use '/usr/bin/mariadb' instead
mariadb  | mysql: Deprecated program name. It will be removed in a future release, use '/usr/bin/mariadb' instead
mariadb  | Creating user 'ebinjama'@'%'...
mariadb  | mysql: Deprecated program name. It will be removed in a future release, use '/usr/bin/mariadb' instead
mariadb  | mysql: Deprecated program name. It will be removed in a future release, use '/usr/bin/mariadb' instead
mariadb  | Flushing privileges...
mariadb  | mysql: Deprecated program name. It will be removed in a future release, use '/usr/bin/mariadb' instead
mariadb  | Changing root password...
mariadb  | mysql: Deprecated program name. It will be removed in a future release, use '/usr/bin/mariadb' instead
mariadb  | Database setup complete.
mariadb  |  * Stopping mariadb ... [ ok ]
mariadb  | 2025-08-15  7:28:05 0 [Note] Starting MariaDB 11.4.5-MariaDB source revision 0771110266ff5c04216af4bf1243c65f8c67ccf4 server_uid pJNk0z1knGfs39XnqAygXH4wYNg= as process 1
mariadb  | 2025-08-15  7:28:05 0 [Note] InnoDB: Compressed tables use zlib 1.3.1
mariadb  | 2025-08-15  7:28:05 0 [Note] InnoDB: Number of transaction pools: 1
mariadb  | 2025-08-15  7:28:05 0 [Note] InnoDB: Using crc32 + pclmulqdq instructions
mariadb  | 2025-08-15  7:28:05 0 [Note] InnoDB: Using Linux native AIO
mariadb  | 2025-08-15  7:28:05 0 [Note] InnoDB: Initializing buffer pool, total size = 128.000MiB, chunk size = 2.000MiB
mariadb  | 2025-08-15  7:28:05 0 [Note] InnoDB: Completed initialization of buffer pool
mariadb  | 2025-08-15  7:28:05 0 [Note] InnoDB: File system buffers for log disabled (block size=512 bytes)
mariadb  | 2025-08-15  7:28:05 0 [Note] InnoDB: End of log at LSN=47629
mariadb  | 2025-08-15  7:28:05 0 [Note] InnoDB: Opened 3 undo tablespaces
mariadb  | 2025-08-15  7:28:05 0 [Note] InnoDB: 128 rollback segments in 3 undo tablespaces are active.
mariadb  | 2025-08-15  7:28:05 0 [Note] InnoDB: Setting file './ibtmp1' size to 12.000MiB. Physically writing the file full; Please wait ...
mariadb  | 2025-08-15  7:28:05 0 [Note] InnoDB: File './ibtmp1' size is now 12.000MiB.
mariadb  | 2025-08-15  7:28:05 0 [Note] InnoDB: log sequence number 47629; transaction id 14
mariadb  | 2025-08-15  7:28:05 0 [Note] Plugin 'FEEDBACK' is disabled.
mariadb  | 2025-08-15  7:28:05 0 [Note] Plugin 'wsrep-provider' is disabled.
mariadb  | 2025-08-15  7:28:05 0 [Note] InnoDB: Loading buffer pool(s) from /var/lib/mysql/ib_buffer_pool
mariadb  | 2025-08-15  7:28:05 0 [Note] InnoDB: Buffer pool(s) load completed at 250815  7:28:05
mariadb  | 2025-08-15  7:28:06 0 [Note] Server socket created on IP: '0.0.0.0'.
mariadb  | 2025-08-15  7:28:06 0 [Note] mariadbd: Event Scheduler: Loaded 0 events
mariadb  | 2025-08-15  7:28:06 0 [Note] /usr/bin/mariadbd: ready for connections.
mariadb  | Version: '11.4.5-MariaDB'  socket: '/run/mysqld/mysqld.sock'  port: 3306  Alpine Linux
wordpress  | mysql: Deprecated program name. It will be removed in a future release, use '/usr/bin/mariadb' instead
wordpress  | ERROR 2002 (HY000): Can't connect to server on 'mariadb' (115)
wordpress  | mysql: Deprecated program name. It will be removed in a future release, use '/usr/bin/mariadb' instead
```
