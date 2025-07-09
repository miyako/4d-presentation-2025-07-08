Class extends DataStoreImplementation

exposed Function authentify($user : Text) : Text
	
	Session:C1714.clearPrivileges()
	Session:C1714.setPrivileges("guest")
	
	return "welcome guest "+$user