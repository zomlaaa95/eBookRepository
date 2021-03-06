<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ page import="entities.BookLanguage" %>
<%@ page import="entities.Category" %>
<%@ page import="java.util.List" %>

<script type="text/javascript" src="js/validation.js"></script>

<c:if test="${sessionScope.admin == null}">
	<c:redirect url="MenuVisitorServlet"/>
</c:if>


<c:set var="language" value="${sessionScope.language}"/>
<c:if test="${language==null}">
	<c:set var="language" value="en" scope="session"/>
</c:if>
<fmt:setLocale value="${language}"/>
<fmt:setBundle basename="messages.messages"/>

<jsp:useBean id="eBookAddEdit" class="entities.Ebook" scope="request"/>
<jsp:useBean id="languages" type="java.util.List" scope="request"/>
<jsp:useBean id="categories" type="java.util.List" scope="request"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><fmt:message key="naslovProzora"/></title>
<link rel="icon" href="images/icon.png"></link>
</head>
<body>
	<c:choose>
		<c:when test="${ requestScope.action == 'add' }">
			<h1><fmt:message key="dodajKnjigu"/></h1>
			<c:set var="servlet" scope="page" value="BookAddServlet"/> 
		</c:when>
		<c:otherwise>
			<h1><fmt:message key="izmeniKnjigu"/></h1>
			<c:set var="servlet" scope="page" value="BookEditServlet?id=${eBookAddEdit.EBookid}"/>
		</c:otherwise>
	</c:choose>
	
	<form name="form" action="${ servlet }" method="post" enctype="multipart/form-data" onsubmit="return checkFile(${requestScope.action})">
		<table>
			<tr>
				<td><fmt:message key="naslov"/></td>
				<td><input type="text" maxlength="30" name="title" required="required" oninvalid="this.setCustomValidity('<fmt:message key="unesiteNazivKnjige"/>')" onchange="this.setCustomValidity('')" value="${eBookAddEdit.EBooktitle}"></td>
			</tr>
			<tr>
				<td><fmt:message key="autori"/></td>
				<td><input type="text" maxlength="30" name="author" required="required" oninvalid="this.setCustomValidity('<fmt:message key="unesiteNazivKnjige"/>')" onchange="this.setCustomValidity('')" value="${eBookAddEdit.EBookauthor}"></td>
			</tr>
			<tr>
				<td><fmt:message key="kljucneReci"/></td>
				<td><input type="text" maxlength="30" name="keywords" required="required" oninvalid="this.setCustomValidity('<fmt:message key="unesiteNazivKnjige"/>')" onchange="this.setCustomValidity('')" value="${eBookAddEdit.EBookkeywords}"></td>
			</tr>
			<tr>
				<td><fmt:message key="godinaIzdavanja"/></td>
				<td><input type="number" min="-1000" max="2500" name="publicationYear" required="required" oninvalid="this.setCustomValidity('<fmt:message key="unesiteNazivKnjige"/>')" onchange="this.setCustomValidity('')" value="${eBookAddEdit.EBookpublicationyear}"></td>
			</tr>
			<tr>
				<td><fmt:message key="jezik"/></td>
				<td>
					<select name="languageSelect">
						<c:forEach items="${ languages }" var="i">
							<c:choose>
								<c:when test="${ requestScope.action != 'add' && eBookAddEdit.EBooklanguage.languageId == i.languageId}">
									<option value="${ i.languageId }" selected="selected">${ i.languageName }</option>
								</c:when>
								<c:otherwise>
									<option value="${ i.languageId }">${ i.languageName }</option>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</select>
				</td>
			</tr>
			
			<tr>
				<td><fmt:message key="kategorija"/></td>
				<td>
					<select name="categorySelect">
						<c:forEach items="${ categories }" var="i">
							<c:choose>
								<c:when test="${ requestScope.action != 'add' && i.categoryId == eBookAddEdit.EBookcategory.categoryId }">
									<option value="${i.categoryId}" selected="selected">${ i.categoryName }</option>
								</c:when>
								<c:otherwise>
									<option value="${i.categoryId}">${ i.categoryName }</option>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</select>
				</td>
			</tr>
			
			<tr>
				<td><fmt:message key="fajl"/></td>
				<td><input type="file" name="fileUpload" accept="application/pdf"/></td>
			</tr>
			
			<tr>
				<td><input type="hidden" name="id" value="${eBookAddEdit.EBookid}"></td>
				<td><input type="submit" name="submit" value="<fmt:message key="ok"/>"></td>				
			</tr>
		</table>
	</form>
	
	<a href="MenuAdminServlet"><fmt:message key="pocetna"/></a>
	<a href="LogoutServlet"><fmt:message key="odjava"/></a>
</body>
</html>