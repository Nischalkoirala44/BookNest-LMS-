package model;

import java.util.List;

public class Review {
    private int reviewId;
    private String comment; // 🔧 Make this non-static!
    private int bookId;
    private int userId;

    // Getters and setters
    public int getReviewId() { return reviewId; }
    public void setReviewId(int reviewId) { this.reviewId = reviewId; }

    public String getComment() { return comment; }
    public void setComment(String comment) { this.comment = comment; }

    public int getBookId() { return bookId; }
    public void setBookId(int bookId) { this.bookId = bookId; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
}
