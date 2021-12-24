<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style>
.chart-container{
background-color : #fff;
 display : inline-block;
 border : 1px solid #333;
 width: 500px;
 height: 500px;
}
</style>

<main class=" bg-secondary bg-opacity-10">
	<h1>Dashboard</h1>
	<div class="body-container">
	    <div class="body-main">
	    	<div class="dashboard container-fluid">
			<div class="population-flow p-2 align-center text-center">
			    <div class="row bg-pop-row bg-gradient p-3 text-white" style="background-color: rgb(0,64,128)">
			        <div class="col-lg-3">
			            <div class="population_analysis">
			                <h4>누적 총 접속자</h4>
			                <h3><span class="counter">${totalCount}</span> </h3>
			                <div class="d-flex">
			                    <span>Total</span>
			                </div>
			            </div>
			        </div>

			        <div class="col-lg-3">
			            <div class="population_analysis">
			                <h4>오늘 구매된 쿠키</h4>
			                <h3><span class="counter">0</span></h3>
			                <div class="d-flex">
			                    <span>Today Cookie</span>
			                </div>
			            </div>
			        </div>
			    </div>
			</div>
				<div class="chart-box row justify-content-center">
					<div class="chart-container p-0 m-3" id="bar1"></div>
					<div class="chart-container p-0 m-3" id="circle1"></div>
					<div class="chart-container p-0 m-3" id="distribution"></div>
				</div>
			</div>
		</div>
	</div>
</main>