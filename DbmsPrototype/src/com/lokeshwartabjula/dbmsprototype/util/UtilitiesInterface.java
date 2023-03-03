package com.lokeshwartabjula.dbmsprototype.util;

import java.io.FileNotFoundException;
import java.io.IOException;

import com.lokeshwartabjula.dbmsprototype.RecordsContainer;

public interface UtilitiesInterface {
	
	RecordsContainer readRecordsFromFile(String fileName) throws FileNotFoundException;
	
	void printRecordsToFile(RecordsContainer recordsContainer, String fileName);
	
	public void updateRecordInFile(FileUpdateInfo fileUpdateInfo) throws IOException;
}
