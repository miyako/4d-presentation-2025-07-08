var $event : Object
$event:=FORM Event:C1606

Case of 
	: ($event.code=On Clicked:K2:4)
		
		Case of 
			: (FORM Get current page:C276=1)
				
				FORM GOTO PAGE:C247(2)
				
			: (FORM Get current page:C276=2)
				
				CANCEL:C270
				
		End case 
		
End case 