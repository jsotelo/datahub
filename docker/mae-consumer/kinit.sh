{
  echo "addent -password -p ${IDB_USERNAME}@VIASAT.IO -k 1 -e aes256-cts-hmac-sha1-96"
  sleep 0.1
  echo "${IDB_PASSWORD}"
  sleep 0.1
  echo "wkt ${IDB_KEYTAB_PATH}"
  echo "quit"
} |
ktutil