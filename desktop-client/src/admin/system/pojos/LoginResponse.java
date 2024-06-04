package admin.system.pojos;
public class LoginResponse {

    private User user;
    private String error;

    private int statusCode;

    public User getUser() {
        return user;
    }

    public String getError(){return error;}

    public int getstatusCode(){return statusCode;}
}
