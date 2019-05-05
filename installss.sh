#!/bin/bash
#auther:yangjunhui
#environment:centos6.8
rpm -ivh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
########升级系统###############
yum clean all
yum update glibc\* -y
yum update yum\* rpm\* pyth\* -y
yum clean all
yum update mkinitrd nash -y
yum update selinux\* -y
yum update -y
########精简服务###############
chkconfig ip6tables off 
chkconfig iscsi off
chkconfig iscsid off
chkconfig netfs off 
chkconfig auditd off 
chkconfig lvm2-monitor off 
#######安装基础环境##########
yum install -y python-pip python-m2crypto
#######记录命令历史#########
echo 'HISTTIMEFORMAT="%Y-%m-%d %H:%M:%S"' >> /etc/profile
echo "export HISTTIMEFORMAT" >> /etc/profile
source /etc/profile
######调整打开文件限制##########
echo "*   soft   nofile   65535" >> /etc/security/limits.conf
echo "*   hard   nofile   65535" >> /etc/security/limits.conf
sed -i 's/1024/65535/g' /etc/security/limits.d/90-nproc.conf
########安装ss###########
pip install shadowsocks
echo "/usr/bin/python /usr/bin/ssserver -p 443 -k BEGC8e@DeEDs#w -m aes-256-cfb -d start" > /root/ss.sh
chmod +x /root/ss.sh
echo "/root/ss.sh" >> /etc/rc.local
