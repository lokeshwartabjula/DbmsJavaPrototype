package com.lokeshwartabjula.dbmsprototype.query;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Scanner;

public class QueryParsers {
	
	public void processCreateTableQuery(String createTableQuery, String userName) {
		Scanner scanner = new Scanner(System.in);

        // Get the CREATE TABLE query from the user
//        System.out.print("Enter the CREATE TABLE query: ");
//        String createTableQuery = scanner.nextLine();

        // Parse the query to get the table name and column names
        String[] tokens = createTableQuery.split("\\s+");
        String tableName = tokens[2] + "_by_" + userName;
        String columns = createTableQuery.substring(createTableQuery.indexOf("(") + 1, createTableQuery.indexOf(";")-1);

        // Create an arraylist of column names
        ArrayList<String> columnNames = new ArrayList<String>();
        String[] columnTokens = columns.split(",");
        for (String columnToken : columnTokens) {
            String columnName = columnToken.trim().split("\\s+")[0];
            columnNames.add(columnName);
        }

        // Create a file with the table name as the file name and write the column names to the file
        try {
            FileWriter fileWriter = new FileWriter(tableName + ".txt");
            for (String columnName : columnNames) {
                fileWriter.write(columnName + "-");
            }
            fileWriter.close();
            System.out.println("Table created successfully.");
        } catch (IOException e) {
            System.out.println("An error occurred while creating the table.");
            e.printStackTrace();
        }

        scanner.close();
    }
	
	public void processInsertQuery(String insertQuery, String userName) {
		Scanner scanner = new Scanner(System.in);

        // Get the INSERT query from the user
//        System.out.print("Enter the INSERT query: ");
//        String insertQuery = scanner.nextLine();

        // Parse the query to get the table name and column values
        String[] tokens = insertQuery.split("\\s+");
        String tableName = tokens[2] + "_by_" + userName;
        String values = insertQuery.substring(insertQuery.indexOf("(") + 1, insertQuery.indexOf(")"));

        // Create an arraylist of column values
        ArrayList<String> columnValues = new ArrayList<String>();
        String[] valueTokens = values.split(",");
        for (String valueToken : valueTokens) {
            String columnValue = valueToken.trim();
            columnValues.add(columnValue);
        }

        // Write the column values to the file
        try {
            FileWriter fileWriter = new FileWriter(tableName + ".txt", true);
            fileWriter.write("\n");
            for (String columnValue : columnValues) {
                fileWriter.write(columnValue + "-");
            }
            fileWriter.close();
            System.out.println("Data inserted successfully.");
        } catch (IOException e) {
            System.out.println("An error occurred while inserting the data.");
            e.printStackTrace();
        }

        scanner.close();
	}
	
	public void processUpdateQuery(String updateQuery, String userName) {
		
		Scanner scanner = new Scanner(System.in);

        // Get the UPDATE query from the user
//        System.out.print("Enter the UPDATE query: ");
//        String updateQuery = scanner.nextLine();

        // Parse the query to get the table name, set values and where condition
        String[] tokens = updateQuery.split("\\s+");
        String tableName = tokens[1]+ "_by_" + userName;
        String setValues = updateQuery.substring(updateQuery.indexOf("SET") + 4, updateQuery.indexOf("WHERE")).trim();
        String whereCondition = updateQuery.substring(updateQuery.indexOf("WHERE") + 6).trim();

        // Create an arraylist of set values
        ArrayList<String> setValuesList = new ArrayList<String>();
        String[] setTokens = setValues.split(",");
        for (String setToken : setTokens) {
            String setValue = setToken.trim();
            setValuesList.add(setValue);
        }

        // Create a hashmap of where conditions
        String[] whereTokens = whereCondition.split("\\s+");
        String whereColumnName = whereTokens[0];
        String whereOperator = whereTokens[1];
        String whereValue = whereTokens[2];

        // Update the matching rows in the file
        try {
            File file = new File(tableName + ".txt");
            Scanner fileScanner = new Scanner(file);
            ArrayList<String> fileContents = new ArrayList<String>();
            while (fileScanner.hasNextLine()) {
                String line = fileScanner.nextLine();
                String[] lineTokens = line.split("-");
                if (lineTokens[0].equalsIgnoreCase(whereValue)) {
                    for (String setValue : setValuesList) {
                        String[] setValueTokens = setValue.split("=");
                        String columnName = setValueTokens[0].trim();
                        String columnValue = setValueTokens[1].trim();
                        int columnIndex = getColumnIndex(columnName, fileContents.get(0));
                        lineTokens[columnIndex] = columnValue;
                    }
                }
                fileContents.add(String.join("-", lineTokens));
            }
            fileScanner.close();

            FileWriter fileWriter = new FileWriter(tableName + ".txt");
            for (String line : fileContents) {
                fileWriter.write(line + "\n");
            }
            fileWriter.close();
            System.out.println("Data updated successfully.");
        } catch (FileNotFoundException e) {
            System.out.println("The specified file does not exist.");
            e.printStackTrace();
        } catch (IOException e) {
            System.out.println("An error occurred while updating the data.");
            e.printStackTrace();
        }

        scanner.close();
		
	}
	
	// Helper function to get the index of a column in a row of the file contents
    private static int getColumnIndex(String columnName, String firstLine) {
        String[] columnNames = firstLine.split("-");
        for (int i = 0; i < columnNames.length; i++) {
            if (columnNames[i].equalsIgnoreCase(columnName)) {
                return i;
            }
        }
        return -1;
    }

	

}
