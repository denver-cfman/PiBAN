#!/usr/bin/env bash
mqtt_server=10.0.50.47
echo "Detected new device: $1" >>/var/log/PiBAN.log
/usr/bin/mosquitto_pub -h $mqtt_server -p 1883 -u $CHIPWIPE_USER -P $CHIPWIPE_PASS -t chip/piBAN -m "Detected new device: $1 on chip" || True
devname=$(basename $1)
logname=/tmp/$devname.log
if [ "${ACTION}" = "add" ]
then
    /usr/local/bin/nuke.sh $1 >$logname &
    disown
fi

