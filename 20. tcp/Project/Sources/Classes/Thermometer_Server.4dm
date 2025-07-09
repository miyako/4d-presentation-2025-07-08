property activated : Boolean
property temperature : Integer

Class extends TCPConnectionOption

Class constructor($port : Integer)
	
	Super:C1705($port)
	
	This:C1470.activated:=False:C215
	This:C1470.temperature:=10
	
Function onData($connection : 4D:C1709.TCPConnection; $event : 4D:C1709.TCPEvent)
	
	var $data : 4D:C1709.Blob
	$data:=$event.data
	
	var $text : Text
	$text:=Convert to text:C1012($data; "utf-8")
	
	If ($text="Information")
		If (This:C1470.activated)
			This:C1470.temperature+=1
		Else 
			This:C1470.temperature-=1
		End if 
		$text:="現在の室温は "+String:C10(This:C1470.temperature)+" 度です。"
		CONVERT FROM TEXT:C1011($text; "utf-8"; $data)
		$connection.send($data)
	Else 
		If ($text="Activate")
			This:C1470.activated:=Not:C34(This:C1470.activated)
		End if 
	End if 