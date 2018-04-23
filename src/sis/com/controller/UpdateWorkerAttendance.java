package sis.com.controller;

import java.io.IOException;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import sis.com.dao.AdminDao;
import sis.com.dao.WorkerDao;
import sis.com.daoFactory.DaoFactory;

/**
 * Servlet implementation class UpdateWorkerAttendance
 */
public class UpdateWorkerAttendance extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Long workerId;
		Integer attendance=null;
		HttpSession session = request.getSession();
		Boolean updated = false;
		java.sql.Date date = new java.sql.Date(System.currentTimeMillis());
		if(request.getParameter("hostelId")!=null 
				&& request.getParameter("attendance")!=null 
				&& request.getParameter("hostelId").trim().equalsIgnoreCase("")==false) {
			try {
				workerId=Long.parseLong(""+request.getParameter("hostelId"));
				attendance=Integer.parseInt(request.getParameter("attendance"));
				WorkerDao adminDao = DaoFactory.getWorkerDao();
				updated=adminDao.updateAttendances(workerId,date,attendance);
				if(updated==true) {
					session.setAttribute("updatedAttendance", updated);//true
				}else {
					session.setAttribute("updatedAttendance", updated);//false
				}
				response.sendRedirect("student_attendance.jsp");
			}catch(NumberFormatException e) {
				System.out.println("Number format exception in UpdateAttendance ");
				session.setAttribute("inputError", true);//true
				response.sendRedirect("student_attendance.jsp");
			}//catch
		}//if
		else {
			session.setAttribute("inputError", false);//false
			response.sendRedirect("student_attendance.jsp");
		}//else
	}//doGet


}
