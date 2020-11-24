<?php
if ($_REQUEST["status"] == "on" ){
system("bash on.sh"); 
 echo 'On est allumé ! </br> <a href="lumière.php?status=off" target=_self>Eteindre</a> </br>' ;

 echo system("curl 10.202.255.253/status --silent "); 
}
if ($_REQUEST["status"] == "off" ){
system("bash off.sh"); 
 echo 'On est eteint ! </br> <a href="lumière.php?status=on" target=_self>Allumer</a>';

echo system("curl 10.202.255.253/status --silent "); 
}






?>

