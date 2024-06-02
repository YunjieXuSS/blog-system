package program.demo.pojos;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;

import java.time.Instant;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;

@JsonIgnoreProperties(ignoreUnknown = true)
public class User {
    private int userId;

    private String userName;

    private String email;

    private String firstName;

    private String lastName;

    private String dateOfBirth;

    private String description;

    private String avatar;

    private boolean isAdmin;
    private static final DateTimeFormatter DATE_FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM-dd");


    public int getUserId() {
        return userId;
    }

    public String getUserName() {
        return userName;
    }

    public String getEmail() {
        return email;
    }

    public String getFirstName() {
        return firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public String getDateOfBirth() {
        if(dateOfBirth.length()!=13)  return dateOfBirth;
        return LocalDate.ofInstant(Instant.ofEpochMilli(Long.parseLong(dateOfBirth)), ZoneId.systemDefault()).format(DATE_FORMATTER);
    }

    public String getDescription() {
        return description;
    }

    public String getAvatar() {
        return avatar;
    }

    public boolean getIsAdmin() {
        return isAdmin;
    }
    public String getName() {
        return firstName + " " + lastName;
    }
    @Override
    public String toString() {
        return "User{" +
                "userId=" + userId +
                ", userName='" + userName + '\'' +
                ", email='" + email + '\'' +
                ", firstName='" + firstName + '\'' +
                ", lastName='" + lastName + '\'' +
                ", dateOfBirth='" + dateOfBirth + '\'' +
                ", description='" + description + '\'' +
                ", avatar='" + avatar + '\'' +
                ", isAdmin=" + isAdmin +
                '}';
    }
}
