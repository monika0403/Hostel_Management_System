package sis.com.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import sis.com.bo.*;
import sis.com.dao.*;
import sis.com.daoFactory.*;
import sis.com.util.*;


public class WorkerAttendanceController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
   
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		Connection con=null;
		ResultSet rs=null;
		HttpSession session = request.getSession();
		long workerId=0L;
		Calendar cal1 = Calendar.getInstance();
		Date today = cal1.getTime();
		java.sql.Date sqlToday = new java.sql.Date(today.getTime());
		
		Map<String,String> attendanceMap = new HashMap<String,String>();
		WorkerDao sDao = DaoFactory.getWorkerDao();
		List<Worker> l = sDao.getAllWorkers();
		boolean inserted=false;
		for(Worker s:l) {
			workerId=s.getId();
			int status = Integer.parseInt(request.getParameter(""+workerId));
			System.out.println("workerId "+workerId+"  status-"+status);
			inserted=sDao.insertAttendances(workerId, status, sqlToday);
			if(!inserted)
				break;
			attendanceMap.put(workerId+"", status+"");
		}//for
		if(!inserted) {
			session.setAttribute("alreadyFilled", true);
			response.sendRedirect("WorkerAttendence.jsp");
		}else {
		try {
			//---getting absent leave and present, the sql part
			String presentSql ="select count(workerId) as result from workerattendence where STATUS=1 and TODAY=?";
			int present = 0;
			PreparedStatement pstmtPresent = con.prepareStatement(presentSql);
			pstmtPresent.setDate(1,sqlToday);
			rs = pstmtPresent.executeQuery();
			while(rs.next())
				present = rs.getInt("result");
			
			
			rs=null;
			int absent = 1;
			String absentSql="select count(workerId) as result from workerattendence where STATUS=0 and TODAY=?";
			PreparedStatement pstmtAbsent = con.prepareStatement(absentSql);
			pstmtAbsent.setDate(1,sqlToday);
			rs = pstmtAbsent.executeQuery();
			while(rs.next())
				absent = rs.getInt("result");
			
			
			rs=null;
			int leave = 0;
			String leaveSql="select count(workerId) as result from workerattendence where STATUS=2 and TODAY=?";
			PreparedStatement pstmtLeave = con.prepareStatement(leaveSql);
			pstmtLeave.setDate(1,sqlToday);
			rs = pstmtLeave.executeQuery();
			while(rs.next())
				leave = rs.getInt("result");
			
			
			//---end----getting absent leave and present, the sql part
			session.setAttribute("present", present+"");
			session.setAttribute("absent", absent+"");
			session.setAttribute("leave", leave+"");
			
			session.setAttribute("attendanceList", l);
			session.setAttribute("attendanceMap", attendanceMap);
			
			String url="attendance_submitted.jsp";
			response.sendRedirect(url);
		}catch(Exception e) {
			e.printStackTrace();
			session.setAttribute("alreadyFilled", true);
			response.sendRedirect("WorkerAttendence.jsp");
		}
		}

	}

}
