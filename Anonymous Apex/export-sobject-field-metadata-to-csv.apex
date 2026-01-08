// Replace 'OBJECT_API_NAME' below with the API name of the desired SObject
Map<String, Schema.SObjectField> fieldMap = Schema.SObjectType.OBJECT_API_NAME.fields.getMap();

String csv = 'Label,API Name,Data Type,Nillable (Not Required),Createable,Updateable,Read Only\n';

for (String fieldName : fieldMap.keySet()) {
    Schema.SObjectField field = fieldMap.get(fieldName);
    Schema.DescribeFieldResult dfr = field.getDescribe();
    
    String label = dfr.getLabel().replaceAll(',', ' '); // Remove commas to avoid CSV issues
    String apiName = dfr.getName();
    String dataType = String.valueOf(dfr.getType());
    String nillable = String.valueOf(dfr.isNillable());
    String createable = String.valueOf(dfr.isCreateable());
    String updateable = String.valueOf(dfr.isUpdateable());
    String readOnly = String.valueOf(!dfr.isCreateable() && !dfr.isUpdateable());
    
    csv += label + ',' + apiName + ',' + dataType + ',' + nillable + ',' + createable + ',' + updateable + ',' + readOnly + '\n';
}

System.debug(csv);