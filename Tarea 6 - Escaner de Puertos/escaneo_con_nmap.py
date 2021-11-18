import nmap 
print ("Este programa revisa el estado en los puertos 21, 22, 25 y 80\n\n")
ports=[21, 22, 25, 80]
#target = '192.168.0.1'
scanner = nmap.PortScanner() 
for i in range(1,255):
    try:
        target="192.168.0.{}".format(i)
        print ("Puertos encontrados para la IP ==> ", target)
        for i in ports: 
            res = scanner.scan(target,str(i)) 
            res = res['scan'][target]['tcp'][i]['state'] 
            print("\t"+f'port {i} is {res}.') 
    except:
        print("\tFalló la busqueda en", target)