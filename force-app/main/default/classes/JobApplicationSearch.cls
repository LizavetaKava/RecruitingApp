public with sharing class JobApplicationSearch {
  public List<Job_Application__c> getJobApplications() {
    List<Job_Application__c> jobApp = [
      SELECT
        id,
        Name,
        Candidate__r.Name,
        Position__r.Name,
        (SELECT Id, Name FROM Reviews__r)
      FROM Job_Application__c
      WHERE CreatedDate = LAST_N_DAYS:7 AND Owner.Profile.Name = 'Recruiter'
    ];
    System.debug(jobApp);
    return jobApp;
  }
}
