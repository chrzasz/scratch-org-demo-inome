public with sharing class JsonPlaceholder {
    private static final String URL_USERS = 'https://jsonplaceholder.typicode.com/users/';
    private static final String URL_TODOS = 'https://jsonplaceholder.typicode.com/todos/';
    private static final String GET = 'GET';

    public static JsonPlaceholderUsersWrapper getUserById(String idValue) {
        return JsonPlaceholderUsersWrapper.parse(
            calloutJson(URL_USERS + idValue, GET)
        );
    }

    public static List<JsonPlaceholderUsersWrapper> getAllUsers() {
        return JsonPlaceholderUsersWrapper.parseArray(
            calloutJson(URL_USERS, GET)
        );
    }

    public static JsonPlaceholderTodosWrapper getTodoById(String idValue) {
        return JsonPlaceholderTodosWrapper.parse(
            calloutJson(URL_TODOS + idValue, GET)
        );
    }

    public static List<JsonPlaceholderTodosWrapper> getAllTodos() {
        return JsonPlaceholderTodosWrapper.parseArray(
            calloutJson(URL_TODOS, GET)
        );
    }

    private static String calloutJson(String url, String method) {
        Http httpCallout = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(url);
        request.setMethod(method);
        HttpResponse response = httpCallout.send(request);
        System.debug(
            ' ⚡⚡⚡⚡⚡⚡ ' +
            response.getStatusCode() +
            ' => ' +
            response.getStatus()
        );
        return response.getBody();
    }
}
