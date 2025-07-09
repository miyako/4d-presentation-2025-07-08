//%attributes = {"invisible":true,"preemptive":"capable"}
#DECLARE($port : Integer)

var $server : cs:C1710.TCPConnectionOption
$server:=cs:C1710.Alarm_Server.new($port)

Use (Storage:C1525)
	Storage:C1525[Current method name:C684]:=$server.listener
End use 