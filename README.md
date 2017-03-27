# FixtureBot

Fixture bot helps you create test sObject records in Salesforce. It is an improvement upon [SObjectFactory](https://github.com/seanpat09/sobjectfactory), which required a new class for every sObject, even if that sObject didn't have any required fields.



## Usage

```
Map<Schema.SObjectField, Object> mappings = new Map<Schema.SObjectField,Object>{
	Account.Name = 'My account name'
}
FixtureBot bot = new FixtureBot(Account.sObjectType);
bot.setFieldMappings(mappings);
bot.make(30);
List<Account> testAccounts = bot.deliver();

System.assertEquals(30, testAccounts.size() );
for( Account a : testAccounts ){
	System.assertEquals( 'My account name', a.Name );
}
```

Each of the methods (except for `deliver()`) returns the instance so you can chain the commands.

```
Map<Schema.SObjectField, Object> mappings = new Map<Schema.SObjectField,Object>{
	Account.Name = 'My account name'
}
List<Account> testAccounts = new FixtureBot(Account.sObjectType)
	.setFieldMappings(mappings)
	.make(30)
	.deliver();
```

## Required Fields

Just add required field mappings to `RequiredFieldsCache.getRequiredFieldMappings()`. As you add required fields in Salesforce, you only have to update `RequiredFieldsCache.cls` as opposed to updating all of your tests.
