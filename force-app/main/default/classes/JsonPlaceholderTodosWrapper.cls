public with sharing class JsonPlaceholderTodosWrapper {

    public Integer userId;
    public Integer id;
    public String title;
    public Boolean completed;

    public static JsonPlaceholderTodosWrapper parse(String json) {
        return (JsonPlaceholderTodosWrapper) System.JSON.deserialize(json, JsonPlaceholderTodosWrapper.class);
    }

    public static List<JsonPlaceholderTodosWrapper> parseArray(String json) {
        return (List<JsonPlaceholderTodosWrapper>) System.JSON.deserialize(json, List<JsonPlaceholderTodosWrapper>.class);
    }

}
