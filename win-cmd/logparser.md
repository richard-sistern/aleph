# Log Parser

```shell
logparser -i:W3C "select c-ip, REVERSEDNS(c-ip) as hostname, cs-username into c:\temp\ftp-logs.csv from c:\temp\iislogs\*.log where hostname not like '%spammy.com%' and cs-username is not null group by c-ip, cs-username" -e:-1
```
