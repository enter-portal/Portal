package io.github.enter_portal.portal.models;

import java.time.LocalDateTime;
import java.util.UUID;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import io.github.enter_portal.portal.enums.StorageType;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

/** Entity representing a file stored in the system. */
@Entity
@Table(name = "files")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class File {

    /** Unique identifier for the file. */
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    @Column(updatable = false, nullable = false)
    private UUID id;

    /** The name of the file. */
    @NotNull
    @Column(nullable = false)
    private String fileName;

    /** The MIME type of the file. */
    @NotNull
    @Column(nullable = false, length = 100)
    private String mimeType;

    /** The size of the file in bytes. */
    @NotNull
    @Column(nullable = false)
    private Long size;

    /** The location or path where the file is stored. */
    @NotNull
    @Column(nullable = false, length = 500)
    private String location;

    /** The type of storage used for the file (e.g., LOCAL, S3). */
    @NotNull
    @Column(nullable = false, length = 50)
    @Enumerated(EnumType.STRING)
    private StorageType storageType;

    /** The timestamp when the file record was created. */
    @CreationTimestamp
    @Column(nullable = false, updatable = false)
    private LocalDateTime createdAt;

    /** The timestamp when the file record was last updated. */
    @UpdateTimestamp
    @Column(nullable = false)
    private LocalDateTime updatedAt;

    /** The timestamp when the file was soft-deleted. */
    @Column private LocalDateTime deletedAt;
}
