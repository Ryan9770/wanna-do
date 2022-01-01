<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style>
.chart-container{
background-color : #fff;
 display : inline-block;
 border : none;
 min-width: 300px;
 height: 400px; 
}

.body-container{
	background-color: transparent;
}

.refund{
	margin: 20px;
}

.refund tr td{
	font-size: 17px;
}
</style>

<main class=" bg-secondary bg-opacity-10">
	<h1 class="fw-bold">Dashboard</h1>
	<div class="body-container">
	    <div class="body-main bg-transparent">
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
			                <h4>오늘 접속자</h4>
			                <h3><span class="counter">${toDayCount}</span></h3>
			                <div class="d-flex">
			                    <span>Today</span>
			                </div>
			            </div>
			        </div>
			        <div class="col-lg-3">
			            <div class="population_analysis">
			                <h4>오늘 올라온 강좌 수</h4>
			                <h3><span class="counter todayCourse">${todayCourseCount}</span> </h3>
			                <div class="d-flex">
			                    <span>Today Course</span>
			                </div>
			            </div>
			        </div>
			        <div class="col-lg-3">
			            <div class="population_analysis">
			                <h4>총 강좌 수</h4>
			                <h3><span class="counter totalCourse">${totalCourseCount}</span></h3>
			                <div class="d-flex">
			                    <span>Total Course</span>
			                </div>
			            </div>
			        </div>
			    </div>
			</div>
				<div class="chart-box row justify-content-center d-flex p-0">
					<div class="chart-container m-3 col-4 d-flex shadow" id="pieContainer"></div>
					<div class="chart-container m-3 col-7 d-flex shadow" id="bar1"></div>
					<div class="chart-container p-0 m-3 col-5 d-flex  shadow" id="bar2"></div>
					<div class="chart-container p-0 m-3 col-6 text-center d-flex shadow">					
					<table id="refundCookie" class="justify-content-center w-100 refund " >
						<tr>
							<th class="col-2 m-0 p-0 border">요청인</th>
							<th class="col-2 m-0 p-0 border">요청 갯수</th>
							<th class="col-2 m-0 p-0 border">요청 금액</th>
							<th class="col-2 m-0 p-0 border">요청일</th>
						</tr>
					</table>
					</div>
				</div>
			</div>
		</div>
	</div>
</main>
 <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/echarts@5.2.2/dist/echarts.min.js"></script>
<script type="text/javascript">

$(function() {
var url = "${pageContext.request.contextPath}/admin/memberManage/ageAnalysis";
 $.getJSON(url, function(data) {
var dom = document.getElementById("bar1");
var myChart = echarts.init(dom);
var app = {};

var option;


option = {
		  title: {
		    text: '나이대별 회원 수'
		  },
		  tooltip: {
		    trigger: 'axis',
		    axisPointer: {
		      type: 'shadow'
		    }
		  },
		  legend: {},
		  grid: {
		    left: '3%',
		    right: '4%',
		    bottom: '3%',
		    containLabel: true
		  },
		  xAxis: {
		    type: 'value',
		    boundaryGap: [0, 0.01]
		  },
		  yAxis: {
		    type: 'category',
		    data: ['10대','20대','30대','40대','50대','60대','기타']
		  },
		  series: [
		    {
		      name: '회원 구분',
		      type: 'bar',
		      data: data
		    }
		  ]
		};

			option && myChart.setOption(option);
 });
});



$(function(){
	var url="${pageContext.request.contextPath}/admin/courseManage/courseAnalysis";
	
	$.getJSON(url, function(data){
		var chartDom = document.getElementById('pieContainer');
		var myChart = echarts.init(chartDom);
		var option;

		option = {
			title: {
				text: '카테고리별 강좌 수'
			},
			tooltip: {
				trigger: 'item'
			},
			legend: {
				top: '5%',
				left: 'center'
			},
			series: [
				{
					name: '카테고리별 강좌',
					type: 'pie',
					radius: ['40%', '70%'],
					avoidLabelOverlap: false,
					itemStyle: {
						borderRadius: 10,
						borderColor: '#fff',
						borderWidth: 2
					},
					label: {
						show: false,
						position: 'center'
					},
					emphasis: {
						label: {
							show: true,
							fontSize: '40',
							fontWeight: 'bold'
						}
					},
					labelLine: {
						show: false
					},
					data: data
				}
			]
		};
		option && myChart.setOption(option);		
	});
});

$(function() {
	var url="${pageContext.request.contextPath}/admin/creditManage/listBuySection";
	
	$.getJSON(url, function(data) {
	var chartDom = document.getElementById('bar2');
	var myChart = echarts.init(chartDom);
	var option;

	
	option = {
			title: {
				text: '주간 매출 현황'
			},
			 tooltip: {
				    trigger: 'axis',
				    axisPointer: {
				      type: 'shadow'
				    }
				  },
			  xAxis: {
			    type: 'category',
			    data: ['6 Days ago', '5 Days ago', '4 Days ago', '3 Days ago', '2 Days ago', '1 Day ago', 'Today']
			  },
			  yAxis: {
			    type: 'value'
			  },
			  series: [
			    {
			      data: data,
			      type: 'bar'
			    }
			  ]
			};
	option && myChart.setOption(option);
	});
});
</script>
<script type="text/javascript">
function ajaxFun(url, method, query, dataType, fn) {
	$.ajax({
		type:method,
		url:url,
		data:query,
		dataType:dataType,
		success:function(data){
			fn(data);
		},
		beforeSend : function(jqXHR) {
			jqXHR.setRequestHeader("AJAX", true);
		},
		error : function(jqXHR) {
			if (jqXHR.status == 403) {
				location.href="${pageContext.request.contextPath}/member/login";
				return false;
			} else if(jqXHR.status === 400) {
				alert("요청 처리가 실패했습니다.");
				return false;
			}
		
		}
	});
}

$(function() {
	todayCourse();
	totalCourse();
	listRefund();
});

function todayCourse() {
	var url = "${pageContext.request.contextPath}/admin/courseManage/todayCourse";
	var query = null;
	
	var fn = function(data) {
		var todayCourseCount= data.todayCourseCount;
		if(todayCourseCount != "0"){
			$(".todayCourse").html(todayCourseCount);
		} else{
			$(".todayCourse").html("0");
		}
	};
	ajaxFun(url, "get", query, "json", fn);
}

function totalCourse() {
	var url = "${pageContext.request.contextPath}/admin/courseManage/totalCourse";
	var query = null;
	
	var fn = function(data) {
		var totalCourseCount= data.totalCourseCount;		
		$(".totalCourse").html(totalCourseCount);
	};
	ajaxFun(url, "get", query, "json", fn);
}


function listRefund() {
	var url = "${pageContext.request.contextPath}/admin/creditManage/refundList";
	var query = null;
	var selector = ".refund";	
	
	var fn = function(data) {
		var str;
		$(data.listRefund).each(function(index, item) {
			var id = item.userId;
			var price = item.price;
			var amount = item.amount;
			var date = item.refund_date;
			var t = betweenTime(date);
			if(t < 60){
				t = t + "분 전";
			} else if( (t / 60) < 24){
				t = Math.floor((t / 60)) + "시간 전";
			} else if( ( t / (60 * 24) ) <365 ){
				t = Math.floor(t / (60 * 24)) + "일 전 ";
			}  
			
			str = "<tr></tr>"
			$(str).append("<td class='border'>"+id+"</td>").append("<td class='border'>"+amount+"</td>").append("<td class='border'>"+price+"</td>")
				.append("<td class='border'>"+t+"</td>").appendTo(selector);
		});
			
	};
	
	ajaxFun(url, "get", query, "json", fn);	
}

function betweenTime(value) {
	var vDate = new Date(value);
	var now = new Date();
	
	var time = ( now.getTime()- vDate.getTime() ) / (1000*60); //분
	time = parseInt(time);
	return time;
}



</script>
