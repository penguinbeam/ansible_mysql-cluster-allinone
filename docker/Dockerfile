FROM CENTOS:7
ADD docker.repo /etc/yum.repos.d/docker.repo
#tee /etc/yum.repos.d/docker.repo <<-'EOF'
#[dockerrepo]
#name=Docker Repository
#baseurl=https://yum.dockerproject.org/repo/main/centos/$releasever/
#enabled=1
#gpgcheck=1
#gpgkey=https://yum.dockerproject.org/gpg
#EOF

RUN yum install -y docker-engine
RUN service docker start

RUN yum install -y wget
RUN wget https://dev.mysql.com/get/Downloads/MySQL-Cluster-7.4/MySQL-Cluster-gpl-7.4.10-1.el7.x86_64.rpm-bundle.tar
RUN tar -xvf MySQL-Cluster-gpl-7.4.10-1.el7.x86_64.rpm-bundle.tar
RUN yum install -y perl libnuma net-tools libaio numactl-libs perl-Data-Dumper
RUN groupadd mysql
RUN useradd -g mysql -s /sbin/nologin mysql
RUN rpm -Uhv ./MySQL-Cluster-server-gpl-7.4.10-1.el7.x86_64.rpm
RUN rpm -Uhv ./MySQL-Cluster-client-gpl-7.4.10-1.el7.x86_64.rpm 
RUN mkdir /var/lib/mysql-cluster
RUN chown mysql:mysql /var/lib/mysql-cluster

ADD config.ini /opt/config.ini
#tee config.ini <<-'EOF'
#[ndbd default]
## Options affecting ndbd processes on all data nodes:
#NoOfReplicas=1    # Number of replicas
#DataMemory=150M    # How much memory to allocate for data storage
#IndexMemory=18M   # How much memory to allocate for index storage
#                  # For DataMemory and IndexMemory, we have used the
#                  # default values. Since the "world" database takes up
#                  # only about 500KB, this should be more than enough for
#                  # this example Cluster setup.#
#
#[ndb_mgmd]
#hostname=localhost
#datadir=/var/lib/mysql-cluster
#
#[ndbd]
#hostname=localhost
#NodeId=2
#
#[mysqld]
#NodeId=6
#EOF

ADD my.cnf /etc/my.cnf
#tee /etc/my.cnf <<-'EOF'
#[mysqld]
#ndbcluster
#
#[mysql_cluster]
#EOF

RUN ndb_mgmd -f config.ini 
RUN ndbd
#ndbd --ndb-connectstring="nodeid=2;host=ndb_mgmd.mysql.com:1186"
RUN service mysql start
RUN mysql_secure_installation
