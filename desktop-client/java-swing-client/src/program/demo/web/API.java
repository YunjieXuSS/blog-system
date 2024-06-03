package program.demo.web;

import program.demo.pojos.User;
import program.demo.pojos.LoginResponse;
import program.demo.pojos.UserList;
import program.demo.util.JSONUtils;

import java.io.IOException;
import java.net.CookieManager;
import java.net.HttpCookie;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.net.http.HttpRequest.BodyPublishers;
import java.time.Duration;
import java.util.List;

public class API {
    private static API instance;
    private static final String BASE_URL = "http://localhost:3000/api";
    private final CookieManager cookieManager;
    private final HttpClient client;

    public static API getInstance() {
        if (instance == null) {
            instance = new API();
        }
        return instance;
    }

    private API() {
        this.cookieManager = new CookieManager();
        this.client = HttpClient.newBuilder()
                .version( HttpClient.Version.HTTP_1_1 )
                .followRedirects( HttpClient.Redirect.NEVER )
                .connectTimeout( Duration.ofSeconds( 10 ) )
                .cookieHandler( this.cookieManager )
                .build();
    }

    public User login(String username, String password) throws IOException, InterruptedException {
        String json = String.format( "{\"userName\":\"%s\",\"password\":\"%s\"}", username, password );
        HttpRequest request = HttpRequest.newBuilder()
                .uri( URI.create( BASE_URL + "/user/login" ) )
                .header( "Content-Type", "application/json" )
                .POST( BodyPublishers.ofString( json ) )
                .build();

        HttpResponse<String> response = client.send( request, HttpResponse.BodyHandlers.ofString() );

        if (response.statusCode() == 200) {
            LoginResponse loginResponse = JSONUtils.toObject( response.body(), LoginResponse.class );
            return loginResponse.getUser();
        } else {
            return null;
        }
    }

    public LoginResponse loginReturnResponse(String username, String password) throws IOException, InterruptedException {
        String json = String.format( "{\"userName\":\"%s\",\"password\":\"%s\"}", username, password );
        HttpRequest request = HttpRequest.newBuilder()
                .uri( URI.create( BASE_URL + "/users/" ) )
                .header( "Content-Type", "application/json" )
                .POST( BodyPublishers.ofString( json ) )
                .build();

        HttpResponse<String> response = client.send( request, HttpResponse.BodyHandlers.ofString() );
        LoginResponse loginResponse = JSONUtils.toObject( response.body(), LoginResponse.class );
//        System.out.println( "loginResponse = " + loginResponse );
        return loginResponse;

    }

    public int loginReturnStatusCode(String username, String password) throws IOException, InterruptedException {
        String json = String.format( "{\"userName\":\"%s\",\"password\":\"%s\"}", username, password );
        HttpRequest request = HttpRequest.newBuilder()
                .uri( URI.create( BASE_URL + "/user/login" ) )
                .header( "Content-Type", "application/json" )
                .POST( BodyPublishers.ofString( json ) )
                .build();

        HttpResponse<String> response = client.send( request, HttpResponse.BodyHandlers.ofString() );
        int statusCode = response.statusCode();
//        System.out.println( "loginResponse111 = " + statusCode );
//        System.out.println( "loginResponse.body = " + response.body() );
        return statusCode;

    }

    public void logout() throws IOException, InterruptedException {
        HttpRequest request = HttpRequest.newBuilder()
                .uri( URI.create( BASE_URL + "/user/logout" ) )
                .POST( BodyPublishers.noBody() )
                .build();

        client.send( request, HttpResponse.BodyHandlers.ofString() );
    }

    public List<User> getUsers() throws IOException, InterruptedException {
        HttpRequest request = HttpRequest.newBuilder()
                .uri( URI.create( BASE_URL + "/users" ) )
                .header( "Cookie", getAuthCookieHeader() )
                .GET()
                .build();

        HttpResponse<String> response = client.send( request, HttpResponse.BodyHandlers.ofString() );

        if (response.statusCode() == 200) {
            return JSONUtils.toList( response.body(), User.class );
        } else {
            throw new RuntimeException( "Failed to fetch users: " + response.statusCode() );
        }
    }

    public void deleteUser(int userId) throws IOException, InterruptedException {
        HttpRequest request = HttpRequest.newBuilder()
                .uri( URI.create( BASE_URL + "/user/" + userId ) )
                .header( "Cookie", getAuthCookieHeader() )
                .DELETE()
                .build();

        client.send( request, HttpResponse.BodyHandlers.ofString() );
    }

    private String getAuthCookieHeader() {
        List<HttpCookie> cookies = cookieManager.getCookieStore().getCookies();
        for (HttpCookie cookie : cookies) {
            if ("authToken".equals( cookie.getName() )) {
                return "authToken=" + cookie.getValue();
            }
        }
        return "";
    }
}
