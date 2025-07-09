session singleton Class constructor()
	
exposed Function getEvents() : Collection
	
	//use non-shared because the class needs to rewrite itself
	var $myEvents:=This:C1470._getEvents(OB Copy:C1225(cs:C1710.ConnectController.me.provider))
	
	var $calendarEvents:=[]
	
	var $event : Object
	
	For each ($event; $myEvents)
		$calendarEvents.push(This:C1470._createCalendarEvent($event))
	End for each 
	
	return $calendarEvents
	
Function _createCalendarEvent($event : Object) : Object
	
	var $obj:={}
	
	If ($event.start.timeZone="UTC") && ($event.start.dateTime#"@Z")
		$event.start.dateTime+="Z"
	End if 
	
	If ($event.end.timeZone="UTC") && ($event.end.dateTime#"@Z")
		$event.end.dateTime+="Z"
	End if 
	
	$obj.subject:=$event.subject
	$obj.startDate:=String:C10(Date:C102($event.start.dateTime); ISO date:K1:8)
	$obj.startTime:=Time string:C180(Time:C179($event.start.dateTime))
	$obj.endDate:=String:C10(Date:C102($event.end.dateTime); ISO date:K1:8)
	$obj.endTime:=Time string:C180(Time:C179($event.end.dateTime))
	
	return $obj
	
Function _getEvents($OAuth2 : Object) : Collection
	
/***************************************
    Get the default calendar events
***************************************/
	
	// Temporary variable to store fetched events
	var $eventsTmp : Object
	
	// Calculate the start date as Jan 1st of the current year
	var $startDate:=String:C10(Add to date:C393(!00-00-00!; Year of:C25(Current date:C33); 1; 1); ISO date:K1:8)
	// Calculate the end date as 31 days from today
	var $endDate:=String:C10(Current date:C33()+31; ISO date:K1:8)
	
	// Initialize a collection to hold all the retrieved calendar events
	var $events:=[]
	
	// Create an Office365 connection object using the provided OAuth2 token
	var $office365 : Object:=cs:C1710.NetKit.Office365.new($OAuth2)
	
	Try
		// Fetch default calendar events within the specified date range
		$eventsTmp:=$office365.calendar.getEvents({\
			startDateTime: $startDate; \
			endDateTime: $endDate\
			})
	Catch
		
	End try
	
	// If the API call was successful
	If ($eventsTmp.success=True:C214)
		var $last:=False:C215  // Flag to determine if we've reached the last page of results
		
		Repeat 
			// Append the currently fetched events to the full list
			$events.combine($eventsTmp.events)
			
			// Check if we've reached the last page of results
			If ($eventsTmp.isLastPage)
				$last:=True:C214
			Else 
				// Fetch the next page of events
				$eventsTmp.next()
			End if 
			
			// Continue looping until we've fetched all pages or an error occurs
		Until ($last || ($eventsTmp.success=False:C215))
		
	End if 
	
	return $events