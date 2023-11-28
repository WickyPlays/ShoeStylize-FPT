package com.group7.tomcat.shoestylize.servlet.database;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.io.InputStream;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DBContext {
    public static Connection connection;

    static {
        try {
            Class.forName("org.postgresql.Driver");
            Context initContext = new InitialContext();
            Context envContext = (Context) initContext.lookup("java:/comp/env");
            DataSource dataSource = (DataSource) envContext.lookup("jdbc/ShoeStylize_G7");

            connection = dataSource.getConnection();
        } catch (ClassNotFoundException | SQLException | NamingException e) {
            e.printStackTrace();
            throw new RuntimeException("Failed to establish a database connection");
        }
    }

    public static int executeUpdate(String query, Object... args) {
        PreparedStatement preparedStatement = null;
        try {
            preparedStatement = connection.prepareStatement(query);
            for (int i = 0; i < args.length; i++) {
                preparedStatement.setObject(i + 1, args[i]);
            }
            return preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("SQL execution failed");
        } finally {
            if (preparedStatement != null) {
                try {
                    preparedStatement.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    public static List<DBObject> executeQuery(String query, Object... args) {
        List<DBObject> list = new ArrayList<>();
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        DBObject dbObj;
        try {
            preparedStatement = connection.prepareStatement(query);
            for (int i = 0; i < args.length; i++) {
                if (args[i] instanceof InputStream) {
                    preparedStatement.setBinaryStream(i + 1, (InputStream) args[i]);
                } else {
                    preparedStatement.setObject(i + 1, args[i]);
                }
            }
            resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                list.add(new DBObject(resultSet));
            }
        } catch (SQLException e) {
            e.printStackTrace();
            dbObj = new DBObject();
        } finally {
            if (resultSet != null) {
                try {
                    resultSet.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (preparedStatement != null) {
                try {
                    preparedStatement.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
        return list;
    }

    public static void close() {
        try {
            if (connection != null) {
                connection.close();
                System.out.println("Database connection closed.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
