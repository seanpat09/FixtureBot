@isTest
public class FixtureBot {
    private Schema.SObjectType typeOfSObject;
    private List<SObject> builtRecords = new List<SObject>();
    private Map<Schema.SObjectField, Object> fieldMappings = new Map<Schema.SObjectField, Object>();

    public FixtureBot( Schema.SObjectType typeOfSObject ){
        this.typeOfSObject = typeOfSObject;
    }

    public FixtureBot setFieldMappings( Map<Schema.SObjectField, Object> fieldMappings ){
        this.fieldMappings = fieldMappings;
        return this;
    }

    public FixtureBot make( Integer numToBuild ){
        this.clearRecords();
        for( Integer n = 0; n < numToBuild; n++ ){
            SObject record = buildWithRequiredFields( this.typeOfSObject );
            for( Schema.SObjectField field : fieldMappings.keySet() ){
                record.put( field, fieldMappings.get(field) );
            }
            this.builtRecords.add( record );
        }
        return this;
    }

    public FixtureBot insert(){
        //Only insert records if they exist and we haven't done it already
        if( !this.builtRecords.isEmpty() && this.builtRecords[0].Id == NULL ){
            insert builtRecords;
        }
        return this;
    }

    public List<SObject> deliver(){
        return builtRecords; 
    }

    public FixtureBot clear(){
         this.builtRecords = new List<SObject>();
         return this;
    }

    private SObject buildWithRequiredFields( Schema.SObjectType typeOfSObject ){
        Map<Schema.SObjectField, Object> requiredFieldToValue =
            RequiredFieldsCache.getRequiredFieldMappings( typeOfSObject );
        SObject record = typeOfSObject.newSObject();
        for( Schema.SObjectField field : requiredFieldToValue.keySet() ){
            record.put( field, requiredFieldToValue.get(field) );
        }
        return record;
    }
}