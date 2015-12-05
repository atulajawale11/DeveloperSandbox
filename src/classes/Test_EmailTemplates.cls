@isTest
private class Test_EmailTemplates {
	
	@testSetup static void  setupTestData(){
		
		List<EmailTemplate> emailTemplates = new List<EmailTemplate>();

		Folder testEmailFolder = [SELECT Id , Name From Folder WHERE TYPE ='Email' AND developerName ='Test_Email' LIMIT 1];
		for(EmailTemplate emailTemplate : [SELECT Id, isACtive,name from EmailTemplate WHERE isACtive=true AND folderId =:testEmailFolder.Id]){
			emailTemplate.isACtive = false ;
			emailTemplates.add(emailTemplate);
			System.debug('****** emailTemplate In Update'+ emailTemplate.name);
		}



		/*EmailTemplate testEmail = new EmailTemplate();
		testEmail.Body 			= 'Paste the HTML code for your custom HTML email in the box below. Use merge fields to personalize your email content. If the text version of the template is left blank, this version will be stripped of HTML and sent as the text version.';
		testEmail.DeveloperName = 'testEmailInTest';
		testEmail.subject  		= 'Hello There From Test method';
		testEmail.folderId 		= testEmailFolder.Id; 

		emailTemplates.add(testEmail);*/

		try {

			update emailTemplates;
		}catch(Exception exp){
			System.debug('****** ERROR In Update'+ exp.getMessage());
		}

	}

	@isTest static void test_SetupEmail() {
		
		Folder testEmailFolder = [SELECT Id , Name From Folder WHERE TYPE ='Email' AND developerName ='Test_Email' LIMIT 1];
		
		EmailTemplate testEmail = new EmailTemplate();
		testEmail.Body 			= 'Paste the HTML code for your custom HTML email in the box below. Use merge fields to personalize your email content. If the text version of the template is left blank, this version will be stripped of HTML and sent as the text version.';
		testEmail.DeveloperName = 'testEmailInTest';
		testEmail.subject  		= 'Hello There From Test method';
		testEmail.folderId 		= testEmailFolder.Id; 
		testEmail.Name 			= 'testEmailInTest';
		testEmail.TemplateType  = 'text';
		testEmail.isActive 		= true ;
		List<EmailTemplate> emailTemplates = new List<EmailTemplate>();
		emailTemplates.add(testEmail);
		try {
				insert emailTemplates;
			}catch(Exception ex){
				System.debug('****** ERROR IN Insert '+ ex.getMessage());
			}
		emailTemplates = [SELECT Id, isActive from EmailTemplate WHERE isACtive=true AND folderId =:testEmailFolder.Id];	
		System.assertEquals(1, emailTemplates.size());
	}
}