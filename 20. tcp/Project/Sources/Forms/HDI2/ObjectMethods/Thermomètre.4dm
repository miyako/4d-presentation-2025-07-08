Form:C1466.item:=Form:C1466.thermometer

If (Form:C1466.item.connection=Null:C1517)
	OBJECT SET ENABLED:C1123(*; "ButtonConnect"; True:C214)
	OBJECT SET ENABLED:C1123(*; "ButtonInfo"; False:C215)
	OBJECT SET ENABLED:C1123(*; "ButtonActivate"; False:C215)
	OBJECT SET ENABLED:C1123(*; "ButtonDisconnect"; False:C215)
Else 
	OBJECT SET ENABLED:C1123(*; "ButtonConnect"; False:C215)
	OBJECT SET ENABLED:C1123(*; "ButtonInfo"; True:C214)
	OBJECT SET ENABLED:C1123(*; "ButtonActivate"; True:C214)
	OBJECT SET ENABLED:C1123(*; "ButtonDisconnect"; True:C214)
End if 

OBJECT SET VALUE:C1742("Feuille"; 3)
OBJECT SET VALUE:C1742("Note"; 3)
OBJECT SET VALUE:C1742("Cloche"; 3)
OBJECT SET VALUE:C1742("Thermomètre"; 0)
OBJECT SET VALUE:C1742("Ampoule"; 3)