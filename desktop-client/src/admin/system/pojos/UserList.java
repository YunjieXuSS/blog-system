package admin.system.pojos;

import java.util.ArrayList;
import java.util.List;

public class UserList {

    private List<User> userList;
    private List<UserListener> listeners = new ArrayList<>();

    public UserList(List<User> userList) {
        this.userList = userList;
    }

    public void setUserList(List<User> userList) {
        this.userList = userList;
        for (UserListener listener : listeners) {
            listener.update();
        }
    }

    public int size() {
        return userList.size();
    }

    public User get(int index) {
        return userList.get(index);
    }

    public int getIndex(User user) {
        return userList.indexOf(user);
    }


    public void addListener(UserListener listener) {
        listeners.add(listener);
    }

    public void removeListener(UserListener listener) {
        listeners.remove(listener);
    }


}