package sis.com.dao;

import java.util.Date;
import java.util.List;

import sis.com.bo.Worker;


public interface WorkerDao {
	
		
		//send data without id and after success it come with id
	   Worker addWorker(Worker worker);
	  
	  boolean updateWorker(Worker worker);  
	  boolean deleteWorker(long id);
	  List<Worker> getAllWorkers();
	  List<Worker> getAllWorkersById(String name);
	 Worker getWorkerById(long id);

		boolean insertAttendances(long workerId, int status, java.sql.Date date);
		boolean updateAttendances(long workerId,java.sql.Date date,int attendance);

	 
	 

	

}
