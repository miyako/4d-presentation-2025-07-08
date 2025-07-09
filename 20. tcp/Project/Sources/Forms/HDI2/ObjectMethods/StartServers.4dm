If (FORM Event:C1606.code=On Clicked:K2:4)
	
	var $workers : Collection
	$workers:=Process activity:C1495(Processes only:K5:35).processes.query("type = :1"; Worker process:K36:32).extract("name")
	
	If ($workers.indexOf("4D_Lightbulb_Server")=-1)
		CALL WORKER:C1389("4D_Lightbulb_Server"; Formula:C1597(4D_Lightbulb_Server); Form:C1466.lightBulb.port)
	End if 
	
	If ($workers.indexOf("4D_Thermometer_Server")=-1)
		CALL WORKER:C1389("4D_Thermometer_Server"; Formula:C1597(4D_Thermometer_Server); Form:C1466.thermometer.port)
	End if 
	
	If ($workers.indexOf("4D_Alarm_Server")=-1)
		CALL WORKER:C1389("4D_Alarm_Server"; Formula:C1597(4D_Alarm_Server); Form:C1466.alarm.port)
	End if 
	
	If ($workers.indexOf("4D_Music_Server")=-1)
		CALL WORKER:C1389("4D_Music_Server"; Formula:C1597(4D_Music_Server); Form:C1466.music.port)
	End if 
	
	If ($workers.indexOf("4D_Plant_Server")=-1)
		CALL WORKER:C1389("4D_Plant_Server"; Formula:C1597(4D_Plant_Server); Form:C1466.plant.port)
	End if 
	
	//OBJECT SET ENABLED(*; OBJECT Get name; False)
	
End if 