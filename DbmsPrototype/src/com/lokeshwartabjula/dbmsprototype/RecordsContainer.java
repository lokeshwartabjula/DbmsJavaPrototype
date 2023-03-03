package com.lokeshwartabjula.dbmsprototype;

import java.util.ArrayList;
import java.util.List;

public class RecordsContainer {
	
	List<List<String>> recordsList;
	Integer noOfRecords;
	
	
	public List<List<String>> getRecordsList() {
		return recordsList;
	}
	public void setRecordsList(List<List<String>> recordsList) {
		this.recordsList = recordsList;
	}
	public Integer getNoOfRecords() {
		return noOfRecords;
	}
	public void setNoOfRecords(Integer noOfRecords) {
		this.noOfRecords = noOfRecords;
	}
	
	public RecordsContainer addNewRecord(UserInfo newUser, RecordsContainer recordList) {
//		System.out.println("log: Adding the new record from the user");
		List<String> newRecord = new ArrayList<String>();
		newRecord.add(Integer.toString(recordList.getNoOfRecords()+1)); newRecord.add("-");
		newRecord.add(newUser.getFirstName()); newRecord.add("-");
		newRecord.add(newUser.getLastName()); newRecord.add("-");
		newRecord.add(newUser.getUserName()); newRecord.add("-");
		newRecord.add(newUser.getPassword()); newRecord.add("-");
		newRecord.add(newUser.getQuestion()); newRecord.add("-");
		newRecord.add(newUser.getAnswer()); newRecord.add("-");
		newRecord.add("DATABASE_NAME"); newRecord.add("-");
		recordList.getRecordsList().add(newRecord);
		return recordList;
	}

}
