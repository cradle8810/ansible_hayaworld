#!/bin/bash

BACKUP_DEST="/backups"
RETENTION_DAYS=14
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
FILENAME="zabbix_db_backup_${TIMESTAMP}.sql.gz"

echo "Starting backup for ${MYSQL_DATABASE}..."

mysqldump \
    --host="$DB_SERVER_HOST" \
    --user="$MYSQL_USER" \
    --password="$MYSQL_PASSWORD" \
    --single-transaction \
    --quick \
    --hex-blob \
    "${MYSQL_DATABASE}" | gzip > "${BACKUP_DEST}/${FILENAME}"

if [ "${PIPESTATUS[0]}" -eq 0 ]; then
    echo "Backup successful: ${FILENAME}"
else
    echo "Backup failed!"
    exit 1
fi

find "${BACKUP_DEST}" -name "zabbix_db_backup_*.sql.gz" -mtime +"${RETENTION_DAYS}" -delete
echo "Cleanup complete."