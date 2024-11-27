@isTest
private class PositionListTest {
  @isTest
  private static void createTestData() {
    List<Position__c> positions = new List<Position__c>{
      new Position__c(
        Name = 'Test Position1',
        Status__c = 'Open',
        Location__c = 'World',
        Position_Owner_s_Email__c = 'owner@gmail.com',
        Open_Date__c = Date.today()
      ),
      new Position__c(
        Name = 'Test Position2',
        Status__c = 'Closed',
        Location__c = 'World',
        Position_Owner_s_Email__c = 'owner@gmail.com',
        Open_Date__c = Date.today()
      ),
      new Position__c(
        Name = 'Test Position3',
        Status__c = 'In Progress',
        Location__c = 'World',
        Position_Owner_s_Email__c = 'owner@gmail.com',
        Open_Date__c = Date.today()
      )
    };
    insert positions;

    PositionList controller = new POsitionList();
    controller.loadPositions();
    System.assertEquals(
      3,
      controller.positions.size(),
      'Position list should have 3 items'
    );
  }

  @isTest
  static void testConstructor() {
    createTestData();
    PositionList controller = new PositionList();
    System.assertEquals(
      '',
      controller.filterStatus,
      'FilterStatus should be empty'
    );
    System.assertNotEquals(
      null,
      controller.positions,
      'Positions should not be null'
    );
  }

  @isTest
  static void testLoadPositions() {
    createTestData();
    PositionList controller = new PositionList();
    controller.loadPositions();
    System.assertEquals(
      3,
      controller.positions.size(),
      'Positions list should have 3 items'
    );
  }

  @isTest
  static void testFilterPositions() {
    createTestData();
    PositionList controller = new PositionList();
    controller.filterStatus = 'Open';
    controller.filterPositions();

    System.assertEquals(
      1,
      controller.positions.size(),
      'Position list should have only one item'
    );
    System.assertEquals(
      'Open',
      controller.positions[0].Status__c,
      'Position status should be Open'
    );
  }

  @isTest
  static void testSavePositions() {
    createTestData();
    PositionList controller = new PositionList();
    controller.loadPositions();

    controller.positions[0].Status__c = 'Closed';
    Test.startTest();
    controller.savePositions();
    Test.stopTest();

    Position__c updatePosition = [
      SELECT Status__c
      FROM Position__c
      WHERE Id = :controller.positions[0].Id
    ];
    System.assertEquals(
      'Closed',
      updatePosition.Status__c,
      'Position status should be Closed'
    );
  }

  @isTest
  static void testGetItems() {
    PositionList controller = new PositionList();
    List<SelectOption> items = controller.getItems();

    System.assertEquals(6, items.size(), 'List should have six items');
    System.assertEquals(
      'All positions',
      items[0].getLabel(),
      'The first item should be All positions'
    );
    System.assertEquals(
      'Open',
      items[1].getValue(),
      'The second item should be Open'
    );
  }
}
