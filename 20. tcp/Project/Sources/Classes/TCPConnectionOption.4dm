property listener : 4D:C1709.TCPListener
property noDelay : Boolean

Class constructor($port : Integer)
	
	This:C1470.noDelay:=False:C215
	
	var $server : cs:C1710.TCPListenerOption
	$server:=cs:C1710.TCPListenerOption.new(This:C1470)
	This:C1470.listener:=4D:C1709.TCPListener.new($port; $server)
	
Function onConnection($connection : 4D:C1709.TCPConnection; $event : 4D:C1709.TCPEvent)
	
Function onData($connection : 4D:C1709.TCPConnection; $event : 4D:C1709.TCPEvent)
	
Function onShutdown($connection : 4D:C1709.TCPConnection; $event : 4D:C1709.TCPEvent)
	
Function onError($connection : 4D:C1709.TCPConnection; $event : 4D:C1709.TCPEvent)
	
Function onTerminate($connection : 4D:C1709.TCPConnection; $event : 4D:C1709.TCPEvent)
	