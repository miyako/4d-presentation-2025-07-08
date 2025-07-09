//%attributes = {}
#DECLARE($params : Object)

If (Count parameters:C259=0)
	
	CALL WORKER:C1389(1; Current method name:C684; {})
	
Else 
	
	var $form : cs:C1710._CalendarForm
	$form:=cs:C1710._CalendarFormMicrosoft.new()
	var $window : Integer
	$window:=Open form window:C675("Microsoft")
	DIALOG:C40("Microsoft"; $form; *)
	
End if 