groupadd mysql
useradd -g mysql  -d /usr/local/mysql  -s /sbin/nologin -M  mysql
id mysql
yum install libaio -y
mkdir /opt/mysql/ -pv 
tar zxf mysql-5.7.22-linux-glibc2.12-x86_64.tar.gz  -C /opt/mysql/
ln -s /opt/mysql/mysql-5.7.22-linux-glibc2.12-x86_64 /usr/local/mysql
mkdir /data/mysql/mysql3306/{data,logs,tmp} -pv

chown -R mysql.mysql /usr/local/mysql

chown -R mysql.mysql /data

cp my.cnf  /etc/my.cnf

cd /usr/local/mysql
./bin/mysqld --defaults-file=/etc/my.cnf   --initialize

cp /usr/local/mysql/support-files/mysql.server /etc/init.d/mysqld
 /etc/init.d/mysqld start
echo "export PATH=$PATH:/usr/local/mysql/bin" >> /etc/profile

source /etc/profile

PASSWD=$(grep 'password is' /data/mysql/mysql3306/data/error.log  | awk '{print $NF}')


mysql -uroot -p"$PASSWD" --connect-expired-password -e "alter user user() identified by 'unixfbi';"

mysql -uroot -p'unixfbi' -e "show databases;"

