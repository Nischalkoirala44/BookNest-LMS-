<%@ include file="nav-bar.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>My Book Shelf</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Inter', Arial, sans-serif;
        }

        :root {
            --primary-color: #ff7a65;
            --secondary-color: #f8f8f8;
            --text-color: #333;
            --light-text: #888;
            --border-color: #ddd;
        }

        body {
            background: linear-gradient(135deg, #f5f5e8 0%, #e8d9c1 100%);
            color: var(--text-color);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            position: relative;
            overflow-x: hidden;
        }

        /* Background Pattern and Animation */
        body::before {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="40" height="40" viewBox="0 0 40 40"><rect x="10" y="5" width="5" height="30" fill="%23d3c7a5" opacity="0.3"/><rect x="20" y="5" width="5" height="30" fill="%23d3c7a5" opacity="0.3"/><rect x="30" y="5" width="5" height="30" fill="%23d3c7a5" opacity="0.3"/></svg>') repeat;
            opacity: 0.2;
            z-index: -1;
        }

        .background-books {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            pointer-events: none;
            z-index: -1;
        }

        .book-particle {
            position: absolute;
            font-size: 24px;
            color: #d3c7a5;
            opacity: 0.4;
            animation: drift 15s infinite linear;
        }

        @keyframes drift {
            0% {
                transform: translateY(100vh) translateX(0);
                opacity: 0.4;
            }
            50% {
                opacity: 0.6;
            }
            100% {
                transform: translateY(-100vh) translateX(20px);
                opacity: 0.4;
            }
        }
        /* Main Content */
        .main-content {
            flex: 1;
            max-width: 1200px;
            margin: 0 auto;
            padding: 30px 20px;
        }

        .section-title {
            font-size: 24px;
            margin-bottom: 20px;
            position: relative;
            padding-bottom: 10px;
            font-family: 'Georgia', serif;
        }

        .section-title::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 50px;
            height: 3px;
            background-color: var(--primary-color);
        }

        /* Hero Section */
        .hero {
            background-color: var(--primary-color);
            color: white;
            padding: 60px 20px;
            text-align: center;
            margin-bottom: 40px;
            border-radius: 12px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .hero h2 {
            font-size: 36px;
            margin-bottom: 15px;
            font-family: 'Georgia', serif;
        }

        .hero p {
            font-size: 18px;
            max-width: 700px;
            margin: 0 auto 30px;
        }

        .search-bar {
            max-width: 600px;
            margin: 0 auto;
            display: flex;
        }

        .search-bar input {
            flex: 1;
            padding: 12px 15px;
            border: none;
            border-radius: 4px 0 0 4px;
            font-size: 16px;
        }

        .search-bar button {
            padding: 12px 20px;
            background-color: var(--text-color);
            color: white;
            border: none;
            border-radius: 0 4px 4px 0;
            cursor: pointer;
            font-size: 16px;
        }

        /* Book Grid */
        .book-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
            gap: 30px;
            margin-bottom: 40px;
        }

        .book-card {
            background-color: white;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .book-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        }

        .book-cover {
            height: 250px;
            background-color: #f0f0f0;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--light-text);
        }

        .book-cover img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .book-info {
            padding: 15px;
        }

        .book-title {
            font-size: 16px;
            font-weight: bold;
            margin-bottom: 5px;
        }

        .book-author {
            font-size: 14px;
            color: var(--light-text);
            margin-bottom: 10px;
        }

        .book-status {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .availability {
            font-size: 12px;
            padding: 3px 8px;
            border-radius: 20px;
        }

        .available {
            background-color: #e6f7e6;
            color: #2e7d32;
        }

        .borrowed {
            background-color: #ffeaea;
            color: #c62828;
        }

        .book-action {
            background-color: var(--primary-color);
            color: white;
            border: none;
            padding: 5px 10px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 12px;
        }

        .book-action:disabled {
            background-color: var(--light-text);
            cursor: not-allowed;
        }

        /* Categories Section */
        .categories {
            margin-bottom: 40px;
        }

        .category-list {
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
        }

        .category-item {
            background-color: white;
            padding: 15px 20px;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            cursor: pointer;
            transition: background-color 0.3s, transform 0.3s;
            font-weight: 500;
            text-align: center;
        }

        .category-item:hover {
            background-color: var(--primary-color);
            color: white;
            transform: translateY(-2px);
        }

        .category-item.active {
            background-color: var(--primary-color);
            color: white;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
        }

        @media (max-width: 768px) {
            .category-list {
                justify-content: center;
            }

            .category-item {
                flex: 1 1 40%;
                min-width: 120px;
            }
        }

        @media (max-width: 480px) {
            .category-item {
                flex: 1 1 100%;
            }
        }

        /* My Books Section */
        .my-books {
            margin-bottom: 40px;
        }

        .tabs {
            display: flex;
            border-bottom: 1px solid var(--border-color);
            margin-bottom: 20px;
        }

        .tab {
            padding: 10px 20px;
            cursor: pointer;
            border-bottom: 3px solid transparent;
        }

        .tab.active {
            border-bottom-color: var(--primary-color);
            color: var(--primary-color);
        }

        .tab-content {
            display: none;
        }

        .tab-content.active {
            display: block;
        }

        .book-list {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }

        .book-list-item {
            display: flex;
            padding: 15px;
            border-bottom: 1px solid var(--border-color);
        }

        .book-list-item:last-child {
            border-bottom: none;
        }

        .book-list-cover {
            width: 60px;
            height: 80px;
            background-color: #f0f0f0;
            margin-right: 15px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .book-list-cover img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .book-list-info {
            flex: 1;
        }

        .book-list-title {
            font-weight: bold;
            margin-bottom: 5px;
        }

        .book-list-author {
            font-size: 14px;
            color: var(--light-text);
            margin-bottom: 5px;
        }

        .book-list-date {
            font-size: 12px;
            color: var(--light-text);
        }

        .book-list-actions {
            display: flex;
            align-items: center;
        }

        .book-list-actions button {
            background-color: var(--primary-color);
            color: white;
            border: none;
            padding: 8px 12px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            margin-left: 10px;
        }

        /* Footer */
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
            font-family: 'Georgia', serif;
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

        /* Modal */
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
            padding: 8px 15px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            margin-left: 10px;
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

        /* Book Details Modal */
        .book-details {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .book-details-header {
            display: flex;
            gap: 20px;
        }

        .book-details-cover {
            width: 150px;
            height: 200px;
            background-color: #f0f0f0;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .book-details-cover img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .book-details-info {
            flex: 1;
        }

        .book-details-title {
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 10px;
        }

        .book-details-author {
            font-size: 16px;
            color: var(--light-text);
            margin-bottom: 10px;
        }

        .book-details-meta {
            display: flex;
            gap: 15px;
            margin-bottom: 15px;
        }

        .book-details-meta-item {
            font-size: 14px;
        }

        .book-details-description {
            margin-top: 20px;
        }

        .book-details-description h4 {
            margin-bottom: 10px;
        }

        @media (max-width: 768px) {
            .book-details-header {
                flex-direction: column;
                align-items: center;
                text-align: center;
            }
        }
    </style>
</head>
<body>
<!-- Background Animation -->
<div class="background-books">
    <div class="book-particle" style="left: 10%; animation-delay: 0s;">📖</div>
    <div class="book-particle" style="left: 30%; animation-delay: 2s;">📘</div>
    <div class="book-particle" style="left: 50%; animation-delay: 4s;">📙</div>
    <div class="book-particle" style="left: 70%; animation-delay: 6s;">📕</div>
    <div class="book-particle" style="left: 90%; animation-delay: 8s;">📗</div>
</div>

<!-- Hero Section -->
<section class="hero">
    <% if (user != null) { %>
    <h2>Welcome <%= user.getName() %>!</h2>
    <% } else { %>
    <h2>Welcome Guest!</h2>
    <% } %>
    <h2>Discover Your Next Favorite Book</h2>
    <p>Explore our vast collection of books across various genres and borrow them with just a few clicks.</p>
    <div class="search-bar">
        <input type="text" placeholder="Search by title, author, or ISBN...">
        <button>Search</button>
    </div>
</section>

<!-- Main Content -->
<div class="main-content">
    <!-- Featured Books Section -->
    <section class="featured-books">
        <h2 class="section-title">Featured Books</h2>
        <div class="book-grid">
            <!-- Book 1 -->
            <div class="book-card">
                <div class="book-cover">
                    <img src="../assets/gatsby.jpg" alt="Book Cover">
                </div>
                <div class="book-info">
                    <div class="book-title">The Great Gatsby</div>
                    <div class="book-author">F. Scott Fitzgerald</div>
                    <div class="book-status">
                        <span class="availability available">Available</span>
                        <button class="book-action" data-book-id="1">Borrow</button>
                    </div>
                </div>
            </div>
            <!-- Book 2 -->
            <div class="book-card">
                <div class="book-cover">
                    <img src="../assets/to-kill-a-mockingbird-y9oj1gep.jpg" alt="Book Cover">
                </div>
                <div class="book-info">
                    <div class="book-title">To Kill a Mockingbird</div>
                    <div class="book-author">Harper Lee</div>
                    <div class="book-status">
                        <span class="availability borrowed">Borrowed</span>
                        <button class="book-action" disabled>Borrow</button>
                    </div>
                </div>
            </div>
            <!-- Book 3 -->
            <div class="book-card">
                <div class="book-cover">
                    <img src="../assets/1984.jpeg" alt="Book Cover">
                </div>
                <div class="book-info">
                    <div class="book-title">1984</div>
                    <div class="book-author">George Orwell</div>
                    <div class="book-status">
                        <span class="availability available">Available</span>
                        <button class="book-action" data-book-id="3">Borrow</button>
                    </div>
                </div>
            </div>
            <!-- Book 4 -->
            <div class="book-card">
                <div class="book-cover">
                    <img src="../assets/prideandprejudice.jpeg" alt="Book Cover">
                </div>
                <div class="book-info">
                    <div class="book-title">Pride and Prejudice</div>
                    <div class="book-author">Jane Austen</div>
                    <div class="book-status">
                        <span class="availability available">Available</span>
                        <button class="book-action" data-book-id="4">Borrow</button>
                    </div>
                </div>
            </div>
            <!-- Book 5 -->
            <div class="book-card">
                <div class="book-cover">
                    <img src="../assets/hobbit.jpeg" alt="Book Cover">
                </div>
                <div class="book-info">
                    <div class="book-title">The Hobbit</div>
                    <div class="book-author">J.R.R. Tolkien</div>
                    <div class="book-status">
                        <span class="availability borrowed">Borrowed</span>
                        <button class="book-action" disabled>Borrow</button>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Categories Section -->
    <section class="categories">
        <h2 class="section-title">Browse by Category</h2>
        <div class="category-list">
            <%
                String[] categories = {"Fiction", "Non-Fiction", "Science", "History", "Biography", "Technology", "Business", "Self-Help", "Fantasy", "Mystery"};
                for (String category : categories) {
            %>
            <div class="category-item" data-category="<%= category.toLowerCase() %>">
                <%= category %>
            </div>
            <% } %>
        </div>
    </section>
    <!-- My Books Section -->
    <section class="my-books">
        <h2 class="section-title">My Books</h2>
        <div class="tabs">
            <div class="tab active" data-tab="currently-borrowed">Currently Borrowed</div>
            <div class="tab" data-tab="reading-history">Reading History</div>
            <div class="tab" data-tab="wishlist">Wishlist</div>
        </div>
        <!-- Currently Borrowed Tab -->
        <div class="tab-content active" id="currently-borrowed">
            <div class="book-list">
                <!-- Book 1 -->
                <div class="book-list-item">
                    <div class="book-list-cover">
                        <img src="../assets/catcher.jpg" alt="Book Cover">
                    </div>
                    <div class="book-list-info">
                        <div class="book-list-title">The Catcher in the Rye</div>
                        <div class="book-list-author">J.D. Salinger</div>
                        <div class="book-list-date">Due: May 15, 2025</div>
                    </div>
                    <div class="book-list-actions">
                        <button>Return</button>
                        <button>Renew</button>
                    </div>
                </div>
                <!-- Book 2 -->
                <div class="book-list-item">
                    <div class="book-list-cover">
                        <img src="../assets/BraveNewWorld_FirstEdition.jpg" alt="Book Cover">
                    </div>
                    <div class="book-list-info">
                        <div class="book-list-title">Brave New World</div>
                        <div class="book-list-author">Aldous Huxley</div>
                        <div class="book-list-date">Due: May 20, 2025</div>
                    </div>
                    <div class="book-list-actions">
                        <button>Return</button>
                        <button>Renew</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- Reading History Tab -->
        <div class="tab-content" id="reading-history">
            <div class="book-list">
                <!-- Book 1 -->
                <div class="book-list-item">
                    <div class="book-list-cover">
                        <img src="" alt="Book Cover">
                    </div>
                    <div class="book-list-info">
                        <div class="book-list-title">The Lord of the Rings</div>
                        <div class="book-list-author">J.R.R. Tolkien</div>
                        <div class="book-list-date">Returned: April 5, 2025</div>
                    </div>
                    <div class="book-list-actions">
                        <button>Borrow Again</button>
                    </div>
                </div>
                <!-- Book 2 -->
                <div class="book-list-item">
                    <div class="book-list-cover">
                        <img src="https://via.placeholder.com/60x80" alt="Book Cover">
                    </div>
                    <div class="book-list-info">
                        <div class="book-list-title">Harry Potter and the Philosopher's Stone</div>
                        <div class="book-list-author">J.K. Rowling</div>
                        <div class="book-list-date">Returned: March 20, 2025</div>
                    </div>
                    <div class="book-list-actions">
                        <button>Borrow Again</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- Wishlist Tab -->
        <div class="tab-content" id="wishlist">
            <div class="book-list">
                <!-- Book 1 -->
                <div class="book-list-item">
                    <div class="book-list-cover">
                        <img src="https://via.placeholder.com/60x80" alt="Book Cover">
                    </div>
                    <div class="book-list-info">
                        <div class="book-list-title">Dune</div>
                        <div class="book-list-author">Frank Herbert</div>
                        <div class="book-list-date">Added: April 10, 2025</div>
                    </div>
                    <div class="book-list-actions">
                        <button>Check Availability</button>
                    </div>
                </div>
                <!-- Book 2 -->
                <div class="book-list-item">
                    <div class="book-list-cover">
                        <img src="https://via.placeholder.com/60x80" alt="Book Cover">
                    </div>
                    <div class="book-list-info">
                        <div class="book-list-title">The Alchemist</div>
                        <div class="book-list-author">Paulo Coelho</div>
                        <div class="book-list-date">Added: April 2, 2025</div>
                    </div>
                    <div class="book-list-actions">
                        <button>Check Availability</button>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Recently Added Section -->
    <section class="recently-added">
        <h2 class="section-title">Recently Added</h2>
        <div class="book-grid">
            <!-- Book 1 -->
            <div class="book-card">
                <div class="book-cover">
                    <img src="../assets/midnight.jpg" alt="Book Cover">
                </div>
                <div class="book-info">
                    <div class="book-title">The Midnight Library</div>
                    <div class="book-author">Matt Haig</div>
                    <div class="book-status">
                        <span class="availability available">Available</span>
                        <button class="book-action" data-book-id="6">Borrow</button>
                    </div>
                </div>
            </div>
            <!-- Book 2 -->
            <div class="book-card">
                <div class="book-cover">
                    <img src="../assets/educated.jpeg" alt="Book Cover">
                </div>
                <div class="book-info">
                    <div class="book-title">Educated</div>
                    <div class="book-author">Tara Westover</div>
                    <div class="book-status">
                        <span class="availability available">Available</span>
                        <button class="book-action" data-book-id="7">Borrow</button>
                    </div>
                </div>
            </div>
            <!-- Book 3 -->
            <div class="book-card">
                <div class="book-cover">
                    <img src="../assets/atomicHabits.jpg" alt="Book Cover">
                </div>
                <div class="book-info">
                    <div class="book-title">Atomic Habits</div>
                    <div class="book-author">James Clear</div>
                    <div class="book-status">
                        <span class="availability borrowed">Borrowed</span>
                        <button class="book-action" disabled>Borrow</button>
                    </div>
                </div>
            </div>
            <!-- Book 4 -->
            <div class="book-card">
                <div class="book-cover">
                    <img src="../assets/hailmary.jpg" alt="Book Cover">
                </div>
                <div class="book-info">
                    <div class="book-title">Project Hail Mary</div>
                    <div class="book-author">Andy Weir</div>
                    <div class="book-status">
                        <span class="availability available">Available</span>
                        <button class="book-action" data-book-id="9">Borrow</button>
                    </div>
                </div>
            </div>
        </div>
    </section>
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
            <p>© 2025 My Book Shelf. All rights reserved.</p>
        </div>
    </div>
</footer>
<!-- Book Details Modal -->
<div class="modal" id="bookDetailsModal">
    <div class="modal-content">
        <div class="modal-header">
            <div class="modal-title">Book Details</div>
            <button class="modal-close">×</button>
        </div>
        <div class="modal-body">
            <div class="book-details">
                <div class="book-details-header">
                    <div class="book-details-cover">
                        <img src="https://via.placeholder.com/150x200" alt="Book Cover">
                    </div>
                    <div class="book-details-info">
                        <div class="book-details-title">The Great Gatsby</div>
                        <div class="book-details-author">F. Scott Fitzgerald</div>
                        <div class="book-details-meta">
                            <div class="book-details-meta-item">Published: 1925</div>
                            <div class="book-details-meta-item">Pages: 180</div>
                            <div class="book-details-meta-item">ISBN: 9780743273565</div>
                        </div>
                        <div class="availability available">Available</div>
                    </div>
                </div>
                <div class="book-details-description">
                    <h4>Description</h4>
                    <p>The Great Gatsby is a 1925 novel by American writer F. Scott Fitzgerald. Set in the Jazz Age on Long Island, near New York City, the novel depicts first-person narrator Nick Carraway's interactions with mysterious millionaire Jay Gatsby and Gatsby's obsession to reunite with his former lover, Daisy Buchanan.</p>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button class="btn-secondary modal-close-btn">Close</button>
            <button class="btn-primary">Borrow Book</button>
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

    // Close dropdown when clicking outside
    document.addEventListener('click', function(event) {
        if (userDropdown && !userProfileToggle.contains(event.target) && !userDropdown.contains(event.target)) {
            userDropdown.classList.remove('active');
            userProfileToggle.setAttribute('aria-expanded', 'false');
        }
    });

    // Tab Switching
    const tabs = document.querySelectorAll('.tab');
    const tabContents = document.querySelectorAll('.tab-content');
    tabs.forEach(tab => {
        tab.addEventListener('click', function() {
            const tabId = this.getAttribute('data-tab');
            tabs.forEach(t => t.classList.remove('active'));
            tabContents.forEach(c => c.classList.remove('active'));
            this.classList.add('active');
            document.getElementById(tabId).classList.add('active');
        });
    });

    const bookDetailsModal = document.getElementById('bookDetailsModal');
    const borrowButtons = document.querySelectorAll('.book-action');


    // Open book details modal when borrow button is clicked
    borrowButtons.forEach(button => {
        if (!button.disabled) {
            button.addEventListener('click', function() {
                bookDetailsModal.classList.add('active');
            });
        }
    });

    // Close modals
    modalCloseBtns.forEach(btn => {
        btn.addEventListener('click', function() {
            modals.forEach(modal => modal.classList.remove('active'));
        });
    });

    // Close modal when clicking outside
    modals.forEach(modal => {
        modal.addEventListener('click', function(e) {
            if (e.target === this) {
                this.classList.remove('active');
            }
        });
    });

    // Category Selection
    const categoryItems = document.querySelectorAll('.category-item');
    categoryItems.forEach(item => {
        item.addEventListener('click', function() {
            categoryItems.forEach(i => i.classList.remove('active'));
            this.classList.add('active');
            const category = this.getAttribute('data-category');
            window.location.href = `browse.jsp?category=${encodeURIComponent(category)}`;
        });
    });
</script>
</body>
</html>