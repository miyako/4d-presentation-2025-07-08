property connection : 4D:C1709.TCPConnection
property form : Object
property port : Integer

Class constructor($form : Object; $port : Integer)
	
	This:C1470.form:=$form
	This:C1470.connection:=Null:C1517
	This:C1470.port:=$port
	
	// ワーカー内で起動されているサーバーに接続します
Function connect()
	
	This:C1470.connection:=This:C1470.connection=Null:C1517 ? 4D:C1709.TCPConnection.new("localhost"; This:C1470.port; This:C1470) : This:C1470.connection
	
	// サーバーとの接続を解除します
Function disconnect()
	
	If (This:C1470.connection#Null:C1517)
		This:C1470.connection.shutdown()
		This:C1470.connection:=Null:C1517
	End if 
	
	// サーバーにBLOBを送信します。サーバーは常に、ユーザーに表示するテキストを返信します
Function getInfo()
	
	var $blob : Blob
	TEXT TO BLOB:C554("Information"; $blob)
	This:C1470.connection.send($blob)
	
	// デバイスを作動させるためのBLOBをサーバーに送信します
Function activate()
	
	var $blob : Blob
	TEXT TO BLOB:C554("Activate"; $blob)
	This:C1470.connection.send($blob)
	
	// 接続が完了したときに呼び出されるコールバック
Function onConnection($connection : 4D:C1709.TCPConnection; $event : 4D:C1709.TCPEvent)
	
	ALERT:C41("接続に成功しました")
	
	OBJECT SET ENABLED:C1123(*; "ButtonConnect"; False:C215)
	OBJECT SET ENABLED:C1123(*; "ButtonInfo"; True:C214)
	OBJECT SET ENABLED:C1123(*; "ButtonActivate"; True:C214)
	OBJECT SET ENABLED:C1123(*; "ButtonDisconnect"; True:C214)
	
	// 接続が解除されたときに呼び出されるコールバック
Function onShutdown($connection : 4D:C1709.TCPConnection; $event : 4D:C1709.TCPEvent)
	
	ALERT:C41("接続が解除されました")
	
	OBJECT SET ENABLED:C1123(*; "ButtonConnect"; True:C214)
	OBJECT SET ENABLED:C1123(*; "ButtonInfo"; False:C215)
	OBJECT SET ENABLED:C1123(*; "ButtonActivate"; False:C215)
	OBJECT SET ENABLED:C1123(*; "ButtonDisconnect"; False:C215)
	
	// データを受信したときに呼び出されるコールバック。この簡単なサーバーは常に、ユーザーに表示するテキストを返信します
Function onData($connection : 4D:C1709.TCPConnection; $event : 4D:C1709.TCPEvent)
	
	ALERT:C41(BLOB to text:C555($event.data; UTF8 text without length:K22:17))
	
	// 警告：1つのネットワークパケットで必要なデータをすべて受信できる保証はありません。
	// このHDIが複雑になるのを避けるため、すべてのデータが揃っていることを確認していませんが、多くのデータを送信する場合は確認する必要があります。
	
	// 接続が予定外に解除されたときに呼び出されるコールバック
Function onError($connection : 4D:C1709.TCPConnection; $event : 4D:C1709.TCPEvent)
	
	ALERT:C41("接続中にエラーが発生しました")
	
	OBJECT SET ENABLED:C1123(*; "ButtonConnect"; True:C214)
	OBJECT SET ENABLED:C1123(*; "ButtonInfo"; False:C215)
	OBJECT SET ENABLED:C1123(*; "ButtonActivate"; False:C215)
	OBJECT SET ENABLED:C1123(*; "ButtonDisconnect"; False:C215)
	
	This:C1470.connection:=Null:C1517
	
	// TCPConnectionオブジェクトが解放される直前に onShutdown/onError が発生したときに呼び出されるコールバック
Function onTerminate($connection : 4D:C1709.TCPConnection; $event : 4D:C1709.TCPEvent)
	