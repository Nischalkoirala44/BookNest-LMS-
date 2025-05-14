<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.BookDAO,model.Book,model.User,java.util.List,java.util.Objects" %>
<%@ include file="nav-bar.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book Nest</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }

        :root {
            --primary-color: #ff7a65;
            --primary-hover: #e66b58;
            --secondary-color: #f8f8f8;
            --text-color: #333;
            --light-text: #888;
            --border-color: #ddd;
            --status-available-bg: hsl(8, 100%, 95%);
            --status-available-text: hsl(8, 80%, 40%);
            --status Lilly-bg: hsl(8, 20%, 95%);
            --status-borrowed-text: hsl(8, 80%, 50%);
        }

        body {
            background-color: var(--secondary-color);
            color: var(--text-color);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        .navbar {
            background-color: white;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            padding: 15px 0;
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .nav-container {
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0 20px;
        }

        .logo {
            display: flex;
            align-items: center;
        }

        .logo h1 {
            font-size: 24px;
            color: var(--text-color);
        }

        .logo span {
            color: var(--primary-color);
        }

        .nav-links {
            display: flex;
            list-style: none;
            align-items: center;
        }

        .nav-links li {
            margin-left: 30px;
        }

        .nav-links a {
            text-decoration: none;
            color: var(--text-color);
            font-weight: 500;
            transition: color 0.3s;
        }

        .nav-links a:hover {
            color: var(--primary-color);
        }

        .nav-links .active {
            color: var(--primary-color);
        }

        .user-actions {
            display: flex;
            align-items: center;
        }

        .user-profile {
            display: flex;
            align-items: center;
            cursor: pointer;
            position: relative;
        }

        .user-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background-color: var(--primary-color);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            margin-right: 10px;
            overflow: hidden;
        }

        .user-avatar img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            border-radius: 50%;
        }

        .user-name {
            font-weight: 500;
        }

        .dropdown-menu {
            position: absolute;
            top: 100%;
            right: 0;
            background-color: white;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            width: 200px;
            display: none;
            z-index: 101;
        }

        .dropdown-menu.active {
            display: block;
        }

        .dropdown-menu ul {
            list-style: none;
            padding: 10px 0;
        }

        .dropdown-menu li {
            padding: 10px 20px;
        }

        .dropdown-menu a {
            text-decoration: none;
            color: var(--text-color);
            display: block;
        }

        .dropdown-menu a:hover {
            color: var(--primary-color);
        }

        .dropdown-menu .logout {
            border-top: 1px solid var(--border-color);
            margin-top: 5px;
        }

        .hamburger {
            display: none;
            font-size: 24px;
            background: none;
            border: none;
            color: var(--text-color);
            cursor: pointer;
        }

        .modal {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            display: flex;
            align-items: center;
            justify-content: center;
            z-index: 1000;
            opacity: 0;
            visibility: hidden;
            transition: opacity 0.3s, visibility 0.3s;
        }

        .modal.active {
            opacity: 1;
            visibility: visible;
        }

        .modal-content {
            background-color: white;
            border-radius: 8px;
            width: 90%;
            max-width: 500px;
            max-height: 90vh;
            overflow-y: auto;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
        }

        .modal-header {
            padding: 15px 20px;
            border-bottom: 1px solid var(--border-color);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .modal-title {
            font-size: 20px;
            font-weight: bold;
        }

        .modal-close {
            background: none;
            border: none;
            font-size: 24px;
            cursor: pointer;
            color: var(--light-text);
        }

        .modal-body {
            padding: 20px;
        }

        .modal-footer {
            padding: 15px 20px;
            border-top: 1px solid var(--border-color);
            display: flex;
            justify-content: flex-end;
        }

        .modal-footer button {
            padding: 8px 15px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            margin-left: 10px;
        }

        .modal-footer button a {
            text-decoration: none;
            color: white;
        }

        .btn-secondary {
            background-color: #f0f0f0;
            color: var(--text-color);
            border: 1px solid var(--border-color);
        }

        .btn-primary {
            background-color: var(--primary-color);
            color: white;
            border: none;
        }

        .profile-details {
            display: grid;
            grid-template-columns: 1fr 2fr;
            gap: 15px;
        }

        .profile-avatar {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            background-color: var(--primary-color);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 36px;
            font-weight: bold;
            margin: 0 auto;
            overflow: hidden;
        }

        .profile-avatar img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            border-radius: 50%;
        }

        .profile-info {
            margin-top: 20px;
        }

        .profile-info-item {
            margin-bottom: 15px;
        }

        .profile-info-label {
            font-weight: bold;
            margin-bottom: 5px;
            color: var(--light-text);
            font-size: 14px;
        }

        .profile-info-value {
            font-size: 16px;
        }

        .main-content {
            padding: 40px 0;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
        }

        .page-title {
            margin-bottom: 30px;
        }

        .page-title h1 {
            font-size: 32px;
            color: var(--primary-color);
        }

        .page-title p {
            color: var(--light-text);
        }

        .search-filter-container {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            padding: 20px;
            margin-bottom: 30px;
        }

        .search-bar {
            display: flex;
            margin-bottom: 20px;
        }

        .search-input {
            flex: 1;
            padding: 12px 15px;
            border: 1px solid var(--border-color);
            border-radius: 5px 0 0 5px;
            font-size: 16px;
        }

        .search-btn {
            background-color: var(--primary-color);
            color: white;
            border: none;
            padding: 0 20px;
            border-radius: 0 5px 5px 0;
            cursor: pointer;
            font-weight: 600;
            transition: background-color 0.3s;
        }

        .search-btn:hover {
            background-color: var(--primary-hover);
        }

        .filters {
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
        }

        .filter-group {
            flex: 1;
            min-width: 200px;
        }

        .filter-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: var(--light-text);
        }

        .filter-group select {
            width: 100%;
            padding: 10px;
            border: 1px solid var(--border-color);
            border-radius: 5px;
            background-color: white;
            font-size: 16px;
        }

        .books-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
            gap: 25px;
        }

        .book-card {
            background-color: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            transition: transform 0.3s;
            height: 100%;
            display: flex;
            flex-direction: column;
        }

        .book-card:hover {
            transform: translateY(-10px);
        }

        .book-cover {
            height: 280px;
            background-color: #f0f0f0;
            overflow: hidden;
        }

        .book-cover img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .book-info {
            padding: 20px;
            flex: 1;
            display: flex;
            flex-direction: column;
        }

        .book-info h3 {
            font-size: 18px;
            margin-bottom: 10px;
        }

        .book-info p {
            font-size: 14px;
            color: var(--light-text);
            margin-bottom: 15px;
        }

        .book-info .category {
            display: inline-block;
            background-color: var(--secondary-color);
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 12px;
            color: var(--light-text);
            margin-bottom: 15px;
        }

        .status {
            margin-top: auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .status-badge {
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 500;
        }

        .available {
            background-color: var(--status-available-bg);
            color: var(--status-available-text);
        }

        .borrowed {
            background-color: var(--status-borrowed-bg);
            color: var(--status-borrowed-text);
        }

        .borrow-btn {
            display: inline-block;
            background-color: var(--primary-color);
            color: white;
            padding: 8px 15px;
            border-radius: 5px;
            text-decoration: none;
            font-size: 14px;
            font-weight: 500;
            transition: background-color 0.3s;
            border: none;
            cursor: pointer;
        }

        .disabled-btn {
            background-color: #ccc;
            cursor: not-allowed;
        }

        .disabled-btn:hover {
            background-color: #ccc;
        }

        .pagination {
            display: flex;
            justify-content: center;
            margin-top: 40px;
        }

        .pagination-btn {
            display: inline-block;
            padding: 8px 12px;
            margin: 0 5px;
            border-radius: 5px;
            background-color: white;
            border: 1px solid var(--border-color);
            color: var(--text-color);
            text-decoration: none;
            transition: all 0.3s;
        }


        .disabled-btn {
            color: #6c757d;
            cursor: not-allowed;
            text-decoration: none;
        }

        .pagination-btn:hover {
            background-color: var(--secondary-color);
        }

        .pagination-btn.active {
            background-color: var(--primary-color);
            color: white;
            border-color: var(--primary-color);
        }

        @media (max-width: 768px) {
            .nav-links {
                display: none;
                flex-direction: column;
                position: absolute;
                top: 100%;
                left: 0;
                width: 100%;
                background-color: white;
                padding: 20px;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            }

            .nav-links.active {
                display: flex;
            }

            .nav-links li {
                margin: 10px 0;
            }

            .hamburger {
                display: block;
            }

            .profile-details {
                grid-template-columns: 1fr;
            }

            .dropdown-menu {
                width: 150px;
            }

            .search-bar {
                flex-direction: column;
            }

            .search-input {
                border-radius: 5px;
                margin-bottom: 10px;
            }

            .search-btn {
                border-radius: 5px;
                padding: 10px;
            }

            .books-grid {
                grid-template-columns: repeat(auto-fill, minmax(150px, 1fr));
            }

            .book-cover {
                height: 200px;
            }
        }

        .footer {
            background-color: white;
            box-shadow: 0 -2px 10px rgba(0, 0, 0, 0.1);
            padding: 30px 0;
            margin-top: auto;
        }

        .footer-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
        }

        .footer-content {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 30px;
        }

        .footer-section h3 {
            font-size: 18px;
            margin-bottom: 15px;
            position: relative;
            padding-bottom: 10px;
        }

        .footer-section h3::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 30px;
            height: 2px;
            background-color: var(--primary-color);
        }

        .footer-links {
            list-style: none;
        }

        .footer-links li {
            margin-bottom: 10px;
        }

        .footer-links a {
            text-decoration: none;
            color: var(--text-color);
            transition: color 0.3s;
        }

        .footer-links a:hover {
            color: var(--primary-color);
        }

        .footer-bottom {
            text-align: center;
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid var(--border-color);
            color: var(--light-text);
            font-size: 14px;
        }

        .modal {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            display: flex;
            align-items: center;
            justify-content: center;
            z-index: 1000;
            opacity: 0;
            visibility: hidden;
            transition: opacity 0.3s, visibility 0.3s;
        }

        .modal.active {
            opacity: 1;
            visibility: visible;
        }

        .modal-content {
            background-color: white;
            border-radius: 8px;
            width: 90%;
            max-width: 500px;
            max-height: 90vh;
            overflow-y: auto;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
        }

        .modal-header {
            padding: 15px 20px;
            border-bottom: 1px solid var(--border-color);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .modal-title {
            font-size: 20px;
            font-weight: bold;
        }

        .modal-close {
            background: none;
            border: none;
            font-size: 24px;
            cursor: pointer;
            color: var(--light-text);
        }

        .modal-body {
            padding: 20px;
        }

        .modal-footer {
            padding: 15px 20px;
            border-top: 1px solid var(--border-color);
            display: flex;
            justify-content: flex-end;
        }

        .modal-footer button {
            padding: 8px 15px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            margin-left: 10px;
        }

        .modal-footer button a {
            text-decoration: none;
            color: white;
        }

        .btn-secondary {
            background-color: #f0f0f0;
            color: var(--text-color);
            border: 1px solid var(--border-color);
        }

        .btn-primary {
            background-color: var(--primary-color);
            color: white;
            border: none;
        }

        .profile-details {
            display: grid;
            grid-template-columns: 1fr 2fr;
            gap: 15px;
        }

        .profile-avatar {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            background-color: var(--primary-color);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 36px;
            font-weight: bold;
            margin: 0 auto;
            overflow: hidden;
        }

        .profile-avatar img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            border-radius: 50%;
        }

        .profile-info {
            margin-top: 20px;
        }

        .profile-info-item {
            margin-bottom: 15px;
        }

        .profile-info-label {
            font-weight: bold;
            margin-bottom: 5px;
            color: var(--light-text);
            font-size: 14px;
        }

        .profile-info-value {
            font-size: 16px;
        }

        .main-content {
            padding: 40px 0;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
        }

        @media (max-width: 768px) {
            .nav-links {
                display: none;
                flex-direction: column;
                position: absolute;
                top: 100%;
                left: 0;
                width: 100%;
                background-color: white;
                padding: 20px;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            }

            .nav-links.active {
                display: flex;
            }

            .nav-links li {
                margin: 10px 0;
            }

            .hamburger {
                display: block;
            }

            .profile-details {
                grid-template-columns: 1fr;
            }

            .dropdown-menu {
                width: 150px;
            }

            .books-grid {
                grid-template-columns: repeat(auto-fill, minmax(150px, 1fr));
            }

            .book-cover {
                height: 200px;
            }
        }


    </style>
</head>
<body>


<!-- Main Content -->
<div class="main-content">
    <div class="container">
        <div class="page-title">
            <h1>Books Catalog</h1>
            <p>Browse through our collection of books</p>
        </div>



        <!-- Books Grid -->
        <div class="books-grid" id="booksGrid">
            <%
                List<Book> books = (List<Book>) request.getAttribute("books");
                if (books == null || books.isEmpty()) {
                    BookDAO bookDAO = new BookDAO();
                    try {
                        books = bookDAO.getAllBooks();
                    } catch (Exception e) {
                        System.out.println("Error: " + e.getMessage().replaceAll("[<>\"&]", ""));
                    }
                }
                if (books != null) {
                    for (Book book : books) {
                        if (book != null) {
                            String title = book.getTitle() != null ? book.getTitle().replaceAll("[<>\"&]", "") : "Untitled";
                            String author = book.getAuthor() != null ? book.getAuthor().replaceAll("[<>\"&]", "") : "Unknown";
                            String category = book.getCategory() != null ? book.getCategory().replaceAll("[<>\"&]", "") : "Uncategorized";
                            boolean isAvailable = book.getTotalCopies() > 0;
            %>
            <div class="book-card">
                <div class="book-cover">
                    <img src="${pageContext.request.contextPath}/BookImageServlet?bookId=<%= book.getBookId() %>" alt="<%= title %>">
                </div>
                <div class="book-info">
                    <span class="category"><%= category %></span>
                    <h3><%= title %></h3>
                    <p>Author: <%= author %></p>
                    <div class="status">
                        <span class="status-badge <%= isAvailable ? "available" : "borrowed" %>">
                            <%= isAvailable ? "Available" : "Borrowed" %>
                        </span>
                        <form method="post" action="${pageContext.request.contextPath}/borrow" style="display: inline;">
                            <input type="hidden" name="bookId" value="<%= book.getBookId() %>">
                            <input type="hidden" name="userId" value="<%= user.getUserId()%>">
                            <button type="submit" class="borrow-btn <%= isAvailable ? "" : "disabled-btn" %>"
                                    <%= isAvailable ? "" : "disabled" %>>
                                Borrow
                            </button>
                        </form>
                    </div>
                </div>
            </div>
            <%
                    }
                }
            } else {
            %>
            <p>No books found.</p>
            <%
                }
            %>
        </div>

        <!-- Pagination -->
        <div class="pagination" id="pagination">

        </div>
    </div>
</div>

<!-- Footer -->
<footer class="footer">
    <div class="footer-container">
        <div class="footer-content">
            <div class="footer-section">
                <h3>About Us</h3>
                <ul class="footer-links">
                    <li><a href="#">Our Story</a></li>
                    <li><a href="#">Team</a></li>
                    <li><a href="#">Careers</a></li>
                    <li><a href="#">Press</a></li>
                </ul>
            </div>
            <div class="footer-section">
                <h3>Resources</h3>
                <ul class="footer-links">
                    <li><a href="#">Help Center</a></li>
                    <li><a href="#">FAQs</a></li>
                    <li><a href="#">Community Guidelines</a></li>
                    <li><a href="#">Tutorials</a></li>
                </ul>
            </div>
            <div class="footer-section">
                <h3>Legal</h3>
                <ul class="footer-links">
                    <li><a href="#">Terms of Service</a></li>
                    <li><a href="#">Privacy Policy</a></li>
                    <li><a href="#">Cookie Policy</a></li>
                    <li><a href="#">Copyright</a></li>
                </ul>
            </div>
            <div class="footer-section">
                <h3>Contact</h3>
                <ul class="footer-links">
                    <li><a href="#">Email Us</a></li>
                    <li><a href="#">Support</a></li>
                    <li><a href="#">Feedback</a></li>
                    <li><a href="#">Report an Issue</a></li>
                </ul>
            </div>
        </div>
        <div class="footer-bottom">
            <p>© 2025 Book Nest. All rights reserved.</p>
        </div>
    </div>
</footer>

<!-- Profile Modal -->
<div class="modal" id="profileModal" role="dialog" aria-modal="true">
    <div class="modal-content">
        <div class="modal-header">
            <h2 class="modal-title">Profile</h2>
            <button class="modal-close" aria-label="Close profile modal">×</button>
        </div>
        <div class="modal-body">
            <div class="profile-details">
                <% if (user != null) { %>
                <div class="profile-avatar">
                    <% if (user != null && user.getProfilePicture() != null && user.getProfilePicture().length > 0) { %>
                    <img src='${pageContext.request.contextPath}/ProfileImageServlet?userId=<%= user.getUserId() %>' alt='Profile Image' />
                    <% } else if (user != null) { %>
                    <%= user.getName().charAt(0) %>
                    <% } else { %>
                    G
                    <% } %>
                </div>
                <div class="profile-info">
                    <div class="profile-info-item">
                        <div class="profile-info-label">Name</div>
                        <div class="profile-info-value"><%= user.getName() != null ? user.getName().replaceAll("[<>\"&]", "") : "N/A" %></div>
                    </div>
                    <div class="profile-info-item">
                        <div class="profile-info-label">Email</div>
                        <div class="profile-info-value"><%= user.getEmail() != null ? user.getEmail().replaceAll("[<>\"&]", "") : "N/A" %></div>
                    </div>
                    <div class="profile-info-item">
                        <div class="profile-info-label">Bio</div>
                        <div class="profile-info-value"><%= user.getBio() != null ? user.getBio().replaceAll("[<>\"&]", "") : "No bio provided" %></div>
                    </div>
                    <div class="profile-info-item">
                        <div class="profile-info-label">Address</div>
                        <div class="profile-info-value"><%= user.getAddress() != null ? user.getAddress().replaceAll("[<>\"&]", "") : "No address provided" %></div>
                    </div>
                </div>
                <% } else { %>
                <div class="profile-info">
                    <div class="profile-info-item">
                        <div class="profile-info-value">Please log in to view profile details.</div>
                    </div>
                </div>
                <% } %>
            </div>
        </div>
        <div class="modal-footer">
            <button class="btn-secondary modal-close-btn">Close</button>
            <% if (user != null) { %>
            <button class="btn-primary"><a href="editProfile.jsp">Edit Profile</a></button>
            <% } %>
        </div>
    </div>
</div>

<script>
    // User Profile Dropdown Toggle
    const userProfileToggle = document.getElementById('userProfileToggle');
    const userDropdown = document.getElementById('userDropdown');
    if (userProfileToggle && userDropdown) {
        userProfileToggle.addEventListener('click', function(event) {
            event.stopPropagation();
            const isActive = userDropdown.classList.toggle('active');
            userProfileToggle.setAttribute('aria-expanded', isActive);
        });
    }

    document.addEventListener('click', function(event) {
        if (userDropdown && !userProfileToggle.contains(event.target) && !userDropdown.contains(event.target)) {
            userDropdown.classList.remove('active');
            userProfileToggle.setAttribute('aria-expanded', 'false');
        }
    });

    // Hamburger Menu Toggle
    const hamburger = document.querySelector('.hamburger');
    const navLinks = document.querySelector('.nav-links');
    if (hamburger && navLinks) {
        hamburger.addEventListener('click', function() {
            const isActive = navLinks.classList.toggle('active');
            hamburger.setAttribute('aria-expanded', isActive);
            hamburger.textContent = isActive ? '×' : '☰';
        });
    }

    document.addEventListener('click', function(event) {
        if (navLinks && hamburger && !navLinks.contains(event.target) && !hamburger.contains(event.target)) {
            navLinks.classList.remove('active');
            hamburger.setAttribute('aria-expanded', 'false');
            hamburger.textContent = '☰';
        }
    });

    // Modal Functionality
    const profileModal = document.getElementById('profileModal');
    const viewProfileBtn = document.getElementById('viewProfileBtn');
    const modalCloseBtns = document.querySelectorAll('.modal-close, .modal-close-btn');

    if (viewProfileBtn) {
        viewProfileBtn.addEventListener('click', function(e) {
            e.preventDefault();
            profileModal.classList.add('active');
            userDropdown.classList.remove('active');
        });
    }

    modalCloseBtns.forEach(btn => {
        btn.addEventListener('click', function() {
            profileModal.classList.remove('active');
        });
    });

    profileModal.addEventListener('click', function(e) {
        if (e.target === this) {
            this.classList.remove('active');
        }
    });

    // Function to handle search
    function searchBooks() {
        const searchTerm = encodeURIComponent(document.getElementById('searchInput').value.trim());
        const category = encodeURIComponent(document.getElementById('categoryFilter').value);
        const availability = encodeURIComponent(document.getElementById('availabilityFilter').value);
        const sort = encodeURIComponent(document.getElementById('sortFilter').value);
        const contextPath = '<%= request.getContextPath() %>';
        const url = `${contextPath}/searchBook?searchTerm=${searchTerm}&searchType=all&category=${category}&availability=${availability}&sort=${sort}`;
        window.location.href = url;
    }

    // Initialize page
    document.addEventListener('DOMContentLoaded', function() {
        const searchBtn = document.getElementById('searchBtn');
        if (searchBtn) {
            searchBtn.addEventListener('click', function(e) {
                e.preventDefault();
                searchBooks();
            });
        }

        const searchInput = document.getElementById('searchInput');
        if (searchInput) {
            searchInput.addEventListener('keyup', function(e) {
                if (e.key === 'Enter') {
                    e.preventDefault();
                    searchBooks();
                }
            });
        }

        const categoryFilter = document.getElementById('categoryFilter');
        if (categoryFilter) {
            categoryFilter.addEventListener('change', searchBooks);
        }

        const availabilityFilter = document.getElementById('availabilityFilter');
        if (availabilityFilter) {
            availabilityFilter.addEventListener('change', searchBooks);
        }

        const sortFilter = document.getElementById('sortFilter');
        if (sortFilter) {
            sortFilter.addEventListener('change', searchBooks);
        }
    });
</script>
</body>
</html>