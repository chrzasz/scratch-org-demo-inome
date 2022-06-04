public with sharing class Logger {
    public static List<Log__c> logCache = new List<Log__c>();
    @TestVisible
    private static final String LOG_LEVEL_ERROR = '🔴ERROR';
    @TestVisible
    private static final String LOG_LEVEL_WARN = '🟠WARN';
    @TestVisible
    private static final String LOG_LEVEL_INFO = '🟡INFO';
    @TestVisible
    private static final String LOG_LEVEL_DEBUG = '🟢DEBUG';
    @TestVisible
    private static final String LOG_LEVEL_TRACE = '🔵TRACE';

    public static void error(String message) {
        log(LOG_LEVEL_ERROR, message);
    }

    public static void error(LogWrapper wrapper) {
        wrapper.level = LOG_LEVEL_ERROR;
        log(wrapper);
    }

    public static void warn(String message) {
        log(LOG_LEVEL_WARN, message);
    }

    public static void warn(LogWrapper wrapper) {
        wrapper.level = LOG_LEVEL_WARN;
        log(wrapper);
    }

    public static void info(String message) {
        log(LOG_LEVEL_INFO, message);
    }

    public static void info(LogWrapper wrapper) {
        wrapper.level = LOG_LEVEL_INFO;
        log(wrapper);
    }

    public static void debug(String message) {
        log(LOG_LEVEL_DEBUG, message);
    }

    public static void debug(LogWrapper wrapper) {
        wrapper.level = LOG_LEVEL_DEBUG;
        log(wrapper);
    }

    public static void trace(String message) {
        log(LOG_LEVEL_TRACE, message);
    }

    public static void trace(LogWrapper wrapper) {
        wrapper.level = LOG_LEVEL_TRACE;
        log(wrapper);
    }

    public static Id saveAsync() {
        Id jobId;
        try {
            jobId = System.enqueueJob(new AsyncSaver(logCache));
        } catch (Exception ex) {
            // Handle silently
        }
        return jobId;
    }

    private static void log(String logLevel, String message) {
        Log__c log = new Log__c();
        log.Level__c = logLevel;
        log.Description__c = message;
        log.TimeStamp__c = System.now();
        logCache.add(log);
    }

    private static void log(LogWrapper wrapper) {
        Log__c log = buildLog(wrapper);
        logCache.add(log);
    }

    private static Log__c buildLog(LogWrapper wrapper) {
        Log__c log = new Log__c();
        mapValues(wrapper, log);
        return log;
    }

    private static void mapValues(LogWrapper wrapper, Log__c log) {
        log.Description__c = getDescription(wrapper);
        log.Object__c = wrapper?.objectName;
        log.Operation__c = wrapper?.operation;
        log.RecordID__c = wrapper?.recordId;
        log.Level__c = wrapper?.level;
        log.TimeStamp__c = System.now();
    }

    private static String getDescription(LogWrapper wrapper) {
        return wrapper?.except != null
            ? wrapper.except.getMessage()
            : wrapper.description;
    }

    public class LogWrapper {
        public String description { get; set; }
        public String objectName { get; set; }
        public String operation { get; set; }
        public Id recordId { get; set; }
        public String level { get; set; }
        public Exception except { get; set; }
    }

    public class AsyncSaver implements Queueable {
        private final List<Log__c> logCache;

        public AsyncSaver(List<Log__c> logCache) {
            this.logCache = logCache;
        }

        public void execute(QueueableContext context) {
            insert logCache;
        }
    }

    public class LoggerException extends Exception {
    }
}
