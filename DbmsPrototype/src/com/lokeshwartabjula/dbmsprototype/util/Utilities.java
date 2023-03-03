package com.lokeshwartabjula.dbmsprototype.util;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

import com.lokeshwartabjula.dbmsprototype.RecordsContainer;

public class Utilities implements UtilitiesInterface{

	@Override
	public RecordsContainer readRecordsFromFile(String fileName) throws FileNotFoundException {
		// TODO Auto-generated method stub
		RecordsContainer recordsContainer =  new RecordsContainer();
		Scanner fileScanner = new Scanner(new File(fileName));
	    List<List<String>> recordList = new ArrayList<>();
		String tempLine = null;
		Integer noOfRecords=0;
		while(fileScanner.hasNextLine()) {
			tempLine = fileScanner.nextLine();
//			System.out.println("Log : tempLine is"+tempLine);
			Scanner recordScanner = new Scanner(tempLine);
			recordScanner.useDelimiter("-");
			List<String> oneRecord = new ArrayList<String>();
			while(recordScanner.hasNext()) {
				oneRecord.add(recordScanner.next());
			}
			recordScanner.close();
			noOfRecords++;
			recordList.add(oneRecord);
		}
		recordsContainer.setNoOfRecords(noOfRecords);
		recordsContainer.setRecordsList(recordList);
		return recordsContainer;
	}

	@Override
	public void printRecordsToFile(RecordsContainer recordsContainer, String fileName) {
		// TODO Auto-generated method stub
		try {
			FileWriter recordWriter = new FileWriter(fileName);
			for(List<String> record : recordsContainer.getRecordsList()) {
				for(String cell : record) {
					recordWriter.write(cell);
				}
				recordWriter.write(System.lineSeparator());
			}
			recordWriter.close();

		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}
	
	public void updateRecordInFile(FileUpdateInfo fileUpdateInfo) throws IOException {
		File fileInstance = new File(fileUpdateInfo.getFileName());
		FileReader fileReader = new FileReader(fileInstance);
		BufferedReader bufferedReader = new BufferedReader(fileReader);
		Integer currentLineNumber=1;
		String tempLine=null;
		String newFileContent = null;
		
		while((tempLine = bufferedReader.readLine()) != null) {
			switch(fileUpdateInfo.getUpdateStrategy()) {
			case 1: //WHEN LINE NUMBER AND WORD REPLACEMENT IS GIVEN EG: CREATE DATABASE SCNEARO
				if(currentLineNumber == fileUpdateInfo.getLineNo()) {
					tempLine = tempLine.replaceFirst(fileUpdateInfo.getOldWord(), fileUpdateInfo.getNewWord());
				}
				newFileContent += tempLine + "\n";
				currentLineNumber++;
				break;
			case 2:
				break;
			case 3:
				break;
			}	
			
			
		}
		
		FileWriter fileWriter = new FileWriter(fileInstance);
		fileWriter.write(newFileContent);
		fileWriter.close();
		bufferedReader.close();
	}

}
