<%-- 
    Document   : account
    Created on : 9 Jul, 2018, 12:12:48 PM
    Author     : tushar
--%>

<%@page import = "java.sql.*"%>
<%@page import = "javax.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home | <% String email = request.getParameter("email");
                Class.forName("com.mysql.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/contacts","tushtiw97","tushar1997");
                Statement statement = conn.createStatement();
                ResultSet resultSet = statement.executeQuery("select name, last from user where email like \'" + email + "\'");
                while(resultSet.next()){
                    out.println(resultSet.getString(1) + " " + resultSet.getString(2));
                }
            %>
        </title>
    </head>
    <body>
        <h1>This is your main account page</h1>
        <br>
        <%
            statement = conn.createStatement();
            resultSet = statement.executeQuery("select count(distinct(contact_id)) from contact where user_id in (select id from user where email like \'" + email + "\')");
            int flag = 0;
            while(resultSet.next()){
                if((Integer.parseInt(resultSet.getString(1))) == 0){
                    out.println("<p>Sorry, it seems like you have no contacts added.</p>");
                }
                else {
                    flag = 1;
                }
            }
            if(flag == 1){
                statement = conn.createStatement();
                resultSet = statement.executeQuery("select email from user where id in (select contact_id from contact where user_id in (select id from user where email like \'" + email + "\'))");
                out.println("<p>Please select a contact to view the details</p>");
                while(resultSet.next()){
                    out.println("<p><a href=\"view-datails.jsp?cont= " + resultSet.getString(1) + "\">" + resultSet.getString(1) + "</p>");
                }
            }
            Class.forName("com.mysql.jdbc.Driver");
            //java.sql.Connection testConnection = DriverManager.getConnection("jdbc:mysql://db4free.net:3306/contacts","tushtiw97","tushar1997");
            /*Statement testStatement = testConnection.createStatement();
            ResultSet testResultSet = testStatement.executeQuery("select name, lastname from `user`");
            while(testResultSet.next()){
                out.println(testResultSet.getString("name") + " " + testResultSet.getString("lastname"));
            }*/
        %>
    </body>
</html>
