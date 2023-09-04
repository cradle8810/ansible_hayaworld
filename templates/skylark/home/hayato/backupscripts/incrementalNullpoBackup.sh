#!/bin/sh

NULLPODIR='/skylark/Nullpo/'
DESTDIR='/backup/Nullpo'
DESTDEVICE='/dev/sdc1'

# マウントされていれば1
ISMOUNT=$(mount | grep "${DESTDEVICE}" | wc -l)

if [ ${ISMOUNT} ]; then
    echo "[ERROR] Device ${DESTDEVICE} does not mount." >&2
    echo "Exit Abnormally." >&2
    exit 1
fi

LINKDEST=`ls -1l ${DESTDIR} | awk '{print $9}' | tr -d '/' | sort -n | tail -1`
TODAY=`date +%Y%m%d_%H%M%S`

if [ -e ${DESTDIR}/sentinel ]; then
    echo "[ERROR] Previous operation is abnormaly finished." >&2
    echo "It may be corrupted hardlinks in ${LINKDEST}." >&2
    echo "Please remove this folder and  ${DESTDIR}sentinel file." >&2
    exit 2
fi

touch ${DESTDIR}/sentinel

echo "rsync -av8  --link-dest=../${LINKDEST}/ ${NULLPODIR} ${DESTDIR}/${TODAY}"
rsync -av8 --link-dest=../${LINKDEST}/ ${NULLPODIR} ${DESTDIR}/${TODAY}

rm ${DESTDIR}/sentinel
