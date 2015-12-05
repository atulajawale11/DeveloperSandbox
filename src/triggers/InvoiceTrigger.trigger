trigger InvoiceTrigger on Invoice__c (after update) {
	
	if(trigger.isAfter && trigger.isUpdate){
		InvoiceTriggerHandler.handleAfterUpdate(trigger.newMap,trigger.oldMap);
	}
}