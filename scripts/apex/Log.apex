Id myId = Id.valueOf('a000E00000AGHywQAH');
String sObjName = myId.getSObjectType().getDescribe().getName();

Log__c log = new Log__c(
    Id = myId,
    Description__c = 'Test',
    Object__c = sObjName,
    Operation__c = null,
    RecordID__c = myId,
    Level__c = 'ERROR'
);

upsert log;

Logger.error('🔴Error🔴 test');
Logger.warn('🟠Warn🟠 test');
Logger.info('🟡Info🟡 test');
Logger.debug('🟢Debug🟢 test');
Logger.trace('🔵Trace🔵 test');
Id jobId = Logger.saveAsync();
System.debug(' ⚡⚡⚡ ' + jobId);

