package admin.system.ui;

import admin.system.pojos.User;
import admin.system.pojos.UserList;
import admin.system.web.API;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.geom.Ellipse2D;
import java.awt.image.BufferedImage;
import java.net.MalformedURLException;
import java.net.URL;
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

    // User information panel components
    private JPanel userInfoPanel;
    private JLabel lblUserId;
    private JLabel lblUsername;
    private JLabel lblEmail;
    private JLabel lblFirstName;
    private JLabel lblLastName;
    private JLabel lblDateOfBirth;
    private JLabel lblAvatar;

    private final String IMAGE_URL = "http://localhost:3000";

    public AdministratorApp() {
        api = API.getInstance();
        initUI();
    }

    private void initUI() {
        setTitle("Admin System");
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
        UserTableModel model = new UserTableModel(userList);
        userTable.setModel(model);

        // Add user information panel
        userInfoPanel = new JPanel(new GridBagLayout());
        JScrollPane userInfoScrollPane = new JScrollPane(userInfoPanel);
        userInfoScrollPane.setVerticalScrollBarPolicy(JScrollPane.VERTICAL_SCROLLBAR_ALWAYS);
        userInfoScrollPane.setMinimumSize(new Dimension(200, getHeight()));
        userInfoScrollPane.setPreferredSize(new Dimension(200, getHeight()));
        userInfoScrollPane.setMaximumSize(new Dimension(200, getHeight()));

        GridBagConstraints c = new GridBagConstraints();
        c.gridx = 0;
        c.gridy = 0;
        c.insets = new Insets(5, 5, 5, 5);
        c.fill = GridBagConstraints.HORIZONTAL;

        userInfoPanel.add(new JLabel("Avatar:"), c);
        c.gridy++;
        lblAvatar = new JLabel();
        userInfoPanel.add(lblAvatar, c);

        c.gridy++;
        userInfoPanel.add(new JLabel("User ID:"), c);
        c.gridy++;
        lblUserId = new JLabel();
        userInfoPanel.add(lblUserId, c);

        c.gridy++;
        userInfoPanel.add(new JLabel("Username:"), c);
        c.gridy++;
        lblUsername = new JLabel();
        userInfoPanel.add(lblUsername, c);

        c.gridy++;
        userInfoPanel.add(new JLabel("Email:"), c);
        c.gridy++;
        lblEmail = new JLabel();
        userInfoPanel.add(lblEmail, c);

        c.gridy++;
        userInfoPanel.add(new JLabel("First Name:"), c);
        c.gridy++;
        lblFirstName = new JLabel();
        userInfoPanel.add(lblFirstName, c);

        c.gridy++;
        userInfoPanel.add(new JLabel("Last Name:"), c);
        c.gridy++;
        lblLastName = new JLabel();
        userInfoPanel.add(lblLastName, c);

        c.gridy++;
        userInfoPanel.add(new JLabel("Date of Birth:"), c);
        c.gridy++;
        lblDateOfBirth = new JLabel();
        userInfoPanel.add(lblDateOfBirth, c);

        c.gridy++;
        btnDeleteUser = new JButton("Delete User");
        btnDeleteUser.setEnabled(false);
        btnDeleteUser.addActionListener(this::handleDeleteUser);
        userInfoPanel.add(btnDeleteUser, c);

        JSplitPane splitPane = new JSplitPane(JSplitPane.HORIZONTAL_SPLIT, userInfoScrollPane, scrollPane);
        splitPane.setResizeWeight(0.5); // Initial split: half and half
        getContentPane().add(splitPane, BorderLayout.CENTER);

        setVisible(true);

        // Add table selection listener
        userTable.getSelectionModel().addListSelectionListener(event -> {
            if (!event.getValueIsAdjusting()) {
                displaySelectedUserDetails();
            }
        });
    }

    private void handleLogin(ActionEvent event) {
        String username = txtUsername.getText();
        String password = new String(txtPassword.getPassword());

        SwingWorker<User, Void> worker = new SwingWorker<>() {
            @Override
            protected User doInBackground() throws Exception {
                return api.login(username, password);
            }

            @Override
            protected void done() {
                try {
                    User user = get();
                    if (user == null) {
                        JOptionPane.showMessageDialog(AdministratorApp.this, "Not authenticated! Invalid username or password.", "Error", JOptionPane.ERROR_MESSAGE);
                    } else if (!user.getIsAdmin()) {
                        JOptionPane.showMessageDialog(AdministratorApp.this, "Not an admin!", "Error", JOptionPane.ERROR_MESSAGE);
                        api.logout();
                    } else {
                        btnLogin.setEnabled(false);
                        btnLogout.setEnabled(true);
                        txtUsername.setEnabled(false);
                        txtPassword.setEnabled(false);
                        loadUsers();
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

            // Confirm before deleting the user
            int confirm = JOptionPane.showConfirmDialog(this, "Are you sure you want to delete this user?", "Confirm Delete", JOptionPane.YES_NO_OPTION);
            if (confirm != JOptionPane.YES_OPTION) {
                return;
            }

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
                } catch (Exception e) {
                    JOptionPane.showMessageDialog(AdministratorApp.this, "Failed to load users!", "Error", JOptionPane.ERROR_MESSAGE);
                }
            }
        };
        worker.execute();
    }

    private void clearTable() {
        userList.setUserList(new ArrayList<>());
        // Clear user details panel content
        lblUserId.setText("");
        lblUsername.setText("");
        lblEmail.setText("");
        lblFirstName.setText("");
        lblLastName.setText("");
        lblDateOfBirth.setText("");
        lblAvatar.setIcon(null);
        btnDeleteUser.setEnabled(false);
    }

    private void displaySelectedUserDetails() {
        int selectedRow = userTable.getSelectedRow();
        if (selectedRow != -1) {
            User selectedUser = userList.get(selectedRow);
            lblUserId.setText(String.valueOf(selectedUser.getUserId()));
            lblUsername.setText(selectedUser.getUserName());
            lblEmail.setText(selectedUser.getEmail());
            lblFirstName.setText(selectedUser.getFirstName());
            lblLastName.setText(selectedUser.getLastName());
            lblDateOfBirth.setText(selectedUser.getDateOfBirth());
            if (selectedUser.getAvatar() != null && !selectedUser.getAvatar().isEmpty()) {
                try {
                    URL url = new URL(IMAGE_URL + selectedUser.getAvatar());
                    ImageIcon avatarIcon = new ImageIcon(url);
                    lblAvatar.setIcon(resizeAndCropAvatar(avatarIcon));
                } catch (MalformedURLException e) {
                    e.printStackTrace();
                }
            } else {
                lblAvatar.setIcon(null);
            }
            // Enable or disable delete button based on user type
            btnDeleteUser.setEnabled(!selectedUser.getIsAdmin());
        }
    }

    private ImageIcon resizeAndCropAvatar(ImageIcon icon) {
        Image image = icon.getImage();
        int size = 100;
        BufferedImage bufferedImage = new BufferedImage(size, size, BufferedImage.TYPE_INT_ARGB);
        Graphics2D g2 = bufferedImage.createGraphics();
        g2.setClip(new Ellipse2D.Float(0, 0, size, size));
        g2.drawImage(image, 0, 0, size, size, null);
        g2.dispose();
        return new ImageIcon(bufferedImage);
    }
}
