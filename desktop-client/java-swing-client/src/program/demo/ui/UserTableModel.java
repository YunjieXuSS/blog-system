package program.demo.ui;

//import program.demo.pojos.Admin;
import program.demo.pojos.User;
import program.demo.pojos.UserList;
import program.demo.pojos.UserListener;

import javax.swing.table.AbstractTableModel;

public class UserTableModel extends AbstractTableModel implements UserListener {
    private final String[] columnNames = {"ID", "Username", "Name", "Email", "DOB", "isAdmin"};
    private UserList users;

    public UserTableModel(UserList userList) {
        this.users = userList;
        userList.addListener(this);
    }

    @Override
    public int getRowCount() {
        return users.size();
    }

    @Override
    public int getColumnCount() {
        return columnNames.length;
    }

    @Override
    public Object getValueAt(int rowIndex, int columnIndex) {
        User user = users.get(rowIndex);
        switch (columnIndex) {
            case 0:
                return user.getUserId();
            case 1:
                return user.getUserName();
            case 2:
                return user.getName();
            case 3:
                return user.getEmail();
            case 4:
                return user.getDateOfBirth();
            case 5:
                return user.getIsAdmin();
            default:
                return null;
        }
    }

    @Override
    public String getColumnName(int column) {
        return columnNames[column];
    }

    @Override
    public void update() {
        fireTableDataChanged();
    }
}