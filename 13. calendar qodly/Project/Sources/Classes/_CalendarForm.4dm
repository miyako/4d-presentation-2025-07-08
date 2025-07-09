Class extends _Calendar

Class constructor($type : Text)
	
	Super:C1705($type)
	
Function DisplayCalendarColor($that : Object) : Variant
	
	return $that.backgroundColor || $that.hexColor || Background color none:K23:10
	
Function DisplayDateColor($that : Object) : Variant
	
	If (String:C10($that.displayDate)#"")
		If ($that.displayDate=Current date:C33)
			return "#d72631"
		Else 
			return Background color none:K23:10
		End if 
	Else 
		return Background color none:K23:10
	End if 
	
Function onTokenGet($provider : cs:C1710.NetKit.OAuth2Provider)
	
	Form:C1466.provider:=$provider
	
	Form:C1466.getCalendars()
	
Function onCalendarGet($calendars : Collection)
	
	Form:C1466.calendars:=$calendars
	
	Form:C1466.getEvents(Form:C1466.calendars)
	
Function onEventGet($events : Collection)
	
	Form:C1466.events:=$events
	
Function onError()
	
	
	
Function getEvents($calendars : Collection) : cs:C1710._CalendarForm
	
	var $params : Object
	$params:={provider: This:C1470.provider; window: Current form window:C827; calendars: $calendars; onSuccess: This:C1470.onEventGet; onError: This:C1470.onError}
	CALL WORKER:C1389("OAuth2@"+String:C10(Current form window:C827); This:C1470.GETEVENTS; $params)
	
	return This:C1470
	
Function GETEVENTS($params : Object)
	
Function getCalendars() : cs:C1710._CalendarForm
	
	var $params : Object
	$params:={provider: This:C1470.provider; window: Current form window:C827; onSuccess: This:C1470.onCalendarGet; onError: This:C1470.onError}
	CALL WORKER:C1389("OAuth2@"+String:C10(Current form window:C827); This:C1470.GETCALENDARS; $params)
	
	return This:C1470
	
Function GETCALENDARS($params : Object)
	
Function connect() : cs:C1710._CalendarForm
	
	var $params : Object
	$params:={paramObj: This:C1470.paramObj; window: Current form window:C827; onSuccess: This:C1470.onTokenGet; onError: This:C1470.onError}
	CALL WORKER:C1389("OAuth2@"+String:C10(Current form window:C827); This:C1470.CONNECT; $params)
	
	return This:C1470
	
Function CONNECT($params : Object)
	
	var $provider : cs:C1710.NetKit.OAuth2Provider
	$provider:=cs:C1710.NetKit.OAuth2Provider.new($params.paramObj)
	
	var $OAuth2 : cs:C1710.NetKit.OAuth2Token
	Try
		$OAuth2:=$provider.getToken()
		$provider.token:=$OAuth2.token
		CALL FORM:C1391($params.window; $params.onSuccess; $provider)
	Catch
		CALL FORM:C1391($params.window; $params.onError)
	End try
	
Function onUnload()
	
	KILL WORKER:C1390("OAuth2@"+String:C10(Current form window:C827))