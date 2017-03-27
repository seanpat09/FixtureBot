@isTest
public class RequiredFieldsCache{
    private static Integer counter{
        get{
            if (counter == null){
                counter = 0;
            }
            counter++;
            return counter;
        }
        private set;
    }

    public static Map<Schema.SObjectField, Object> getRequiredFieldMappings( Schema.SObjectType typeOfSObject ){
        if( typeOfSObject == Account.sObjectType ){
            return new Map<Schema.SObjectField, Object>{
                Account.Name => 'My Account ' + counter
            };
        }
        else{
            return new Map<Schema.SObjectField, Object>();
        }
    }
}