#!/bin/bash

# Forked from benkulbertis/cloudflare-update-record.sh
# CHANGE THESE

# API Token (Recommended)                                                                      #####
auth_token="79hYR4P6eWHMEvL2h9zqPrfryq7yzks-MDZ4p5_B"

# Domain and DNS record for synchronization
zone_identifier="99a0a27c47426c8d6224d4061c077e86" # Can be found in the "Overview" tab of your domain
record_name="vyper.0x-sync.xyz"  # Which record you want to be synced

# DO NOT CHANGE LINES BELOW

# SCRIPT START
echo -e "Check Initiated"

# Check for current external network IP
ip=$(curl -s4 https://icanhazip.com/)
if [[ ! -z "${ip}" ]]; then
  echo -e "  > Fetched current external network IP: ${ip}"
else
  >&2 echo -e "Network error, cannot fetch external network IP."
fi

# The execution of update
if [[ ! -z "${auth_token}" ]]; then
  header_auth_paramheader=( -H '"Authorization: Bearer '${auth_token}'"' )
else
  header_auth_paramheader=( -H '"X-Auth-Email: '${auth_email}'"' -H '"X-Auth-Key: '${auth_key}'"' )
fi

# Seek for the record
seek_current_dns_value_cmd=( curl -s -X GET '"https://api.cloudflare.com/client/v4/zones/'${zone_identifier}'/dns_records?name='${record_name}'&type=A"' "${header_auth_paramheader[@]}" -H '"Content-Type: application/json"' )
record=`eval ${seek_current_dns_value_cmd[@]}`

# Can't do anything without the record
if [[ -z "${record}" ]]; then
  >&2 echo -e "Network error, cannot fetch DNS record."
  exit 1
elif [[ "${record}" == *'"count":0'* ]]; then
  >&2 echo -e "Record does not exist, perhaps create one first?"
  exit 1
fi

# Set the record identifier from result
record_identifier=`echo "${record}" | sed 's/.*"id":"//;s/".*//'`

# Set existing IP address from the fetched record
old_ip=`echo "${record}" | sed 's/.*"content":"//;s/".*//'`
echo -e "  > Fetched current DNS record value   : ${old_ip}"

# Compare if they're the same
if [ "${ip}" == "${old_ip}" ]; then
  echo -e "Update for A record '${record_name} (${record_identifier})' cancelled.\\n  Reason: IP has not changed."
  exit 0
else
  echo -e "  > Different IP addresses detected, synchronizing..."
fi

# The secret sause for executing the update
json_data_v4="'"'{"id":"'${zone_identifier}'","type":"A","proxied":true,"name":"'${record_name}'","content":"'${ip}'","ttl":120}'"'"
update_cmd=( curl -s -X PUT '"https://api.cloudflare.com/client/v4/zones/'${zone_identifier}'/dns_records/'${record_identifier}'"' "${header_auth_paramheader[@]}" -H '"Content-Type: application/json"' )

# Execution result
update=`eval ${update_cmd[@]} --data $json_data_v4`

# The moment of truth
case "$update" in
*'"success":true'*)
  echo -e "Update for A record '${record_name} (${record_identifier})' succeeded.\\n  - Old value: ${old_ip}\\n  + New value: ${ip}";;
*)
  >&2 echo -e "Update for A record '${record_name} (${record_identifier})' failed.\\nDUMPING RESULTS:\\n${update}"
  exit 1;;
esac
