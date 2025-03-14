<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Retrieve the user's role from the session
    String role = (String) session.getAttribute("role");

    // Invalidate the session
    session.invalidate();

    // Redirect based on the user's role
    if ("customer".equals(role)) {
        response.sendRedirect("customerLogin.jsp");
    } else if ("driver".equals(role)) {
        response.sendRedirect("driverLogin.jsp");
    } else if ("admin".equals(role)) {
        response.sendRedirect("adminLogin.jsp");
    } else {
        // Default redirect if role is not set
        response.sendRedirect("index.jsp");
    }
%>