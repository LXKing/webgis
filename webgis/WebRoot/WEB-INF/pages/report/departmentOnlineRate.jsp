<%@ page language="java" pageEncoding="UTF-8"%>
<!--分页查询共用的页面-->
<%@ include file="/common/paginateUtil.jsp"%>
<!--日期控件-->
<%@ include file="/common/dateUtil.jsp"%>
</head>

		<script type="text/javascript" charset="utf-8">
			
			$(document).ready(function() {
				 
				  var now = Utility.now();
				  $("#endDate").val(now);
				  var now = Utility.now(-1);
				  $("#startDate").val(now);

				  //$("#intervalType").lookup({category:"ReportType"}); //统计类型下拉框
				 
				$("#btnQuery").click(function(){
				        Utility.loadGridWithParams();
				});
				//创建下拉部门树
				Utility.createDepTree("depId");
				 // $(".datepicker").today();
				  $("#intervalType").change(function()
				{
				       var txt = $("#intervalType").find("option:selected").text(); 
					   $("#intervalTypeName").val(txt);
				});
			} );
		</script>
<body>
		<div id="toolbar">		
			
			<form id="queryForm" action="<%=ApplicationPath%>/report/departmentOnlineRate.action">
			   <input type="hidden" name="queryId" value="selectDepartmentOnlineRate" />	   
			   <input type="hidden" name="fileName" value="企业上线率统计" />	     	 
			   <input type="hidden" name="intervalTypeName" id="intervalTypeName" value="所有" />	       
			  <table width="100%"  class="TableBlock">
			   			   <tr>
            <td>车辆组:</td>
			    <td>			
				<select id="depId" name="depId" style="width:200px;"></select>
				</td>
           <!-- <td>统计类型</td>
			    <td>	<select id="intervalType"  name="intervalType"></select>   </td> --> 
 <tr>
			   <td> 统计日期 </td>
			    <td >			    <input type="text" id="startDate" name="startDate" size="15"  class="datepicker">
              至<input type="text" name="endDate"  id="endDate" size="15"   class="datepicker">   </td>
             
        <td  align="left" colspan=2>
	      <a id="btnQuery" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" >查询</a>&nbsp;
		   <a id="btnReset" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-clear'" >重置</a>&nbsp;
		   <a id="btnExport" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-excel'" onclick="Utility.excelExport('<%=ApplicationPath%>/data/excelExport.action');">导出</a><!--调用utility.js-->
        </td>
    </tr>
		</table>
		</form>	 
		
  </div>
				<table id="queryGrid" class="easyui-datagrid" title="" style="width:100%;height:480px"
						data-options="pagination:true,pageSize:15,singleSelect:true,rownumbers:true,striped:true,fitColumns: true,
						pageList: [15, 20, 50, 100, 150, 200],fit:true,toolbar:'#toolbar',
						url:'<%=ApplicationPath%>/report/departmentOnlineRate.action',method:'post'">
					<thead>
						<tr>
							<th data-options="field:'depName'"   width="15%">车组</th>
							<th data-options="field:'onlineNum'"   width="15%">上线车辆数</th>
							<th data-options="field:'offlineNum'"   width="15%">离线车辆数</th>
							<th data-options="field:'vehicleNum'"   width="15%">车辆总数</th>
							<th data-options="field:'onlineRate'"   width="15%">上线率(%)</th>
							<th data-options="field:'statisticDate'"   width="15%">统计时间</th>
						</tr>
					</thead>				
				</table>
</body>

