<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal" var="principal" />
</sec:authorize>

<!DOCTYPE html>
<html lang="en">
<head>
<title>baeg-won's blog</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.js"></script>
<link href="/css/index.css" rel="stylesheet" type="text/css">
<link href="/css/header.css" rel="stylesheet" type="text/css">
<script src="https://kit.fontawesome.com/2804b86193.js" crossorigin="anonymous"></script>
<style>
@import url(//fonts.googleapis.com/earlyaccess/nanumgothic.css);

body {
	font-family: 'Nanum Gothic', sans-serif;
}
</style>
</head>
<body>
	<nav class="navbar navbar-expand-md bg-dark navbar-dark">
		<a class="navbar-brand" href="/"><i class="fa-solid fa-house"></i> Home</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#collapsibleNavbar">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="collapsibleNavbar">
			<c:choose>
				<c:when test="${empty principal}">
					<ul class="navbar-nav">
						<li class="nav-item"><a class="nav-link" href="/auth/loginForm"><i class="fa-solid fa-right-to-bracket"></i> Sign in</a></li>
						<li class="nav-item"><a class="nav-link" href="/auth/joinForm"><i class="fa-solid fa-user-plus"></i> Sign up</a></li>
					</ul>
				</c:when>
				<c:otherwise>
					<ul class="navbar-nav">
						<li class="nav-item"><a class="nav-link" href="/user/updateForm"><i class="fa-solid fa-user"></i> Profile</a></li>
						<li class="nav-item"><a class="nav-link" href="/logout"><i class="fa-solid fa-right-from-bracket"></i> Sign out</a></li>
					</ul>
				</c:otherwise>
			</c:choose>
		</div>
		<c:if test="${fn:length(alarms) > 0}">
			<div class="dropdown">
				<div style="color: white; position:relative;" class="btn dropdown" data-toggle="dropdown">
					<i class="fa-solid fa-bell"></i>
					<c:set var="alarm_count" value="0" />
					<c:forEach var="alarm" items="${alarms}">
						<c:if test="${!alarm.alarm_confirm_state}">
							<c:set var="alarm_count" value="${alarm_count + 1}" />
						</c:if>
					</c:forEach>
					<c:if test="${alarm_count > 0}">
						<span class="nav-counter">${alarm_count}</span>
					</c:if>
				</div>
				<div class="dropdown-menu dropdown-menu-right alarm-box">
					<span class="alarm-new">새소식&nbsp;&nbsp;</span><span class="alarm-count">${alarm_count}</span>
					<c:forEach var="alarm" items="${alarms}">
						<div class="dropdown-item alarm" onclick="alarmConfirm(${alarm.id}, ${alarm.board.id})" 
							<c:if test="${alarm.alarm_confirm_state}">, style="background-color: whiteSmoke;"</c:if>
						>
							<span style="float: right;">${alarm.createDate}</span>
							<span>
								<div class="alarm-content"><span class="alarm-username">${alarm.user.nickname}</span><span>님이 댓글을 남겼습니다.</span></div>
								<div class="alarm-content">${alarm.content}</div>
								<div class="alarm-content alarm-title">${alarm.board.title}</div>
							</span>
						</div>
					</c:forEach>
				</div>
			</div>
		</c:if>
	</nav>
	<br>
	
<script src="/js/alarm.js"></script>