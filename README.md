### Welcome to NICHER+R project!

#### Prepare to install:

Install Postgresql: [https://www.postgresql.org/download/linux/ubuntu/](https://www.postgresql.org/download/linux/ubuntu/)

After, in terminal
```bash
su postres
psql
```

If password required
```bash
sudo passwd postgres
```

Fix problem with User auth over SSL
```bash
sudo nano /etc/postgresql/10/main/pg_hba.conf
```

Find strings:
```
# "local" is for Unix domain socket connections only
local   all             all                                     peer
# IPv4 local connections:
host    all             all             127.0.0.1/32            md5
```

And change:
```
> # "local" is for Unix domain socket connections only
> local   all             nicher                                     trust
> # IPv4 local connections:
> host    all             nicher             127.0.0.1/32            trust
```

In psql
```sql
CREATE ROLE nicher with createdb login password 'nicher12345678';
\du
\q
```

In terminal
```bash
exit
rake db:create
rake db:migrate
```

Gemfile hidden dependencies
```bash
sudo apt-get install libpq-dev # for pg gem
sudo apt-get install nodejs    # for rails_admin gem
bundle install
```

