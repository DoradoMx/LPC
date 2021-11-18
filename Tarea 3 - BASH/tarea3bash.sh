#!/bin/bash
#
# Ejemplo de Menu en BASH
#
while true ; do 
date
    echo ""
	echo "---------------------------"
    echo "   Menu Principal"
    echo "---------------------------"
    echo "1. Escaneo para detectar equipos activos en la red"
    echo "2. Detectar puertos abiertos en un equipo en particular"
    echo "3. Información del sistema"
    echo "4. Salir"
read -p "Opción  [ 1 - 4 ] " c
case $c in
# INICIO DE LA OPCION 1 DEL MENU Escaneo para detectar equipos activos en la red
        1)
        echo "Esta es la opcion de equipos en la red" 
        which ifconfig && { echo "Comando ifconfig existe...";
					direccion_ip=`ifconfig |grep -w inet |grep -v "127.0.0.1" |awk '{ print $2}'`;
					echo " Esta es tu direccion ip: "$direccion_ip;
					subred=`ifconfig |grep -w inet |grep -v "127.0.0.1" |awk '{ print $2}'|awk -F. '{print $1"."$2"."$3"."}'`;
					echo " Esta es tu subred: "$subred;
					}\
				|| { echo "No existe el comando ifconfig...usando ip ";
					direccion_ip=`ip addr show |grep -w inet | grep -v "127.0.0.1" |awk '{ print $2}'`;
					echo " Esta es tu direccion ip: "$direccion_ip;
					subred=`ip addr show |grep -w inet | grep -v "127.0.0.1" |awk '{ print $2}'|awk -F. '{print $1"."$2"."$3"."}'`;
					echo " Esta es tu subred: "$subred;
					}
	for ip in {1..254}
	do
		ping -q -c 4 ${subred}${ip} > /dev/null
		if [ $? -eq 0 ]
		then
			echo "Host responde: " ${subred}${ip}
		fi
	done
	read -rsp $'Press enter to continue...\n';;
		
# INICIO DE LA OPCION 2 DEL MENU Detectar puertos abiertos en un equipo en particular
        2)
	read -p "Introduce la ip: " ip
	
	#Funcion para escanear puertos
	function portscan {
	#Por optimizar tiempos escanea puertos del 1 al 50
	    for ((counter=1; counter<=50; counter++))
	    do
	        (echo >/dev/tcp/$ip/$counter) > /dev/null 2>&1 && 	echo "$counter open"
	    done
	}
	portscan
	read -rsp $'Press enter to continue...\n';;
# INICIO DE LA OPCION 3 DEL MENU
		3) echo "Tu Username es:"
                whoami
			echo "Tu host es:"
                hostname
		echo "Su sistema operativo es:"
			if type -t wevtutil &> /dev/null
			then
				OS=MSWin
			elif type -t scutil &> /dev/null
			then
				OS=macOS
			else
				OS=Linux
			fi
			echo $OS
			read -rsp $'Press enter to continue...\n';;
        4) echo "Bye!"; exit 0;;
esac
done 