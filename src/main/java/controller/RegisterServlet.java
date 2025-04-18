package controller;

import dao.UserDAO;
import model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.io.InputStream;

@WebServlet("/register")
@MultipartConfig(maxFileSize = 1024 * 1024 * 5) // 5MB max file size
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String roleParam = request.getParameter("role");

        // Validate inputs
        if (name == null || email == null || password == null || name.trim().isEmpty() || email.trim().isEmpty() || password.trim().isEmpty()) {
            request.setAttribute("error", "All fields are required.");
            request.getRequestDispatcher("view/register.jsp").forward(request, response);
            return;
        }

        User.Role role = User.Role.user;
        if (roleParam != null && roleParam.equalsIgnoreCase("admin")) {
            role = User.Role.admin;
        }

        // Handle file upload
        byte[] profilePicture = null;
        Part filePart = request.getPart("profilePicture");
        if (filePart != null && filePart.getSize() > 0) {
            String contentType = filePart.getContentType();
            if (!contentType.startsWith("image/")) {
                request.setAttribute("error", "Only image files are allowed.");
                request.getRequestDispatcher("view/register.jsp").forward(request, response);
                return;
            }
            if (filePart.getSize() > 5 * 1024 * 1024) {
                request.setAttribute("error", "Profile picture is too large. Maximum size is 5MB.");
                request.getRequestDispatcher("view/register.jsp").forward(request, response);
                return;
            }
            try (InputStream inputStream = filePart.getInputStream()) {
                profilePicture = inputStream.readAllBytes();
                System.out.println("Image size: " + (profilePicture != null ? profilePicture.length : 0) + " bytes"); // Debugging
            }
        }

        User newUser = new User(name, email, password, role, profilePicture);

        try {
            int userId = UserDAO.registerUser(newUser);
            if (userId != -1) {
                response.sendRedirect("login.jsp?registerSuccess=true");
            } else {
                request.setAttribute("error", "Registration failed. Email may already be in use.");
                request.getRequestDispatcher("view/register.jsp").forward(request, response);
            }
        } catch (RuntimeException e) {
            request.setAttribute("error", "Registration failed: " + e.getMessage());
            request.getRequestDispatcher("view/register.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("view/register.jsp").forward(request, response);
    }
}