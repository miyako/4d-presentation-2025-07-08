property tokenWait : Integer:=15*60

shared singleton Class constructor()
	
Function getResponse($request : 4D:C1709.IncomingMessage) : 4D:C1709.OutgoingMessage
	
	var $outgoingResponse : 4D:C1709.OutgoingMessage
	$outgoingResponse:=cs:C1710.NetKit.OAuth2Authorization.me.getResponse($request)
	
	If ($request.urlQuery.error#Null:C1517)
		return $outgoingResponse
	End if 
	
	var $state : Text  //the state identifies an oauth provider
	$state:=$request.urlQuery.state
	
	//this is a different session from the connect phase!
	
	var $OAuth2 : Object
	$OAuth2:=Storage:C1525.OAuth2
	
	If ($OAuth2[$state]#Null:C1517)
		
		$OTP:=$OAuth2[$state]
		
		Use ($OAuth2)
			OB REMOVE:C1226($OAuth2; $state)
		End use 
		
		Session:C1714.restore($OTP)
		
		var $provider : cs:C1710.NetKit.OAuth2Provider
		$provider:=cs:C1710.ConnectController.me.provider
		
		var $i : Integer
		For ($i; 1; This:C1470.tokenWait)
			If ($provider.token#Null:C1517)
				break
			End if 
			DELAY PROCESS:C323(Current process:C322; 1)
		End for 
	End if 
	
	return $outgoingResponse