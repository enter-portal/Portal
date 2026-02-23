package io.github.enter_portal.portal.models;

import java.time.LocalDateTime;
import java.util.UUID;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

/** Entity representing a user in the system. */
@Entity
@Table(
        name = "users",
        indexes = {@Index(name = "idx_users_active_username", columnList = "deletedAt, username")})
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class User {

    /** Unique identifier for the user. */
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    @Column(updatable = false, nullable = false)
    private UUID id;

    /** The email address of the user. */
    @NotNull
    @Column(unique = true, nullable = false)
    private String email;

    /** The username of the user. */
    @NotNull
    @Column(unique = true, nullable = false, length = 50)
    private String username;

    /** The password of the user (hashed). */
    @NotNull
    @Column(nullable = false)
    private String password;

    /** The timestamp when the user record was created. */
    @CreationTimestamp
    @Column(nullable = false, updatable = false)
    private LocalDateTime createdAt;

    /** The timestamp when the user record was last updated. */
    @UpdateTimestamp
    @Column(nullable = false)
    private LocalDateTime updatedAt;

    /** The timestamp when the user was soft-deleted. */
    @Column private LocalDateTime deletedAt;
}
