package org.example.demo;

import jakarta.ws.rs.ApplicationPath;
import jakarta.ws.rs.core.Application;

import java.util.HashSet;
import java.util.Set;

@ApplicationPath("/api")
public class App extends Application {
    @Override
    public Set<Class<?>> getClasses() {
        Set<Class<?>> classes = new HashSet<>();
        classes.add(StatefulBeansResource.class);
        classes.add(StatelessBeansResource.class);
        classes.add(Course.class);
        classes.add(Instructor.class);
        classes.add(Student.class);
        classes.add(CORSFilter.class);
        return classes;
    }
}