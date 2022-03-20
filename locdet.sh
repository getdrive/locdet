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

echo "Welcome to Loc Determinater v.0.5"
echo ""
SYS_ARCH()
{
sys_arch=$(uname -m)
	if [ "$sys_arch" = "x86_64" ]; then
		$PWD/geomac/geomac-x86_64 $mac|awk -F'[|]' '{print $2}'|grep " "|sed s/' '//g >coords
	else
		if [ "$sys_arch" = "i386" ] OR [ "$sys_arch" = "i686" ]; then
			$PWD/geomac/geomac-x86 $mac|awk -F'[|]' '{print $2}'|grep " "|sed s/' '//g > $PWD/coords
	else 
		echo "Программа работает на х86_64 и i386(i686) архитектурах"
		exit
fi
fi
}
RU (){
chmod +x $PWD/geomac/*
read -p "Введите mac-адрес точки доступа: " maca
mac=$(echo -n $maca | sed 's/\://g; s/\-//g; s/[ *]//g')
lengh=$(echo -n $mac | wc -c)
	if [ "$lengh" = "12" ]; then 
				
SYS_ARCH
	else
		echo "!!!Ввод должен быть 12 символов!!!"
		sleep 2
		exit
	fi
lat_lon=$(cat coords| head -n1)
	if [[ -s coords ]]; then
		echo "Координаты найдены. Ищем координаты на карте. Ждите.."
		rm -f coords 2> /dev/null
firefox "https://yandex.ru/maps/?mode=search&text=$lat_lon" 2> /dev/null
	else 
		echo "Координаты не найдены"

sleep 2
clear
exit
fi
}

ENG () {
chmod +x $PWD/geomac/*
read -p "Enter the MAC address of the access point: " maca
mac=$(echo -n $maca | sed 's/\://g; s/\-//g; s/[ *]//g')
lengh=$(echo -n $mac | wc -c)
	if [ "$lengh" = "12" ]; then 
		
SYS_ARCH
	else
		echo "!!!Input must be 12 characters!!!"
		sleep 2
		exit
	fi
lat_lon=$(cat coords| head -n1)
	if [[ -s coords ]]; then
		echo "Coordinates found. Looking for coordinates on the map. Wait for..."
		rm -f coords 2> /dev/null
firefox "https://yandex.ru/maps/?mode=search&text=$lat_lon" 2> /dev/nul

	else
	echo "No coordinates found"
sleep 2
clear
exit
fi
}
CHECKLANGUAGE
