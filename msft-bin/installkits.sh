kitID=scx-1.0.4-234
sourceDir=~/scx-kits/BETA

AIX_LIST="scxaix1"
HP_LIST="scxhpr2"
HP_PRIV_LIST=""
LINUX_LIST="scxcore-rhel50-01 scxcore-suse01"
LINUX_PRIV_LIST=""
SUN_LIST="scxsun14 scxsun12"
SUN_PRIV_LIST=""

#AIX_LIST="scxaix3-1 scxaix1"
#HP_LIST="scxhpr3 scxhpr2"
#HP_PRIV_LIST="root@scxhpvm01 root@scxhpi3"
#LINUX_LIST="scxrhel4-01 scxcore-rhel50-01 scxom64-rhel52-03 \
#	    scxsles9-01 scxcore-suse01 scxom64-sles10-03"
#LINUX_PRIV_LIST="root@scxom64-rhel40-01"
#SUN_LIST="scxsun14 scxsun12 scxcore-solx86-01"
#SUN_PRIV_LIST="root@scxsun01-s8"

for i in $AIX_LIST; do
    echo "Starting host $i ..."
    ssh $i sudo /usr/sbin/installp -u scx.rte
    read -p "Press return:"
done

for i in $HP_LIST; do
    echo "Starting host $i ..."
    ssh $i sudo /usr/sbin/swremove scx
    read -p "Press return:"
done

for i in $HP_PRIV_LIST; do
    echo "Starting host $i ..."
    ssh $i /usr/sbin/swremove scx
    read -p "Press return:"
done

for i in $LINUX_LIST; do
    echo "Starting host $i ..."
    ssh $i sudo /bin/rpm --erase scx
    read -p "Press return:"
done

for i in $LINUX_PRIV_LIST; do
    echo "Starting host $i ..."
    ssh $i /bin/rpm --erase scx
    read -p "Press return:"
done

for i in $SUN_LIST; do
    echo "Starting host $i ..."
    ssh $i /opt/sfw/bin/sudo /usr/sbin/pkgrm MSFTscx
done

for i in $SUN_PRIV_LIST; do
    echo "Starting host $i ..."
    ssh $i /usr/sbin/pkgrm MSFTscx
done

exit
