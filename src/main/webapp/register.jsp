<%-- 
    Document   : register
    Created on : 4 Jul, 2018, 2:35:30 PM
    Author     : tushar
--%>

<%@page import="com.mongodb.client.MongoCursor"%>
<%@page import="com.mongodb.client.MongoIterable"%>
<%@page import="org.bson.Document"%>
<%@page import="com.mongodb.client.MongoCollection"%>
<%@page import="com.mongodb.client.MongoDatabase"%>
<%@page import="com.mongodb.client.MongoClients"%>
<%@page import="com.mongodb.client.MongoClient"%>
<%@page import="org.jvoicexml.jsapi2.synthesis.freetts.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import = "java.sql.*" %>
<%@page import = "javax.sql.*" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Contacts | Register</title>
    </head>
    <body>
        <%
            if(request.getParameter("registered").equals("false")){
                out.println("<form action=\"register.jsp\"><input type=\"text\" name=\"fname\" value=\"\" required/><br><Br><input type=\"text\" name=\"mname\" value=\"\" /><br><Br><input type=\"text\" name=\"lname\" value=\"\" required/><br><Br><input type=\"number\" name=\"number\" value=\"\" required/><br><Br><input type=\"email\" name=\"email\" value=\"\" required/><br><Br><input type=\"hidden\" name=\"registered\" value=\"true\" /><br><Br><input type=\"submit\" value=\"Submit & Register\" name=\"registerButton\" /></form>");
            }
            else {
                Class.forName("com.mysql.jdbc.Driver");
                java.sql.Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/contacts","tushtiw97","tushar1997");
                Statement s = conn.createStatement();
                int result = s.executeUpdate("insert into user (name, middle, last, primary_number, email) values (\'" + request.getParameter("fname") + "\',\'" + request.getParameter("mname") + "\',\'" + request.getParameter("lname") + "\',\'" + request.getParameter("number") + "\',\'" + request.getParameter("email") + "\')");
                if(result > 0){
                    out.println("You have been successfully registered!<br>");
                    MongoClient mongoClient = MongoClients.create("mongodb://tushtiw97:tushar1997@localhost:27017/trial");
                    MongoDatabase mongoDatabase = mongoClient.getDatabase("trial");
                    MongoCollection<Document> mongoCollection = mongoDatabase.getCollection("trial");
                    MongoCursor<Document> mongoCursor = mongoCollection.find().iterator();
                    try{
                        while(mongoCursor.hasNext()){
                            out.println(mongoCursor.next().toJson());
                        }
                    }catch(Exception e){
                        out.println(e.getMessage());
                    }
                    Document document = new Document("name","itachi").append("last", "uchiha");
                    try{
                        mongoCollection.insertOne(document);
                    }catch(Exception e){
                        out.println(e.getMessage());
                    }
                }
                else {
                    out.println("There was some error in registering you. Please try again, or contact us to help you assist");
                }
            }
        %>
        <p>Go back to<a href="login.jsp">login</a> page</p>
    </body>
</html>
