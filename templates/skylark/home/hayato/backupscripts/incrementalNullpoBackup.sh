#!/bin/sh

NULLPODIR='/skylark/Nullpo/'
DESTDIR='/backup/Nullpo'
SNAPSHOTSDIR='/backup/snapshots/Nullpo'
EXCLUDEFILE='/home/hayato/backupscripts/Nullpo_exclude.txt'

# マウントされていれば1
ISMOUNT=$(mount | grep "${DESTDEVICE}" | wc -l)

if [ ! ${ISMOUNT} ]; then
    echo "[ERROR] Device ${DESTDEVICE} does not mount." >&2
    echo "Exit Abnormally." >&2
    exit 1
fi

TODAY=$(date +%Y%m%d_%H%M%S)

if [ -e ${DESTDIR}/sentinel ]; then
    echo "[ERROR] Previous operation is abnormaly finished." >&2
    echo "It may be corrupted hardlinks in ${LINKDEST}." >&2
    echo "Please remove this folder and  ${DESTDIR}sentinel file." >&2
    exit 2
fi

# rsync
touch ${DESTDIR}/sentinel
echo "rsync -av8 --delete –-exclude-from=${EXCLUDEFILE} ${NULLPODIR} ${DESTDIR}"
rsync -av8 --delete --exclude-from="${EXCLUDEFILE}" ${NULLPODIR} ${DESTDIR}
RETVAL=$?

if [ ! $RETVAL ]; then
    echo "[ERROR] Some error occured on running rsync." >&2
    exit 3
    # エラー時にはsentinelファイルを消さない
fi

rm ${DESTDIR}/sentinel

# Snapshot 作成
sudo btrfs subvolume snapshot -r "${DESTDIR}" "${SNAPSHOTSDIR}/${TODAY}"
