package org.example.demo;

import com.google.gson.Gson;
import jakarta.ejb.Stateful;
import jakarta.ws.rs.*;
import jakarta.ws.rs.client.Client;
import jakarta.ws.rs.client.ClientBuilder;
import jakarta.ws.rs.core.*;
import org.apache.http.HttpEntity;
import org.apache.http.HttpStatus;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpDelete;
import org.apache.http.client.methods.HttpPatch;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;

import java.io.IOException;

@Stateful
@Path("/stateful")
public class StatefulBeansResource {
    @GET
    @Produces("text/plain")
    public String hello() {
        return "Hello, Stateful!";
    }

    @POST
    @Path("/editStudent/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Response editStudent(@PathParam("id") String id, Student student) {
        CloseableHttpClient client = HttpClients.createDefault();
        try {
            String apiUrl = "http://localhost:5001/student/editStudent/" + id;
            HttpPost httpPost = new HttpPost(apiUrl);
            httpPost.addHeader("Content-Type", "application/json");
            String jsonStudent = new Gson().toJson(student);
            StringEntity entity = new StringEntity(jsonStudent);
            httpPost.setEntity(entity);
            CloseableHttpResponse response = client.execute(httpPost);

            int statusCode = response.getStatusLine().getStatusCode();
            HttpEntity responseEntity = response.getEntity();

            if (statusCode == HttpStatus.SC_OK && responseEntity != null) {
                // Extract the response entity
                String responseBody = EntityUtils.toString(responseEntity);

                // Close the response
                response.close();

                // Close the client
                client.close();

                // Return the API response
                return Response.status(Response.Status.OK).entity(responseBody).build();
            } else {
                // Close the response
                response.close();

                // Close the client
                client.close();

                // Return an error response
                return Response.status(statusCode).entity("Failed to post data to API")
                        .build();
            }
        } catch (Exception e) {
            // Close the client
            try {
                client.close();
            } catch (IOException ex) {
                ex.printStackTrace();
            }

            // Return an error response
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR).entity("Internal server error").build();
        }
    }

    @POST
    @Path("/editInstructor/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Response editInstructor(@PathParam("id") String id, Instructor instructor) {
        CloseableHttpClient client = HttpClients.createDefault();

        try {
            // Assuming this is your Node.js API endpoint
            String apiUrl = "http://localhost:5001/instructor/editInstructor/" + id;

            HttpPost httpPost = new HttpPost(apiUrl);
            httpPost.addHeader("Content-Type", "application/json");

            // Convert student object to JSON string
            String jsonInstructor = new Gson().toJson(instructor);

            // Set the request body
            StringEntity entity = new StringEntity(jsonInstructor);
            httpPost.setEntity(entity);

            CloseableHttpResponse response = client.execute(httpPost);

            int statusCode = response.getStatusLine().getStatusCode();
            HttpEntity responseEntity = response.getEntity();

            if (statusCode == HttpStatus.SC_OK && responseEntity != null) {
                // Extract the response entity
                String responseBody = EntityUtils.toString(responseEntity);

                // Close the response
                response.close();

                // Close the client
                client.close();

                // Return the API response
                return Response.status(Response.Status.OK).entity(responseBody).build();
            } else {
                // Close the response
                response.close();

                // Close the client
                client.close();

                // Return an error response
                return Response.status(statusCode).entity("Failed to post data to API").build();
            }
        } catch (Exception e) {
            // Close the client
            try {
                client.close();
            } catch (IOException ex) {
                ex.printStackTrace();
            }

            // Return an error response
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR).entity("Internal server error").build();
        }
    }

    @PATCH
    @Path("/editCourse/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Response editCourse(@PathParam("id") String id, Course course) {
        CloseableHttpClient client = HttpClients.createDefault();

        try {
            // Assuming this is your Node.js API endpoint
            String apiUrl = "http://localhost:5002/courses/editCourse/" + id;

            HttpPatch httpPatch = new HttpPatch(apiUrl);
            httpPatch.addHeader("Content-Type", "application/json");

            // Convert student object to JSON string
            System.out.println(course.name);
            String jsonCourse = new Gson().toJson(course);
            System.out.println(jsonCourse);
            // Set the request body
            StringEntity entity = new StringEntity(jsonCourse);
            System.out.println(entity);
            httpPatch.setEntity(entity);

            CloseableHttpResponse response = client.execute(httpPatch);

            int statusCode = response.getStatusLine().getStatusCode();
            HttpEntity responseEntity = response.getEntity();

            if (statusCode == HttpStatus.SC_OK && responseEntity != null) {
                // Extract the response entity
                String responseBody = EntityUtils.toString(responseEntity);

                // Close the response
                response.close();

                // Close the client
                client.close();

                // Return the API response
                return Response.status(Response.Status.OK).entity(responseBody).build();
            } else {
                // Close the response
                response.close();

                // Close the client
                client.close();

                // Return an error response
                return Response.status(statusCode).entity("Failed to post data to API").build();
            }
        } catch (Exception e) {
            // Close the client
            try {
                client.close();
            } catch (IOException ex) {
                ex.printStackTrace();
            }

            // Return an error response
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR).entity("Internal server error").build();
        }
    }

    @DELETE
    @Path("/removeCourse/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Response removeCourse(@PathParam("id") String id) {
        CloseableHttpClient client = HttpClients.createDefault();

        try {
            // Assuming this is your Node.js API endpoint
            String apiUrl = "http://localhost:5002/courses/deleteCourse/" + id;

            HttpDelete httpDelete = new HttpDelete(apiUrl);
            httpDelete.addHeader("Content-Type", "application/json");

            CloseableHttpResponse response = client.execute(httpDelete);

            int statusCode = response.getStatusLine().getStatusCode();
            HttpEntity responseEntity = response.getEntity();

            if (statusCode == HttpStatus.SC_OK && responseEntity != null) {
                // Extract the response entity
                String responseBody = EntityUtils.toString(responseEntity);

                // Close the response
                response.close();

                // Close the client
                client.close();

                // Return the API response
                return Response.status(Response.Status.OK).entity(responseBody).build();
            } else {
                // Close the response
                response.close();

                // Close the client
                client.close();

                // Return an error response
                return Response.status(statusCode).entity("Failed to post data to API").build();
            }
        } catch (Exception e) {
            // Close the client
            try {
                client.close();
            } catch (IOException ex) {
                ex.printStackTrace();
            }

            // Return an error response
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR).entity("Internal server error").build();
        }
    }

    @PATCH
    @Path("/validateCourse/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public Response validateCourse(@PathParam("id") String id) {
        CloseableHttpClient client = HttpClients.createDefault();

        try {
            // Assuming this is your Node.js API endpoint
            String apiUrl = "http://localhost:5002/courses/validateCourse/" + id;

            HttpPatch httpPatch = new HttpPatch(apiUrl);
            httpPatch.addHeader("Content-Type", "application/json");

            CloseableHttpResponse response = client.execute(httpPatch);

            int statusCode = response.getStatusLine().getStatusCode();
            HttpEntity responseEntity = response.getEntity();

            if (statusCode == HttpStatus.SC_OK && responseEntity != null) {
                // Extract the response entity
                String responseBody = EntityUtils.toString(responseEntity);

                // Close the response
                response.close();

                // Close the client
                client.close();

                // Return the API response
                return Response.status(Response.Status.OK).entity(responseBody).build();
            } else {
                // Close the response
                response.close();

                // Close the client
                client.close();

                // Return an error response
                return Response.status(statusCode).entity("Failed to post data to API").build();
            }
        } catch (Exception e) {
            // Close the client
            try {
                client.close();
            } catch (IOException ex) {
                ex.printStackTrace();
            }

            // Return an error response
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR).entity("Internal server error").build();
        }
    }


    @GET
    @Path("/getStudents")
    @Produces(MediaType.APPLICATION_JSON)
    public Response getStudents() {
        // Create a JAX-RS client
        Client client = ClientBuilder.newClient();

        // Make a GET request to the external API
        Response apiResponse = client
                .target("http://localhost:5001/student")
                .request(MediaType.APPLICATION_JSON)
                .get();

        // Check if the response is successful (status code 200)
        if (apiResponse.getStatus() == Response.Status.OK.getStatusCode()) {
            // Extract the response entity
            Object entity = apiResponse.getEntity();

            // Close the client
            client.close();

            // Return the API response
            return Response
                    .status(Response.Status.OK)
                    .entity(entity)
                    .build();
        } else {
            // Close the client
            client.close();

            // Return an error response
            return Response
                    .status(apiResponse.getStatus())
                    .entity("Failed to fetch data from API")
                    .build();
        }
    }

    @GET
    @Path("/getInstructors")
    @Produces(MediaType.APPLICATION_JSON)
    public Response getInstructors() {
        // Create a JAX-RS client
        Client client = ClientBuilder.newClient();

        // Make a GET request to the external API
        Response apiResponse = client
                .target("http://localhost:5001/instructor/")
                .request(MediaType.APPLICATION_JSON)
                .get();

        // Check if the response is successful (status code 200)
        if (apiResponse.getStatus() == Response.Status.OK.getStatusCode()) {
            // Extract the response entity
            Object entity = apiResponse.getEntity();

            // Close the client
            client.close();

            // Return the API response
            return Response
                    .status(Response.Status.OK)
                    .entity(entity)
                    .build();
        } else {
            // Close the client
            client.close();

            // Return an error response
            return Response
                    .status(apiResponse.getStatus())
                    .entity("Failed to fetch data from API")
                    .build();
        }
    }

    @GET
    @Path("/getCourses")
    @Produces(MediaType.APPLICATION_JSON)
    public Response getCourses() {
        // Create a JAX-RS client
        Client client = ClientBuilder.newClient();

        // Make a GET request to the external API
        Response apiResponse = client
                .target("http://localhost:5002/courses/")
                .request(MediaType.APPLICATION_JSON)
                .get();

        // Check if the response is successful (status code 200)
        if (apiResponse.getStatus() == Response.Status.OK.getStatusCode()) {
            // Extract the response entity
            Object entity = apiResponse.getEntity();

            // Close the client
            client.close();

            // Return the API response
            return Response
                    .status(Response.Status.OK)
                    .entity(entity)
                    .build();
        } else {
            // Close the client
            client.close();

            // Return an error response
            return Response
                    .status(apiResponse.getStatus())
                    .entity("Failed to fetch data from API")
                    .build();
        }
    }

}