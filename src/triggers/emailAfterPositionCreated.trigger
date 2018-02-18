trigger emailAfterPositionCreated on Position__c (after insert) {
    
    List<User> usersToEmail = new List<User>();
    Id userId = UserInfo.getUserId();
    User actualUser = [SELECT Id, Name, UserRole.Name FROM User WHERE Id=: userId];
    String actualRole = actualUser.UserRole.Name;
    
    System.debug('Actual Role: ' + actualRole);
    
    List<User> queryContacts = [SELECT Id, Email, UserRole.Name FROM User WHERE UserRole.Name = 'General Director' OR UserRole.Name = 'People Experience'];
    
    for(Position__c pos : Trigger.New){
        for(User u : queryContacts){
            usersToEmail.add(u);
        }
        if(actualRole != 'General Director' && actualRole != 'People Experience'){
            usersToEmail.add(actualUser);
        }
    }
    List<String> emails = new List<String>();
    for(User u : usersToEmail){
        emails.add(u.Email);
    }
    
    if(usersToEmail.size() > 0){
        EmailTemplate et = [SELECT Id FROM EmailTemplate WHERE Name=: 'New Position Created'];
        for(Position__c pos : Trigger.New){
            for(User u : usersToEmail){
                String htmlBody = '<div><p>A new request for position was created with the following details: </p></div>';
                htmlBody += 'Name: ' + pos.Name + '<br>';
                htmlBody += 'Role: ' + pos.Role__c + '<br>';
                htmlBody += 'Seniority: ' + pos.Seniority__c + '<br><br>';
                htmlBody += 'Requirements: <br>' + pos.Requirements__c + '<br><br>';
                htmlBody += 'Requested By: ' + actualUser.Name + '<br>';
                
                Messaging.SingleEmailMessage newMail = new Messaging.SingleEmailMessage();
                newMail.setToAddresses(new String[]{u.Email});
                newMail.setSenderDisplayName('Altimetrik Salesforce');
                newMail.setSaveAsActivity(false);
                newMail.setHtmlBody(htmlBody);
                newMail.setSubject('Altimetrik HHRR: A new request for position was created.');
                Messaging.sendEmail(New Messaging.SingleEmailMessage[] {newMail});
            }
        }
    }

}