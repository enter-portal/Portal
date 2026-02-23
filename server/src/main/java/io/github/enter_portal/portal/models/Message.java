package io.github.enter_portal.portal.models;

import java.time.LocalDateTime;
import java.util.UUID;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import io.github.enter_portal.portal.enums.MessageStatus;
import io.github.enter_portal.portal.enums.MessageType;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

/** Entity representing a message exchanged between users. */
@Entity
@Table(
        name = "messages",
        indexes = {
            @Index(
                    name = "idx_receiver_status_time",
                    columnList = "receiver_user_id, status, created_at"),
            @Index(name = "idx_sender_time", columnList = "sender_user_id, created_at"),
            @Index(name = "idx_message_file", columnList = "file_id")
        })
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Message {

    /** Unique identifier for the message. */
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    @Column(updatable = false, nullable = false)
    private UUID id;

    /** The text content of the message. */
    @Column(columnDefinition = "TEXT")
    private String message;

    /** The type of the message (e.g., TEXT, IMAGE, AUDIO). */
    @NotNull
    @Enumerated(EnumType.STRING)
    @Column(name = "message_type", nullable = false, length = 50)
    private MessageType messageType;

    /** The file associated with the message, if any. */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "file_id")
    private File file;

    /** The user who sent the message. */
    @NotNull
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "sender_user_id", nullable = false)
    private User senderUser;

    /** The user who receives the message. */
    @NotNull
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "receiver_user_id", nullable = false)
    private User receiverUser;

    /** The current status of the message (e.g., SENT, DELIVERED, READ). */
    @NotNull
    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 50)
    private MessageStatus status;

    /** The timestamp when the message was created. */
    @CreationTimestamp
    @Column(nullable = false, updatable = false)
    private LocalDateTime createdAt;

    /** The timestamp when the message was last updated. */
    @UpdateTimestamp
    @Column(nullable = false)
    private LocalDateTime updatedAt;

    /** The timestamp when the message was soft-deleted. */
    @Column private LocalDateTime deletedAt;

    /** Sets the default status to SENT before persisting if not already set. */
    @PrePersist
    protected void onCreate() {
        if (status == null) {
            status = MessageStatus.SENT;
        }
    }
}
