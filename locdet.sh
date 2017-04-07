!# /bin/bash
CHECKLANGUAGE ()
{
lang=$(locale | grep LANG | cut -d= -f2 | cut -d_ -f1)
if [ "$lang" = "ru" ];
	then RU
		else 
	ENG
fi
}
clear
echo "Welcome to Loc Determinator v.0.1"
echo ""
RU (){
read -p "Введите mac-адрес точки доступа без двоеточия": maca
mac=$(echo -n $maca | sed 's/\://g')
lengh=$(echo -n $mac | wc -c)
if [ "$lengh" = "12" ]; then 
echo ""
curl -i -s -k -X 'POST' -H 'User-Agent: Dalvik/2.1.0 (Linux; U; Android 5.0.1; Nexus 5 Build/LRX22C)' -H 'Content-Type: application/x-www-form-urlencoded' "https://mobile.maps.yandex.net/cellid_location/?clid=1866854&lac=-1&cellid=-1&operatorid=null&countrycode=null&signalstrength=-1&wifinetworks=$mac:-65&app"| grep -E "(HTTP|coordinates)" | sed 's/^[ \t]*//' | sed 's/<//' | sed 's/>//' | sed 's/\///'

else
echo "!!!Ввод должен быть 12 символов!!!"
sleep 2

bash locdet.sh
fi
}
ENG () {
read -p "Enter the MAC address of the access point without colon": maca
mac=$(echo -n $maca | sed 's/\://g')
lengh=$(echo -n $mac | wc -c)
if [ "$lengh" = "12" ]; then 
echo ""
curl -i -s -k -X 'POST' -H 'User-Agent: Dalvik/2.1.0 (Linux; U; Android 5.0.1; Nexus 5 Build/LRX22C)' -H 'Content-Type: application/x-www-form-urlencoded' "https://mobile.maps.yandex.net/cellid_location/?clid=1866854&lac=-1&cellid=-1&operatorid=null&countrycode=null&signalstrength=-1&wifinetworks=$mac:-65&app"| grep -E "(HTTP|coordinates)" | sed 's/^[ \t]*//' | sed 's/<//' | sed 's/>//' | sed 's/\///'

else
echo "!!!Input must be 12 characters!!!"
sleep 2

bash locdet.sh
fi
}
CHECKLANGUAGE
