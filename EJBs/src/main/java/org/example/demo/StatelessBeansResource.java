package org.example.demo;

import jakarta.ejb.Stateless;
import jakarta.ws.rs.*;
import jakarta.ws.rs.client.Client;
import jakarta.ws.rs.client.ClientBuilder;
import jakarta.ws.rs.core.*;

//@Stateless
@Path("/stateless")
public class StatelessBeansResource {
    @GET
    @Produces("text/plain")
    public String hello() {
        return "Hello, Stateless!";
    }

    @GET
    @Path("/track")
    @Produces(MediaType.APPLICATION_JSON)
    public Response getStudents() {
        // Create a JAX-RS client
        Client client = ClientBuilder.newClient();

        // Make a GET request to the external API
        Response apiResponse = client
                .target("http://localhost:5002/courses/track")
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
