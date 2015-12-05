public with sharing class HerokuIntegration {
	
	public class ExternalOrder {
		public String id {get; set;}
		public Integer order_number {get; set;}
	}


	@future (callout=true)
	public static void postOrder(List<Id> invoiceIds){
		JSONGenerator gen = JSON.createGenerator(true);
		gen.writeStartArray();

		for(Id invoiceId : invoiceIds){
			gen.writeStartObject();
			gen.writeStringField('id', invoiceId);
			gen.writeEndObject();
		}

		gen.writeEndArray();
        String jsonOrders = gen.getAsString();
        system.debug('jsonOrders='+jsonOrders);

        HttpRequest req = new HttpRequest();
        req.setMethod('POST');
        req.setEndpoint('https://shielded-river-5372.herokuapp.com/order');
        req.setHeader('Content-Type','application/json');
        req.setBody(jsonOrders);

        Http http = new Http();
        HttpResponse res = http.send(req);

        system.debug('Response Body :'+res.getBody());

        if(res.getStatusCode() != 200){
        	system.debug('Error from '+req.getEndPoint() +' : '+ res.getStatusCode() +'  '+res.getStatus());
        }else{
        	List<Invoice__c> invoices = [SELECT Id from Invoice__c WHERE Id IN : invoiceIds];
        	List<ExternalOrder> orders = (List<ExternalOrder>) JSON.deserialize(res.getBody(), List<ExternalOrder>.class);
        	Map<Id,Invoice__c> invoiceMap = new Map<Id,Invoice__c>(invoices);
        	for(ExternalOrder exOrder:orders){
        		Invoice__c invoice = invoiceMap.get(exOrder.Id);
        		invoice.OrderId__c = String.valueOf(exOrder.order_number);
        	}

        	update invoices;
        }
	}
}