package org.example.demo;
public class Course {
    public String name;
    public String duration;
    public String category;
    public String rating;
    public String capacity;
    public String createdBy;

    public Course() {
    }

    public Course(String name, String duration, String category, String rating, String capacity, String createdBy) {
        this.name = name;
        this.duration = duration;
        this.category = category;
        this.rating = rating;
        this.capacity = capacity;
        this.createdBy = createdBy;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDuration() {
        return duration;
    }

    public void setDuration(String duration) {
        this.duration = duration;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getRating() {
        return rating;
    }

    public void setRating(String rating) {
        this.rating = rating;
    }

    public String getCapacity() {
        return capacity;
    }

    public void setCapacity(String capacity) {
        this.capacity = capacity;
    }

    public String getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(String createdBy) {
        this.createdBy = createdBy;
    }
}