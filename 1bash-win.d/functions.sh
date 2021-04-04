# get rid of git lf warning in windows
function gitlf {
	git config --global core.autocrlf true
}

# whois a domain or a URL
function whois {
	local domain=$(echo "$1" | awk -F/ '{print $3}') # get domain from URL
	if [ -z $domain ] ; then
		domain=$1
	fi
	echo "Getting whois record for: $domain …"

	# avoid recursion
					# this is the best whois server
													# strip extra fluff
	/mingw64/bin/whois.exe $domain whois.internic.net | awk '/Domain Name/,/>>>/' 	
}


function localip {
	local adapter
	adapter=$(netsh interface ipv4 show interface | grep -i eth | awk 'BEGIN {-F$'\t'} ; {print $5}')
	netsh interface ip show addresses $adapter | grep -i ip | grep -Eo '([0-9]*\.){3}[0-9]*'
}

