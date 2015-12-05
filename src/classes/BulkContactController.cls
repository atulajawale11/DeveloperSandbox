public with sharing class BulkContactController {
	ApexPages.StandardSetController setController;
	public List<Contact> contactList {set;get;}
	
	public BulkContactController(ApexPages.StandardSetController controller){
		setController = controller;
		contactList = new List<Contact>();
		contactList.addAll((Contact[])setController.getSelected());
      
	}
	
	
}