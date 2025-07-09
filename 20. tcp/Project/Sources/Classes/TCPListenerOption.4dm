property server : Object

Class constructor($server : cs:C1710.TCPConnectionOption)
	
	This:C1470.server:=$server
	
Function onConnection($listener : 4D:C1709.TCPListener; $event : 4D:C1709.TCPEvent) : Object
	
	return This:C1470.server
	
Function onError($listener : 4D:C1709.TCPListener; $event : 4D:C1709.TCPEvent)
	
Function onTerminate($listener : 4D:C1709.TCPListener; $event : 4D:C1709.TCPEvent)
	
	