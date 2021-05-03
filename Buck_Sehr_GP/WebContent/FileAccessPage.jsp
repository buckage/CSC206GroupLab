<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Employee File Access</title>
		<style>
			body {
  				background-color: dodgerblue;
			}
			
			table {
  				font-family: arial, sans-serif;
  				border-collapse: collapse;
 				width: 100%;
			}

			td, th {
				 border: 1px solid #dddddd;
				 text-align: left;
				 padding: 8px;
			}

			.button {
  				background-color: red;
			  	border: none;
				color: white;
				padding: 3px 10px;
				text-align: center;
				text-decoration: none;
				display: inline-block;
				font-size: 20px;
				font-family: consolas;
				margin: 4px 2px;
				cursor: pointer;
			}

			h2{
				color: white;
  				font-family: consolas;
  				font-size: 30px;
			}
			
			footer, header {
  				color: white;
  				font-family: consolas;
  				text-align: center;
  				font-size: 20px;
			}
			
			p, a, h1, h2, h3{
				color: white;
  				font-family: consolas;
  				font-size: 20px;
			}
		</style>
	
	</head>
	<body>	
		<h1>You are logged in as <%=request.getParameter("employeeEmail")%>!<br>
		</h1>
		<h2><b>Folders</b></h2>
		<%@ page import="java.io.File" %>
		
		<% 
		/*
		 * Precondition:   The employee logging in has "stockRead" permissions and those are included in their request.
		 * Postcondition:  The employee can see the file trees they have permissions for and access those files.
		 */
		if(Boolean.TRUE == request.getAttribute("stockRead")) { 
			// if the requester has read permissions enabled for stocks, continue
			%>
			<h3>Stocks:</h3>
			<ul>
			<%
			
			// get the file path to the stocks folder
			//String foldersPath = getServletContext().getRealPath("/")+"/WEB-INF/employeeFolders/stocksFolder/";
			String foldersPath = "/Users/robertbuck/eclipse-workspace/Buck_Sehr_GP/WebContent/WEB-INF/employeeFolders/stocksFolder/";
			// get a list of the contents of the stocks folder 
			File folder = new File(foldersPath);
			String [] fileNames = folder.list();
			File [] folderItems = folder.listFiles();
			
			// display the files the requester has permissions to view
			if(folderItems != null){
	
				for (int i =0; i <folderItems.length; i++) {
	
					if (!folderItems[i].isDirectory()) {
						String filePath = foldersPath + fileNames[i];
						%>
						<li><a HREF="file://<%= filePath %>"><%= fileNames[i] %> </a></li> <%
						}
					}
				}
			 %>
			</ul>	
	<% 
	}
		/*
		 * Precondition:   The employee logging in has "bondRead" permissions and those are included in their request.
		 * Postcondition:  The employee can see the file trees they have permissions for and access those files.
		 */
		if(Boolean.TRUE == request.getAttribute("bondRead")) { 
			// if the requester has read permissions enabled for bonds, continue
			%>
			<h3>Bonds:</h3>
			<ul>
			<%
			
			// get the file path to the bonds folder
			String foldersPath = getServletContext().getRealPath("/")+"WEB-INF/employeeFolders/bondsFolder/";
			
			// get a list of the contents of the bonds folder
			File folder = new File(foldersPath);
			String [] fileNames = folder.list();
			File [] folderItems = folder.listFiles();
			
			// display the files the requester has permissions to view
			if(folderItems != null){
			
				for (int i =0; i <folderItems.length; i++) {
				
					if (!folderItems[i].isDirectory()) {
						String filePath = foldersPath + fileNames[i];
						%>
						<li><a HREF="file://<%= filePath %>"><%= fileNames[i] %> </a></li> <%
						}
					}
				}
			 %>
			</ul>	
	<% 
	}
		/*
		 * Precondition:   The employee logging in has "moneyRead" permissions and those are included in their request.
		 * Postcondition:  The employee can see the file trees they have permissions for and access those files.
		 */
		if(Boolean.TRUE == request.getAttribute("moneyRead")) { 
			// if the requester has read permissions enabled for money, continue
			%>
			<h3>Money:</h3>
			<ul>
			<%

			// get the file path to the money folder
			String foldersPath = getServletContext().getRealPath("/")+"WEB-INF/employeeFolders/moneyFolder/";

			// get a list of the contents of the money folder
			File folder = new File(foldersPath);
			String [] fileNames = folder.list();
			File [] folderItems = folder.listFiles();
			
			// display the files the requester has permissions to view
			if(folderItems != null){
			
				for (int i =0; i <folderItems.length; i++) {
				
					if (!folderItems[i].isDirectory()) {
						String filePath = foldersPath + fileNames[i];
						%>
						<li><a HREF="file://<%= filePath %>"><%= fileNames[i] %> </a></li> <%
						}
					}
				}
			 %>
			</ul>	
	<% 
	}
	%>	
		<p>

		</p>
		
	
		<footer>
  			<p>Group Project by Russell Buck and Ariel Sehr</p>
  			<p>CSC 206-0C1 - Spring 2021 - Temesvari</p>
		</footer>
	    
	</body>
</html>