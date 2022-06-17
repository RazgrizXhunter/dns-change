DOMAIN=$1
TARGET_IP=$2

Help()
{
	echo -e "Simple tool to get notified when domain name points to the specified IP."
	echo -e ""
	echo -e "Syntax:"
	echo -e "\tdns-change <Domain> <Target IP>"
	echo -e ""
	echo -e "Options:"
	echo -e "\t-h\tPrints this message."
}

# Get the options
while getopts ":h" option; do
	case $option in
		h) # display Help
			Help
			exit;;
	esac
done

echo "Testing IP: ${TARGET_IP} for domain name: ${DOMAIN}"

while true
do
	CURRENT_IP=$(dig +short ${DOMAIN} | tail -n1)
	TIMESTAMP=$(date)
	if [ "$CURRENT_IP" == "$TARGET_IP" ]; then
		echo -e "${TIMESTAMP}: Fucking finally!. (${CURRENT_IP})"
		echo -en "\007"
	else
		echo -e "${TIMESTAMP}: Not quite yet. (${CURRENT_IP})"
	fi
	sleep 5s
done