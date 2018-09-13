kitID=scx-1.0.5-49
destDir=~/scx-kits

hostlist="scxaix3-1 scxaix1 scxhpi10 scxhpr3 scxhpi1 scxhpr2 \
	  scxcr-mac104-03 scx-mac04 \
	  scxcrd-rhe40-01 scxom64-rhel40-03 \
	  scxcore-rhel50-01 scxom64-rhel52-03 \
	  scxnetra01 scxsun14 scxsun12 scxcore-solx86-01 \
	  scxsles9-03b scxom64-sles10-03"

# Go fetch all the remote kits

for i in $hostlist; do
    scp ${i}:dev/target/*_Debug/${kitID}.* ${destDir}
done

# Special case the local kit

cp -v ~/dev/b/target/*_Debug/${kitID}.* ${destDir}

exit
