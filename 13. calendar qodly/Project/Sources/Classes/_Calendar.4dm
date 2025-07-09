property paramObj : Object
property provider : cs:C1710.NetKit.OAuth2Provider

shared singleton Class constructor($type : Text)
	
	var $credentials : Object
	$credentials:=ds:C1482.Credentials.query("Type == :1"; $type).first()
	
	ASSERT:C1129($credentials#Null:C1517)
	
	var $paramObj:={}
	
	If (OB Is shared:C1759(This:C1470))
		$paramObj:=OB Copy:C1225($paramObj; ck shared:K85:29)
	End if 
	
	This:C1470.paramObj:=$paramObj
	
	$paramObj.name:=$type
	$paramObj.permission:="signedIn"
	$paramObj.timeout:=120
	$paramObj.accessType:="offline"
	$paramObj.prompt:="select_account"
	$paramObj.clientId:=$credentials.ClientID
	$paramObj.clientSecret:=$credentials.ClientSecret
	$paramObj.redirectURI:="http://127.0.0.1:50993/authorize/"
	$paramObj.browserAutoOpen:=True:C214
	$paramObj.authenticationPage:=Folder:C1567(fk web root folder:K87:15).file("authenticate/authentication_desktop.htm")
	$paramObj.authenticationErrorPage:=Folder:C1567(fk web root folder:K87:15).file("authenticate/error_desktop.htm")
	