Class extends _CalendarMicrosoft

session singleton Class constructor()
	
	Super:C1705()
	
	This:C1470.paramObj.timeout:=300
	This:C1470.paramObj.browserAutoOpen:=False:C215
	This:C1470.paramObj.redirectURI:="http://127.0.0.1/authorize/"  //handle in host
	This:C1470.paramObj.authenticationPage:=Folder:C1567(fk web root folder:K87:15).file("authenticate/QodlyAuthentication.htm")
	This:C1470.paramObj.authenticationErrorPage:=Folder:C1567(fk web root folder:K87:15).file("authenticate/QodlyError.htm")
	
	var $provider : cs:C1710.NetKit.OAuth2Provider
	$provider:=cs:C1710.NetKit.OAuth2Provider.new(This:C1470.paramObj)
	This:C1470.provider:=OB Copy:C1225($provider; ck shared:K85:29; This:C1470)
	
exposed Function getUri() : Text
	
	var $state : Text  //the state identifies an oauth provider
	//%W-550.26
	$state:=This:C1470.provider._state
	//%W+550.26
	
	Use (Storage:C1525)
		Storage:C1525.OAuth2:=New shared object:C1526($state; Session:C1714.createOTP())
	End use 
	
	return This:C1470.provider.authenticateURI
	
exposed Function getTokenAsync() : Boolean
	
	Use (This:C1470.provider)
		OB REMOVE:C1226(This:C1470.provider; "token")
	End use 
	
	CALL WORKER:C1389("OAuth2"+Session:C1714.id; This:C1470.GETTOKEN; This:C1470.provider)
	
	return True:C214
	
Function GETTOKEN($provider : cs:C1710.NetKit.OAuth2Provider)
	
	var $connected : Boolean
	var $OAuth2 : cs:C1710.NetKit.OAuth2Token
	
	Try
		//use non-shared because the class needs to rewrite itself
		$OAuth2:=OB Copy:C1225($provider).getToken()
		$connected:=True:C214
	Catch
		$connected:=False:C215
	End try
	
	If ($connected)
		Use ($provider)
			$provider.token:=OB Copy:C1225($OAuth2.token; ck shared:K85:29)
		End use 
	End if 