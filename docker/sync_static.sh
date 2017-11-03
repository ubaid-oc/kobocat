#!/bin/bash
set -e

source /etc/profile

oldpwd=$(pwd)
cd "${KOBOCAT_SRC_DIR}"

mkdir -p "${KOBOCAT_SRC_DIR}/onadata/static"

echo "Collecting static files..."
python manage.py collectstatic -v 0 --noinput
echo "Done"
# Bypassing slow `chown` for Shadi only
#echo "Fixing permissions..."
#chown -R "${UWSGI_USER}" "${KOBOCAT_SRC_DIR}"
#echo "Done."
echo "Syncing to nginx folder..."
rsync -aq ${KOBOCAT_SRC_DIR}/onadata/static/* /srv/static/
echo "Done"

cd $oldpwd
