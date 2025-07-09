property activated : Boolean

Class extends TCPConnectionOption

Class constructor($port : Integer)
	
	Super:C1705($port)
	
	This:C1470.activated:=False:C215
	
Function onData($connection : 4D:C1709.TCPConnection; $event : 4D:C1709.TCPEvent)
	
	var $data : 4D:C1709.Blob
	$data:=$event.data
	
	var $text : Text
	$text:=Convert to text:C1012($data; "utf-8")
	
	If ($text="Information")
		If (This:C1470.activated)
			$text:="照明は点灯中です"
		Else 
			$text:="照明は消灯中です"
		End if 
		CONVERT FROM TEXT:C1011($text; "utf-8"; $data)
		$connection.send($data)
	Else 
		If ($text="Activate")
			This:C1470.activated:=Not:C34(This:C1470.activated)
		End if 
	End if 