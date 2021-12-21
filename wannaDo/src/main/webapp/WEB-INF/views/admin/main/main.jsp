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
				<div class="chart-box row justify-content-center">
					<div class="chart-container p-0 m-3 text-center">
					<h3>이번 달 생일인 회원</h3>
					<div id="birthday"></div>
					</div>
					<div class="chart-container p-0 m-3" id="pieContainer"></div>
					<div class="chart-container p-0 m-3" id="distribution"></div>
					<div class="chart-container p-0 m-3" id=""></div>
				</div>
			</div>
		</div>
	</div>
</main>
 <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/echarts@5.2.2/dist/echarts.min.js"></script>
<script type="text/javascript">
/*
$(function() {
var dom = document.getElementById("bar1");
var myChart = echarts.init(dom);
var app = {};

var option;



option = {
  xAxis: {
    type: 'category',
    data: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
  },
  yAxis: {
    type: 'value'
  },
  series: [
    {
      data: [120, 200, 150, 80, 70, 110, 130],
      type: 'bar'
    }
  ]
};

if (option && typeof option === 'object') {
    myChart.setOption(option);
}
});

*/

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
	var chartDom = document.getElementById('distribution');
	var myChart = echarts.init(chartDom);
	var option;

	const colors = ['#5470C6', '#EE6666'];
	option = {
	  color: colors,
	  tooltip: {
	    trigger: 'none',
	    axisPointer: {
	      type: 'cross'
	    }
	  },
	  legend: {},
	  grid: {
	    top: 70,
	    bottom: 50
	  },
	  xAxis: [
	    {
	      type: 'category',
	      axisTick: {
	        alignWithLabel: true
	      },
	      axisLine: {
	        onZero: false,
	        lineStyle: {
	          color: colors[1]
	        }
	      },
	      axisPointer: {
	        label: {
	          formatter: function (params) {
	            return (
	              'Precipitation  ' +
	              params.value +
	              (params.seriesData.length ? '：' + params.seriesData[0].data : '')
	            );
	          }
	        }
	      },
	      // prettier-ignore
	      data: ['2016-1', '2016-2', '2016-3', '2016-4', '2016-5', '2016-6', '2016-7', '2016-8', '2016-9', '2016-10', '2016-11', '2016-12']
	    },
	    {
	      type: 'category',
	      axisTick: {
	        alignWithLabel: true
	      },
	      axisLine: {
	        onZero: false,
	        lineStyle: {
	          color: colors[0]
	        }
	      },
	      axisPointer: {
	        label: {
	          formatter: function (params) {
	            return (
	              'Precipitation  ' +
	              params.value +
	              (params.seriesData.length ? '：' + params.seriesData[0].data : '')
	            );
	          }
	        }
	      },
	      // prettier-ignore
	      data: ['2015-1', '2015-2', '2015-3', '2015-4', '2015-5', '2015-6', '2015-7', '2015-8', '2015-9', '2015-10', '2015-11', '2015-12']
	    }
	  ],
	  yAxis: [
	    {
	      type: 'value'
	    }
	  ],
	  series: [
	    {
	      name: 'Precipitation(2015)',
	      type: 'line',
	      xAxisIndex: 1,
	      smooth: true,
	      emphasis: {
	        focus: 'series'
	      },
	      data: [
	        2.6, 5.9, 9.0, 26.4, 28.7, 70.7, 175.6, 182.2, 48.7, 18.8, 6.0, 2.3
	      ]
	    },
	    {
	      name: 'Precipitation(2016)',
	      type: 'line',
	      smooth: true,
	      emphasis: {
	        focus: 'series'
	      },
	      data: [
	        3.9, 5.9, 11.1, 18.7, 48.3, 69.2, 231.6, 46.6, 55.4, 18.4, 10.3, 0.7
	      ]
	    }
	  ]
	};

	option && myChart.setOption(option);
});
</script>
<script type="text/javascript">
function ajaxFun(url, method, query, dataType, fn){
	$.ajax({
		type:method,
		url:url,
		data:query,
		dataType:dataType,
		success:function(data){
			fn(data);
		},
		error:function(jqXHR){
			alert("요청 처리가 실패했습니다.")
			console.log(jqXHR.responseText);
		}
	});
}

$(function() {
	todayCourse();
	totalCourse();
	listBirth();
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

function listBirth() {
	var url = "${pageContext.request.contextPath}/admin/memberManage/listBirth";
	var query = null;
	var selector = "#birthday";
		
	var fn = function(data) {
		var blist = data.listBirth;
		if( blist){
		for(var i=0; i<blist.length; i++){
			var name = blist[i].userName;
			var birth = blist[i].birth;
			var month = birth.substring(5,7);
			var date = birth.substring(8,10);
			var out = "<span style='font-size: 32px; font-weight: bold; margin:10px;'>" +name + "님의 생일 : "+month+"월 "+date+"일"+"</span>";
			$(selector).html(out);
		}
		} else {
			out = "<span style='font-size: 32px; font-weight: bold; margin:10px;'> 생일인 회원이 존재하지 않습니다. </span>";
			$(selector).html(out);
		}
	};
	
	ajaxFun(url, "get", query, "json", fn);	
}
</script>
