package program.demo.ui;

import program.demo.pojos.User;
import program.demo.pojos.UserList;
import program.demo.web.API;

import javax.swing.*;
import javax.swing.event.ListSelectionEvent;
import javax.swing.event.ListSelectionListener;
import javax.swing.table.DefaultTableModel;
import java.awt.*;
import java.awt.event.ActionEvent;
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
    private UserList userList = new UserList( new ArrayList<>() );


    JScrollPane scrollPane;
    JPanel userInfoPanel;
    JScrollPane userInfoScrollPane;
    private JLabel imgUserInfo;
    private JLabel userIDTextField;
    private JLabel usernameTextField;
    private JLabel emailTextField;
    private JLabel firstNameTextField;
    private JLabel lastNameTextField;
    private JLabel dateOfBirthTextField;
    private JTextArea descriptionTextField;
    private final ImageIcon defaultImage;
    private final ImageIcon noImage;
    //    private final String IMAGE_URL = "http://localhost:3000/images/";
    private final String IMAGE_URL = "http://localhost:3000";
//    http://localhost:3000/images/img26.jpg

    private JTable userInfoTable;

    boolean islogin;
    boolean isAdmin;


    public AdministratorApp() {
        islogin =false;
        isAdmin = false;
        api = API.getInstance();
        ImageIcon defaultUserIcon = new ImageIcon(
                getClass().getResource( "/program/demo/ui/userDefaultIcon.png" ) );
        //resize the user's avatar image
        this.defaultImage = resizeUserAvatar( defaultUserIcon );
        this.noImage = resizeUserAvatar( new ImageIcon(
                getClass().getResource( "/program/demo/ui/no_image.jpg" ) ) );
        initUI();
    }

    private void initUI() {
        setTitle( "Admin Panel" );
        setDefaultCloseOperation( JFrame.EXIT_ON_CLOSE );
        setSize( 1024, 768 );
        setLocationRelativeTo( null );

        JPanel panel = new JPanel( new GridLayout( 3, 2 ) );
        panel.add( new JLabel( "Username:" ) );
        txtUsername = new JTextField();
        panel.add( txtUsername );
        panel.add( new JLabel( "Password:" ) );
        txtPassword = new JPasswordField();
        panel.add( txtPassword );

        btnLogin = new JButton( "Login" );
        btnLogin.addActionListener( this::handleLogin );
        panel.add( btnLogin );

        btnLogout = new JButton( "Logout" );
        btnLogout.setEnabled( false );
        btnLogout.addActionListener( this::handleLogout );
        panel.add( btnLogout );

        getContentPane().add( panel, BorderLayout.NORTH );
        setVisible( true );
    }

    private void handleLogin(ActionEvent event) {
        String username = txtUsername.getText();
        String password = new String( txtPassword.getPassword() );

        SwingWorker<Integer, Void> worker = new SwingWorker<>() {
            @Override
            protected Integer doInBackground() throws Exception {
                return api.loginReturnStatusCode( username, password );
            }

            @Override
            protected void done() {
                try {
                    int statusCode = get();
                    if (statusCode == 200) {
                        SwingWorker<Boolean, Void> adminWorker = new SwingWorker<>() {
                            @Override
                            protected Boolean doInBackground() throws Exception {
                                return api.login(username, password);
                            }

                            @Override
                            protected void done() {
                                try {
                                    boolean result = get();
                                    isAdmin = result;
                                    if (!isAdmin) {
                                        JOptionPane.showMessageDialog(AdministratorApp.this, "You are not an admin and are not authorised to edit.\nSystem will automatically logout.", "Error", JOptionPane.ERROR_MESSAGE);
                                        api.logout();
                                    } else {
                                        JOptionPane.showMessageDialog(AdministratorApp.this, "login successfully.\nStart to load the users' information.", "Information", JOptionPane.INFORMATION_MESSAGE);
                                        islogin = true;
                                        initalUserInfoPanel();
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
                        adminWorker.execute();
                    } else if (statusCode == 401) {
                        JOptionPane.showMessageDialog(AdministratorApp.this, "Invalid username or password.\nPlease try again.", "Error", JOptionPane.ERROR_MESSAGE);
                        api.logout();
                    } else if (statusCode == 422) {
                        JOptionPane.showMessageDialog(AdministratorApp.this, "Username and password are required.\nPlease try again.", "Error", JOptionPane.ERROR_MESSAGE);
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

    private void handleIsAdmin() {
        String username = txtUsername.getText();
        String password = new String( txtPassword.getPassword() );

        SwingWorker<Boolean, Void> worker = new SwingWorker<>() {
            @Override
            protected Boolean doInBackground() throws Exception {
                return api.login( username, password );
            }

            @Override
            protected void done() {
                try {
                    boolean result = get();
                    isAdmin = result;
                } catch (Exception e) {
                    System.out.println( e.getMessage() );
                    JOptionPane.showMessageDialog( AdministratorApp.this, "Login failed!", "Error", JOptionPane.ERROR_MESSAGE );
                }
            }
        };
        worker.execute();
    }


    private void handleLogout(ActionEvent event) {
        try {
            api.logout();
            btnLogin.setEnabled( true );
            btnLogout.setEnabled( false );
            txtUsername.setEnabled( true );
            txtPassword.setEnabled( true );

            //clean  userInfoPanel data
            userInfoPanel.removeAll();
            userInfoPanel.repaint();
            userInfoPanel.revalidate();
            clearTable();
        } catch (Exception e) {
            JOptionPane.showMessageDialog( this, "Logout failed!", "Error", JOptionPane.ERROR_MESSAGE );
        }
    }

    private void handleDeleteUser(ActionEvent event) {
        int selectedRow = userTable.getSelectedRow();
        if (selectedRow != -1) {
            int userId = (int) userTable.getValueAt( selectedRow, 0 );
            boolean userIsAdmin = (boolean) userTable.getValueAt( selectedRow, 5 );
            System.out.println( "userIsAdmin = " + userIsAdmin );
            btnDeleteUser.setEnabled( false );
            SwingWorker<Void, Void> worker = new SwingWorker<>() {
                @Override
                protected Void doInBackground() throws Exception {
                    if (!userIsAdmin) {
                        api.deleteUser( userId );
                    } else {
                        JOptionPane.showMessageDialog( AdministratorApp.this, "Admin accounts cannot be deleted!\nPlease contact your manager if you need support.", "Error", JOptionPane.ERROR_MESSAGE );
                    }
                    return null;
                }

                @Override
                protected void done() {
                    try {
                        get();
                        loadUsers();
                    } catch (Exception e) {
                        JOptionPane.showMessageDialog( AdministratorApp.this, "Failed to delete user!", "Error", JOptionPane.ERROR_MESSAGE );
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
                    userList.setUserList( get() );
                } catch (Exception e) {
                    JOptionPane.showMessageDialog( AdministratorApp.this, "Failed to load users!", "Error", JOptionPane.ERROR_MESSAGE );
                }
            }
        };
        worker.execute();
    }

    private void clearTable() {
        scrollPane.removeAll();
        scrollPane.repaint();
        btnDeleteUser.setEnabled( false );
    }

    private ImageIcon resizeUserAvatar(ImageIcon icon) {
        //get actual image
        Image image = icon.getImage();
        //resize the image
        return new ImageIcon( image.getScaledInstance( 100, 100, Image.SCALE_SMOOTH ) );
    }

    private void displayUserInfo(User user) {
        if (user.getAvatar() != null && !user.getAvatar().isEmpty()) {
            try {
                ImageIcon userAvatar = new ImageIcon( new URL( IMAGE_URL + user.getAvatar() ) );
                userAvatar = resizeUserAvatar( userAvatar );
                imgUserInfo.setIcon( userAvatar );
            } catch (MalformedURLException e) {
                e.printStackTrace();
            }
        } else {
            imgUserInfo.setIcon( noImage );
        }
        userIDTextField.setText( String.valueOf( user.getUserId() ) );
        usernameTextField.setText( user.getUserName() );
        emailTextField.setText( user.getEmail() );
        firstNameTextField.setText( user.getFirstName() );
        lastNameTextField.setText( user.getLastName() );
        dateOfBirthTextField.setText( user.getDateOfBirth() );
        descriptionTextField.setText( user.getDescription() );

        // Ensure the scroll pane is reset to the top when user info is displayed
        SwingUtilities.invokeLater(() -> userInfoScrollPane.getVerticalScrollBar().setValue(0));
    }

    private void clearUserInfo() {

        userIDTextField.setText( "" );
        usernameTextField.setText( "" );
        emailTextField.setText( "" );
        firstNameTextField.setText( "" );
        lastNameTextField.setText( "" );
        dateOfBirthTextField.setText( "" );
        descriptionTextField.setText( "" );
        imgUserInfo.setIcon( this.defaultImage );
    }

    private void addUserInfoField(JPanel panel, String label, JComponent field, GridBagConstraints c) {
        c.gridy++;
        c.gridx = 0;
        panel.add( new JLabel( label ), c );
        c.gridx = 1;
        panel.add( field, c );
    }


    private class UserTableSelectionListener implements ListSelectionListener {
        @Override
        public void valueChanged(ListSelectionEvent event) {
            handleUserTableSelection( event );
        }
    }


    private void handleUserTableSelection(ListSelectionEvent event) {
        System.out.println( userList );
        if (event.getValueIsAdjusting()) {
            return;
        }
        int selectedRow = userTable.getSelectedRow();
        if (selectedRow == -1) {
            return;
        }
        User selectedUser = userList.get( selectedRow );
        System.out.println("isAdmin777: "+isAdmin);
        System.out.println("selectedUser: "+selectedUser);
        if(!selectedUser.getIsAdmin()) {
            btnDeleteUser.setEnabled( true );
        }
        displayUserInfo( selectedUser );
    }

    private void initalUserInfoPanel(){

        //Add userInfoPanel
        userInfoPanel = new JPanel( new GridBagLayout() );

        // Add userInfoPanel to JScrollPane
        userInfoScrollPane = new JScrollPane(userInfoPanel);
        userInfoScrollPane.setVerticalScrollBarPolicy(JScrollPane.VERTICAL_SCROLLBAR_ALWAYS);
        getContentPane().add(userInfoScrollPane, BorderLayout.WEST);
        userInfoScrollPane.setPreferredSize( new Dimension( 350, getHeight() ) );

        //user avatar's layout
        imgUserInfo = new JLabel();
        imgUserInfo.setIcon( this.defaultImage ); // NOI18N
        imgUserInfo.setBorder( BorderFactory.createLineBorder( null, 0 ) );

        GridBagConstraints c = new GridBagConstraints();
        c.gridx = 0;
        c.gridy = 0;
        c.insets = new Insets( 5, 5, 5, 5 );
        c.fill = GridBagConstraints.HORIZONTAL;
        userInfoPanel.add( new JLabel( "User Info:" ), c );

        c.gridy++;
        c.gridx = 1;
        userInfoPanel.add( imgUserInfo, c );

        // Add new rows for user information
        addUserInfoField( userInfoPanel, "User Id:", userIDTextField = new JLabel(), c );
        addUserInfoField( userInfoPanel, "User name:", usernameTextField = new JLabel(), c );
        addUserInfoField( userInfoPanel, "Email:", emailTextField = new JLabel(), c );
        addUserInfoField( userInfoPanel, "First Name:", firstNameTextField = new JLabel(), c );
        addUserInfoField( userInfoPanel, "Last Name:", lastNameTextField = new JLabel(), c );
        addUserInfoField( userInfoPanel, "Date of Birth:", dateOfBirthTextField = new JLabel(), c );
        addUserInfoField( userInfoPanel, "Description:", descriptionTextField = new JTextArea( 3, 0 ), c );
        descriptionTextField.setLineWrap( true );
        descriptionTextField.setEditable( false );
        descriptionTextField.setFocusable( false );
        descriptionTextField.setOpaque( false );
        descriptionTextField.setWrapStyleWord( true );
        descriptionTextField.setLineWrap( true );


        userTable = new JTable();

        //Add table listener
        ListSelectionModel selectionModel = userTable.getSelectionModel();
        selectionModel.addListSelectionListener( new UserTableSelectionListener() );


        scrollPane = new JScrollPane( userTable );
        getContentPane().add( scrollPane, BorderLayout.CENTER );
        scrollPane.setPreferredSize( new Dimension( 600, getHeight() ) );
        UserTableModel model = new UserTableModel( userList );
        userTable.setModel( model );

        btnDeleteUser = new JButton( "Delete User" );
        btnDeleteUser.setEnabled( false );
        btnDeleteUser.setSize( 45,30 );
        btnDeleteUser.addActionListener( this::handleDeleteUser );


        //Add button in userinfo panel
        c.gridy++;
        userInfoPanel.add( btnDeleteUser, c );

        setVisible( true );

        // Ensure the scroll pane is set to the top when it initialized
        SwingUtilities.invokeLater(() -> userInfoScrollPane.getVerticalScrollBar().setValue(0));
    }

}


