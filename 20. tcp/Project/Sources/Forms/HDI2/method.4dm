var $event : Object
$event:=FORM Event:C1606

Case of 
	: ($event.code=On Load:K2:1)
		
		InitInfo
		
		OBJECT SET VALUE:C1742("Feuille"; 3)
		OBJECT SET VALUE:C1742("Note"; 3)
		OBJECT SET VALUE:C1742("Cloche"; 3)
		OBJECT SET VALUE:C1742("Thermomètre"; 3)
		OBJECT SET VALUE:C1742("Ampoule"; 3)
		
		Form:C1466.lightBulb:=cs:C1710.HouseDevice.new(Form:C1466; 19820)
		Form:C1466.thermometer:=cs:C1710.HouseDevice.new(Form:C1466; 19821)
		Form:C1466.alarm:=cs:C1710.HouseDevice.new(Form:C1466; 19822)
		Form:C1466.music:=cs:C1710.HouseDevice.new(Form:C1466; 19823)
		Form:C1466.plant:=cs:C1710.HouseDevice.new(Form:C1466; 19824)
		
		OBJECT SET ENABLED:C1123(*; "ButtonConnect"; False:C215)
		OBJECT SET ENABLED:C1123(*; "ButtonInfo"; False:C215)
		OBJECT SET ENABLED:C1123(*; "ButtonActivate"; False:C215)
		OBJECT SET ENABLED:C1123(*; "ButtonDisconnect"; False:C215)
		
	: ($event.code=On Unload:K2:2)
		
		Form:C1466.lightBulb.disconnect()
		Form:C1466.thermometer.disconnect()
		Form:C1466.alarm.disconnect()
		Form:C1466.music.disconnect()
		Form:C1466.plant.disconnect()
		
		var $name : Text
		For each ($name; ["4D_Lightbulb_Server"; "4D_Thermometer_Server"; "4D_Alarm_Server"; "4D_Music_Server"; "4D_Plant_Server"])
			CALL WORKER:C1389($name; Formula:C1597(terminateServer))
		End for each 
		
End case 