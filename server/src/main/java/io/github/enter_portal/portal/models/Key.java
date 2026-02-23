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

/** Entity representing the cryptographic keys associated with a user. */
@Entity
@Table(name = "keys")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Key {

    /** Unique identifier for the key record. */
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    @Column(updatable = false, nullable = false)
    private UUID id;

    /** The public key of the user. */
    @NotNull
    @Column(nullable = false, columnDefinition = "TEXT")
    private String publicKey;

    /** The encrypted private key of the user. */
    @NotNull
    @Column(nullable = false, columnDefinition = "TEXT")
    private String encryptedPrivateKey;

    /** The user associated with these keys. */
    @NotNull
    @OneToOne
    @JoinColumn(name = "user_id", nullable = false, unique = true)
    private User user;

    /** The timestamp when the key record was created. */
    @CreationTimestamp
    @Column(nullable = false, updatable = false)
    private LocalDateTime createdAt;

    /** The timestamp when the key record was last updated. */
    @UpdateTimestamp
    @Column(nullable = false)
    private LocalDateTime updatedAt;

    /** The timestamp when the key record was soft-deleted. */
    @Column private LocalDateTime deletedAt;
}
