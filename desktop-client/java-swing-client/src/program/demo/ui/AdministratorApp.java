package program.demo.ui;

import program.demo.pojos.User;
import program.demo.pojos.UserList;
import program.demo.web.API;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.util.ArrayList;
import java.util.List;

public class AdministratorApp extends JFrame {
    private JTextField txtUsername;
    private JPasswordField txtPassword;
    private JButton btnLogin;
    private JButton btnLogout;
    private JTable userTable;
    private JButton btnDeleteUser;
    private API api;
    private UserList userList = new UserList(new ArrayList<>());


    public AdministratorApp() {
        api = API.getInstance();
        initUI();
    }

    private void initUI() {
        setTitle("Admin Panel");
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setSize(800, 600);
        setLocationRelativeTo(null);

        JPanel panel = new JPanel(new GridLayout(3, 2));
        panel.add(new JLabel("Username:"));
        txtUsername = new JTextField();
        panel.add(txtUsername);
        panel.add(new JLabel("Password:"));
        txtPassword = new JPasswordField();
        panel.add(txtPassword);

        btnLogin = new JButton("Login");
        btnLogin.addActionListener(this::handleLogin);
        panel.add(btnLogin);

        btnLogout = new JButton("Logout");
        btnLogout.setEnabled(false);
        btnLogout.addActionListener(this::handleLogout);
        panel.add(btnLogout);

        getContentPane().add(panel, BorderLayout.NORTH);

        userTable = new JTable();
        JScrollPane scrollPane = new JScrollPane(userTable);
        getContentPane().add(scrollPane, BorderLayout.CENTER);
        UserTableModel model = new UserTableModel(userList);
        userTable.setModel(model);

        btnDeleteUser = new JButton("Delete User");
        btnDeleteUser.setEnabled(false);
        btnDeleteUser.addActionListener(this::handleDeleteUser);
        getContentPane().add(btnDeleteUser, BorderLayout.SOUTH);

        setVisible(true);
    }

    private void handleLogin(ActionEvent event) {
        String username = txtUsername.getText();
        String password = new String(txtPassword.getPassword());

        SwingWorker<Boolean, Void> worker = new SwingWorker<>() {
            @Override
            protected Boolean doInBackground() throws Exception {
                return api.login(username, password);
            }

            @Override
            protected void done() {
                try {
                    boolean isAdmin = get();
                    if (isAdmin) {
                        btnLogin.setEnabled(false);
                        btnLogout.setEnabled(true);
                        txtUsername.setEnabled(false);
                        txtPassword.setEnabled(false);
                        loadUsers();
                    } else {
                        JOptionPane.showMessageDialog(AdministratorApp.this, "Not authenticated or not an admin!", "Error", JOptionPane.ERROR_MESSAGE);
                        api.logout();
                    }
                } catch (Exception e) {
                    System.out.println(e.getMessage());
                    JOptionPane.showMessageDialog(AdministratorApp.this, "Login failed!", "Error", JOptionPane.ERROR_MESSAGE);
                }
            }
        };
        worker.execute();
    }

    private void handleLogout(ActionEvent event) {
        try {
            api.logout();
            btnLogin.setEnabled(true);
            btnLogout.setEnabled(false);
            txtUsername.setEnabled(true);
            txtPassword.setEnabled(true);
            clearTable();
        } catch (Exception e) {
            JOptionPane.showMessageDialog(this, "Logout failed!", "Error", JOptionPane.ERROR_MESSAGE);
        }
    }

    private void handleDeleteUser(ActionEvent event) {
        int selectedRow = userTable.getSelectedRow();
        if (selectedRow != -1) {
            int userId = (int) userTable.getValueAt(selectedRow, 0);
            btnDeleteUser.setEnabled(false);

            SwingWorker<Void, Void> worker = new SwingWorker<>() {
                @Override
                protected Void doInBackground() throws Exception {
                    api.deleteUser(userId);
                    return null;
                }

                @Override
                protected void done() {
                    try {
                        get();
                        loadUsers();
                        btnDeleteUser.setEnabled(true);
                    } catch (Exception e) {
                        JOptionPane.showMessageDialog(AdministratorApp.this, "Failed to delete user!", "Error", JOptionPane.ERROR_MESSAGE);
                    }
                }
            };
            worker.execute();
        }
    }

    private void loadUsers() {
        SwingWorker<List<User>, Void> worker = new SwingWorker<>() {
            @Override
            protected List<User> doInBackground() throws Exception {
                return api.getUsers();
            }

            @Override
            protected void done() {
                try {
                    userList.setUserList(get());
                    btnDeleteUser.setEnabled(true);
                } catch (Exception e) {
                    JOptionPane.showMessageDialog(AdministratorApp.this, "Failed to load users!", "Error", JOptionPane.ERROR_MESSAGE);
                }
            }
        };
        worker.execute();
    }

    private void clearTable() {
        btnDeleteUser.setEnabled(false);
    }
}


