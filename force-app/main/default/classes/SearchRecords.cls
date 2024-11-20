public with sharing class SearchRecords {
  public void searchDevelopRecords() {
    String findWord = 'develop';
    List<List<sObject>> searchList = [
      FIND :findWord
      IN ALL FIELDS
      RETURNING
        Position__c(Position_ID__c, Name WHERE CreatedDate < LAST_N_DAYS:7),
        Candidate__c(Name, Position_Title__c WHERE CreatedDate < LAST_N_DAYS:7),
        Review__c(
          Name,
          Position_Title__c,
          Candidate_Name__c
          WHERE CreatedDate < LAST_N_DAYS:7)
    ];
    Position__c[] searchPositions = (Position__c[]) searchList[0];
    Candidate__c[] searchCandidates = (Candidate__c[]) searchList[1];
    Review__c[] searchReviews = (Review__c[]) searchList[2];
    System.debug('Found the following Position(s): ' + searchPositions);
    System.debug('Found the following Candidate(s): ' + searchCandidates);
    System.debug('Found the following Review(s): ' + searchReviews);
  }
}
