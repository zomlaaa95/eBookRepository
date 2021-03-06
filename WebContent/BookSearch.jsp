<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    

<script type="text/javascript" src="js/validation.js"></script>

<c:choose>
    <c:when test="${sessionScope.subscriber != null}">
    	<c:set var="location" scope="page" value="MenuSubscriberServlet"/>	
    </c:when>
    <c:when test="${sessionScope.admin != null}">
    	<c:set var="location" scope="page" value="MenuAdminServlet"/>		
    </c:when>
    <c:otherwise>
    	<c:set var="location" scope="page" value="MenuVisitorServlet"/>		
    </c:otherwise>
</c:choose>

<jsp:useBean id="languages" type="java.util.List" scope="request"/>
<jsp:useBean id="user" type="java.lang.String" scope="request"/>
<jsp:useBean id="userCategory" type="java.lang.Integer" scope="request"/>

<c:set var="language" value="${sessionScope.language}"/>
<c:if test="${language==null}">
	<c:set var="language" value="en" scope="session"/>
</c:if>
<fmt:setLocale value="${language}"/>
<fmt:setBundle basename="messages.messages"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><fmt:message key="pretragaKnjiga"/></title>
</head>
<body>

<h1><fmt:message key="pretragaKnjiga"/></h1>
</br>

<form name="form" action="BookSearchServlet" method="post" onsubmit="return searchValidation()">
	<table border="1">
	<tr>
		<th><fmt:message key="kriterijum"/></th>
		<th><fmt:message key="vrednost"/></th>
		<th><fmt:message key="x"/></th>
	</tr>
	<tr>
		<td><label id="titleError"><fmt:message key="pretragaPoNaslovu"/></label></td>
		<td><input type="text" name="title" maxLength="80"/></td>
		<td><input type="checkbox" name="title_checkbox"/></td>
	</tr>
	<tr>
		<td><label id="authorError"><fmt:message key="pretragaPoAutoru"/></label></td>
		<td><input type="text" name="author" maxLength="120"/></td>
		<td><input type="checkbox" name="author_checkbox"/></td>
	</tr>
	<tr>
		<td><label id="keywordError"><fmt:message key="pretragaPoKljucnimRecima"/></label></td>
		<td><input type="text" name="keyword" maxLength="120"/></td>
		<td><input type="checkbox" name="keyword_checkbox"/></td>
	</tr>
	<tr>
		<td><label id="contentError"><fmt:message key="pretragaPoSadrzaju"/></label></td>
		<td><input type="text" name="content" maxLength="100"/></td>
		<td><input type="checkbox" name="content_checkbox"/></td>
	</tr>
	<tr>
		<td><fmt:message key="pretragaPoJeziku"/></td>
		<td>
			<select name="languageSelect">
    			<c:forEach var="i" items="${ languages }">
     				<option value="${ i.languageId }">${ i.languageName }</option>
    			</c:forEach>
			</select>
		</td>
		<td><input type="checkbox" name="language_checkbox"/></td>
	</tr>
</table>

<button type="submit"><fmt:message key="ok"/></button>

</form>

</br>


<a href="${ location }"><fmt:message key="pocetna"/></a>
<c:if test="${sessionScope.admin != null || sessionScope.subscriber != null}">
    <a href="LogoutServlet"><fmt:message key="odjava"/></a>
</c:if>

</body>
</html>