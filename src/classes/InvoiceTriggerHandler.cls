public class InvoiceTriggerHandler 
{
   public static void handleAfterUpdate(Map<Id,Invoice__c> newMap,Map<Id,Invoice__c> oldMap){

        List<Id> invoiceIds = new List<Id>();

        for(Id invoiceId:newMap.keySet()){
            Invoice__c newInvoice = newMap.get(invoiceId);
            Invoice__c oldInvoice = oldMap.get(invoiceId);

            if(newInvoice.status__c == 'Closed' &&  newInvoice.status__c != oldInvoice.status__c ){
                invoiceIds.add(invoiceId);    
            }

        }

        if(invoiceIds.size() > 0){
            HerokuIntegration.postOrder(invoiceIds);
        }

   }
}