public with sharing class ToolingAPIExample {
	
	private static String baseUrl = URL.getSalesforceBaseUrl().toExternalForm()+ '/services/data/v28.0/tooling/';

	public static void createClass() {
		    // Note the escaping on newlines and quotes
		    String classBody = 'public class MyNewClass {\\n'
		        + ' public string SayHello() {\\n'
		        + '  return \'Hello\';\\n' 
		        + ' }\\n'
		        + '}';
		
		    system.debug('URL :-'+ baseUrl);
		    HTTPRequest req = new HTTPRequest();
		    req.setEndpoint(baseUrl + 'sobjects/ApexClass');
		    req.setMethod('POST');
		    // OAuth header
		    req.setHeader('Authorization', 'Bearer ' + UserInfo.getSessionId());
		    req.setHeader('Content-Type', 'application/json');
		    req.setBody('{'+
		        '"Body" : "' + classBody +'"'+
		    '}');
		
		    Http h = new Http();
		    HttpResponse res = h.send(req);
		    // Response to a create should be 201
		    if (res.getStatusCode() != 201) {
		        System.debug(res.getBody());
		       
		    }
		}

	}