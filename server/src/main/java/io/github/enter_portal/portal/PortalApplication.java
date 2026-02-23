package io.github.enter_portal.portal;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

/** The entry point of the Portal application. */
@SpringBootApplication
public class PortalApplication {

    /**
     * Main method to start the Spring Boot application.
     *
     * @param args command line arguments
     */
    public static void main(String[] args) {
        SpringApplication.run(PortalApplication.class, args);
    }
}
