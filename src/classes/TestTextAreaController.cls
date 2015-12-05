public with sharing class TestTextAreaController {

	public  Contact con {get;set;}

    // The extension constructor initializes the private member
    // variable mysObject by using the getRecord method from the standard
    // controller.
    public TestTextAreaController(ApexPages.StandardController stdController) {
        stdController.addFields(new List<String>{ 'firstName','description'});
        this.con = (Contact)stdController.getRecord();
    }

    public String getRecordName() {
        return 'Hello ' + (String)con.get('name') + ' (' + (Id)con.get('Id') + ')';
    }

    public PageReference refreshPage(){

        return null;
    }
}