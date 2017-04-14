!#/bin/bash
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
echo "Welcome to Loc Determinater v.0.2"
echo ""
RU (){
read -p "Введите mac-адрес точки доступа":  maca
mac=$(echo -n $maca | sed 's/\://g')
lengh=$(echo -n $mac | wc -c)
if [ "$lengh" = "12" ]; then 
echo ""
curl -i -s -k -X 'POST' -H 'User-Agent: Dalvik/2.1.0 (Linux; U; Android 5.0.1; Nexus 5 Build/LRX22C)' -H 'Content-Type: application/x-www-form-urlencoded' "https://mobile.maps.yandex.net/cellid_location/?clid=1866854&lac=-1&cellid=-1&operatorid=null&countrycode=null&signalstrength=-1&wifinetworks=$mac:-65&app"| grep -E "(HTTP|coordinates)" | sed 's/^[ \t]*//;s/HTTP/HTTP\//;s/coordinates/Координаты:/; s/latitude/Долгота/; s/longitude/Широта/;s/<//;s/>//; s/\///' > coords.txt

cod=$(cat coords.txt | grep -E "(HTTP)" | cut -d " " -f2)

lat=$(cat coords.txt | grep -E "(Координаты:|Долгота|Широта|nlatitude|nlongitude)" | sed 's/Координаты://; s/Долгота=//; s/"//; s/"//; s/Широта=//; s/"//; s/"//; s/nlatitude=//; s/nlongitude=//' | cut -d " "  -f2)

lon=$(cat coords.txt | grep -E "(Координаты:|Долгота|Широта|nlatitude|nlongitude)" | sed 's/Координаты://; s/Долгота=//; s/"//; s/"//; s/Широта=//; s/"//; s/"//; s/nlatitude=//; s/nlongitude=//' | cut -d " "  -f3)
#cat coords.txt
if [[ -s coords.txt && "$cod" = "200" ]]; then
	echo "Координаты найдены. Ищем координаты на карте. Ждите.."

iceweasel "https://www.google.com/search?q=$lat,+$lon"2>/dev/null

else

echo "Координаты не найдены"
sleep 2
fi
rm -rf coords.txt 2>/dev/null
clear
exit
else
echo ""
echo "!!!Ввод должен быть 12 символов!!!"
sleep 2

bash locdet.sh
fi
}
ENG () {
read -p "Enter the MAC address of the access point":  maca
mac=$(echo -n $maca | sed 's/\://g')
lengh=$(echo -n $mac | wc -c)
if [ "$lengh" = "12" ]; then 
echo ""
curl -i -s -k -X 'POST' -H 'User-Agent: Dalvik/2.1.0 (Linux; U; Android 5.0.1; Nexus 5 Build/LRX22C)' -H 'Content-Type: application/x-www-form-urlencoded' "https://mobile.maps.yandex.net/cellid_location/?clid=1866854&lac=-1&cellid=-1&operatorid=null&countrycode=null&signalstrength=-1&wifinetworks=$mac:-65&app"| grep -E "(HTTP|coordinates)" | sed 's/^[ \t]*//;s/HTTP/HTTP\//;s/coordinates/Coordinates:/;s/latitude/Latitude/;s/longitude/Longitude/;s/<//;s/>//; s/\///' > coords.txt

cod=$(cat coords.txt | grep -E "(HTTP)" | cut -d " " -f2)

lat=$(cat coords.txt | grep -E "(Coordinates:|Latitude|Longitude|nlatitude|nlongitude)" | sed 's/Coordinates://; s/Latitude=//; s/"//; s/"//; s/Longitude=//; s/"//; s/"//; s/nlatitude=//; s/nlongitude=//' | cut -d " "  -f2)

lon=$(cat coords.txt | grep -E "(Coordinates:|Latitude|Longitude|nlatitude|nlongitude)" | sed 's/Coordinates://; s/Latitude=//; s/"//; s/"//; s/Longitude=//; s/"//; s/"//; s/nlatitude=//; s/nlongitude=//' | cut -d " "  -f3)
#cat coords.txt
if [[ -s coords.txt && "$cod" = "200" ]]; then

echo "Coordinates found. We are looking for coordinates on the map. Wait.."

iceweasel "https://www.google.com/search?q=$lat,+$lon"2>/dev/null

else

	echo "No coordinates found"
sleep 2
fi

clear
rm -rf coords.txt 2>/dev/null
exit
else
echo ""
echo "!!!Input must be 12 characters!!!"
sleep 2

bash locdet.sh
fi
}
CHECKLANGUAGE
