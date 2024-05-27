package org.example.demo;

public class Instructor {
    public String name;
    public String email;
    public String password;
    public String affiliation;
    public String bio;
    public String yearsOfExperience;
    public String role;

    public Instructor() {
    }

    public Instructor(String name, String email, String password, String affiliation, String bio, String yearsOfExperience, String role) {
        this.name = name;
        this.email = email;
        this.password = password;
        this.affiliation = affiliation;
        this.bio = bio;
        this.yearsOfExperience = yearsOfExperience;
        this.role = role;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getAffiliation() {
        return affiliation;
    }

    public void setAffiliation(String affiliation) {
        this.affiliation = affiliation;
    }

    public String getBio() {
        return bio;
    }

    public void setBio(String bio) {
        this.bio = bio;
    }

    public String getYearsOfExperience() {
        return yearsOfExperience;
    }

    public void setYearsOfExperience(String yearsOfExperience) {
        this.yearsOfExperience = yearsOfExperience;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }
}
