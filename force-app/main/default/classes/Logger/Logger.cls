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

    public static void warn(String message) {
        log(LOG_LEVEL_WARN, message);
    }

    public static void info(String message) {
        log(LOG_LEVEL_INFO, message);
    }

    public static void debug(String message) {
        log(LOG_LEVEL_DEBUG, message);
    }

    public static void trace(String message) {
        log(LOG_LEVEL_TRACE, message);
    }

    private static void log(String logLevel, String message) {
        Log__c log = new Log__c();
        log.Level__c = logLevel;
        log.Description__c = message;
        logCache.add(log);
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

    public class AsyncSaver implements Queueable {
        private final List<Log__c> logCache;

        public AsyncSaver(List<Log__c> logCache) {
            this.logCache = logCache;
        }

        public void execute(QueueableContext context) {
            insert logCache;
        }
    }
}
