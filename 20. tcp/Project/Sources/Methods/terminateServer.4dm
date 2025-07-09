//%attributes = {"invisible":true,"preemptive":"capable"}
var $name : Text
$name:=Current process name:C1392

If (Storage:C1525[$name]#Null:C1517)
	Storage:C1525[$name].terminate()
	//you must terminate the listener from the process that created it
	//attention
	//if you kill the TCPListener without terminating it
	//you will no longer be able to create a new listener for the same port
	Use (Storage:C1525)
		OB REMOVE:C1226(Storage:C1525; $name)
	End use 
End if 

KILL WORKER:C1390