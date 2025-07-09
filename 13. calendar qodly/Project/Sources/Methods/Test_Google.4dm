//%attributes = {}
#DECLARE($params : Object)

If (Count parameters:C259=0)
	
	CALL WORKER:C1389(1; Current method name:C684; {})
	
Else 
	
	var $form : cs:C1710._CalendarForm
	$form:=cs:C1710._CalendarFormGoogle.new()
	var $window : Integer
	$window:=Open form window:C675("Google")
	DIALOG:C40("Google"; $form; *)
	
End if 