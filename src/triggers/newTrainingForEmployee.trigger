trigger newTrainingForEmployee on Project_Team_Member__c (after insert) {
    
    for(Project_Team_Member__c ptm : Trigger.New){
        TrainingController.generateProjectPathTraining(ptm.Project__c, ptm.Employee__c, ptm.Role__c);
	}

}