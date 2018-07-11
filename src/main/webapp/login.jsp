<%-- 
    Document   : login
    Created on : 4 Jul, 2018, 2:27:12 PM
    Author     : tushar
--%>

<%@page import="com.mongodb.client.MongoCursor"%>
<%@page import="com.mongodb.MongoCredential"%>
<%@page import="com.mongodb.client.MongoCollection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%@page import = "java.sql.*" %>
<%@page import = "javax.sql.*" %>
<%@page import = "com.mongodb.ConnectionString" %>
<%@page import = "com.mongodb.client.MongoClients" %>
<%@page import = "com.mongodb.client.MongoClient" %>
<%@page import = "com.mongodb.client.MongoDatabase" %>
<%@page import = "org.bson.Document" %>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Contacts | Login to your account</title>
    </head>
    <body>
        <%
            if(request.getParameter("loggedIn").equals("false")){
                out.println("<form action=\"account.jsp\" method=\"POST\"><input type=\"email\" name=\"email\" placeholder=\"Enter email\" /><br><br><input type=\"number\" name=\"number\" placeholder=\"Enter name\" /><br><br><input type=\"hidden\" name=\"loggedIn\" value=\"true\" /><input type=\"submit\" value=\"Submit & Proceed\" name=\"submit\" /></form>");
                out.println("--------------------------------------------<br><br>");
                out.println("<i>Not a member yet ? Just </i><a href=\"register.jsp?registered=false\">Register</a><i> with us, and enjoy the availability of your contacts anywhere and everywhere</i>");
            }
            else {
                Class.forName("com.mysql.jdbc.Driver");
                java.sql.Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/contacts","tushtiw97","tushar1997");
                Statement statement = conn.createStatement();
                String email = request.getParameter("email");
                String number = request.getParameter("number");
                ResultSet resultSet = statement.executeQuery("select primary_number from user where email like \'" + email + "\'");
                resultSet.next();
                if(resultSet.getString(1).equals(number)){
                    out.println("This is your main account page");
                    conn.close();
                    Class.forName("com.mysql.jdbc.Driver");
                    /*java.sql.Connection */conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/contacts","tushtiw97","tushar1997");
                    
                    /*Statement */statement = conn.createStatement();
                    /*ResultSet */resultSet = statement.executeQuery("select name, last from user where email like \'" + email + "\'");
                    
                    MongoCredential credential = MongoCredential.createCredential("tushtiw97","trial","tushar1997".toCharArray());
                    
                    out.println("Credential :: " + credential);
                    
                    MongoClient mongoClient = MongoClients.create("mongodb://tushtiw97:tushar1997@localhost:27017/trial");
                    
                    out.println("Connected");
                    
                    MongoDatabase mongoDatabase = mongoClient.getDatabase("trial");
                    
                    out.println("Connected to database");
                    
                    MongoCollection<Document> mongoCollection = mongoDatabase.getCollection("trial");
                    
                    //resultSet = statement.executeQuery("select name, last from user where email like \'" + email + "\'");
                    resultSet.next();
                    
                    //Document document = new Document("name",resultSet.getString(1)).append("lastname",resultSet.getString(2));
                    
                    //mongoCollection.insertOne(document);
                    
                    out.println("Your name and lastname have been inserted into the new database");
                    //out.println("Credentials :: " + credential);*/
                    
                    MongoCursor<Document> mongoCursor = mongoCollection.find().iterator();
                    try {
                        while(mongoCursor.hasNext()){
                            out.println(mongoCursor.next().toJson());   
                        }
                    }
                    catch(Exception e){
                        out.println(e.getMessage());
                    }
                    
                }
                else {
                    out.println("Login error.");
                    Thread.sleep(5000);
                    out.println("<a href=\"login.jsp?loggedIn=false\">Try again</a>");
                }
            }
        %>
    </body>
</html>
