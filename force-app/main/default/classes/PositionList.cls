public with sharing class PositionList {
  public String filterStatus { get; set; }
  public List<Position__c> positions { get; set; }

  public PositionList() {
    filterStatus = '';
    loadPositions();
  }

  public void loadPositions() {
    String query = 'SELECT Position_ID__c, Name, Status__c, Open_Date__c, Closed_Date__c, Max_Pay__c, Min_Pay__c FROM Position__c ';
    if (String.IsNotBlank(filterStatus)) {
      query += ' WHERE Status__c = :filterStatus';
    }
    positions = Database.query(query);
  }

  public void filterPositions() {
    loadPositions();
  }

  public void savePositions() {
    update positions;
  }

  public List<SelectOption> getItems() {
    List<SelectOption> options = new List<SelectOption>();
    options.add(new SelectOption('', 'All positions'));
    options.add(new SelectOption('Open', 'Open'));
    options.add(new SelectOption('Closed', 'Closed'));
    options.add(
      new SelectOption('Probationary Candidate', 'Probationary Candidates')
    );
    options.add(new SelectOption('In Progress', 'In Progress'));
    options.add(new SelectOption('On Hold', 'On Hold'));
    return options;
  }
}
