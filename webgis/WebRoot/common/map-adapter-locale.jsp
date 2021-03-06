<%@ include file="/common/taglibs.jsp"%>
<script>
Map.locale = {
	getAddreeDefaultText : "<fmt:message key='map.adapter.getAddreeDefaultText' />",
	getAddreeErrorText   : "<fmt:message key='map.adapter.getAddreeErrorText' />",
	defaultCity : "<fmt:message key='map.adapter.defaultCity' />",
	tool : {
		hand           : "<fmt:message key='map.tool.hand' />", 
		measure        : "<fmt:message key='map.tool.measure' />",
		zoomOut        : "<fmt:message key='map.tool.zoomOut' />",
		zoomIn         : "<fmt:message key='map.tool.zoomIn' />",
		search         : {
			name    : "<fmt:message key='map.tool.search' />",
			total   : "<fmt:message key='map.tool.search.total' />",
			message : "<fmt:message key='map.tool.search.message' />",
			fail    : "<fmt:message key='map.tool.search.fail' />"
		},
		overlay        : "<fmt:message key='menu.200007.show' />",
		polyline       : "<fmt:message key='map.tool.polyline' />",
		rect           : "<fmt:message key='map.tool.rect' />",
		rectQuery      : "<fmt:message key='tracking.command.areaQuery' />",
		polygon        : "<fmt:message key='map.tool.polygon' />",
		print          : "<fmt:message key='map.tool.print' />",
		fullScreen     : "<fmt:message key='map.tool.fullScreen' />",
		marker         : "<fmt:message key='map.tool.marker' />",
		markerExt      : {
			name      : "<fmt:message key='map.tool.markerExt' />",
			createNew : "<fmt:message key='map.tool.markerExt.createNew' />",
			lnglat    : "<fmt:message key='map.tool.markerExt.lnglat' />",
			poiname   : "<fmt:message key='map.tool.markerExt.poiname' />",
			remark    : "<fmt:message key='map.tool.markerExt.remark' />",
			save      : "<fmt:message key='map.tool.markerExt.save' />",
			cancel    : "<fmt:message key='map.tool.markerExt.cancel' />",
			isSave    : "<fmt:message key='map.tool.markerExt.isSave' />",
			enterName : "<fmt:message key='map.tool.markerExt.enterName' />",
			del       : "<fmt:message key='map.tool.markerExt.del' />",
			isDel     : "<fmt:message key='map.tool.markerExt.isDel' />",
			defaultDataItemsSeperator     : "<fmt:message key='map.tool.markerExt.defaultDataItemsSeperator' />",
			defaultDataSeperator     : "<fmt:message key='map.tool.markerExt.defaultDataSeperator' />"
		},
		configCenter  : "<fmt:message key='map.tool.configCenter' />",
		useCenter     : "<fmt:message key='map.tool.useCenter' />",
		clear         : "<fmt:message key='tracking.command.history.clear' />",
		circle        : "<fmt:message key='map.tool.circle' />",
		targetMap     : "<fmt:message key='map.tool.targetMap' />"
	},
	"1" : "<fmt:message key='angle.north' />",
	"2" : "<fmt:message key='angle.northeast' />",
	"3" : "<fmt:message key='angle.east' />",
	"4" : "<fmt:message key='angle.southeast' />",
	"5" : "<fmt:message key='angle.south' />",
	"6" : "<fmt:message key='angle.southwest' />",
	"7" : "<fmt:message key='angle.west' />",
	"8" : "<fmt:message key='angle.northwest' />",
	"view"   : "<fmt:message key='view' />",
	"unknow" : "<fmt:message key='angle.unknow' />",
	"color"  : "<fmt:message key='tracking.grid.fields.targetColor' />",
	"group"  : "<fmt:message key='tracking.grid.fields.group' />",
	"none"   : "<fmt:message key='tracking.grid.fields.targetColor.miss' />",
	"status"  : "<fmt:message key='tracking.grid.fields.acc' />",
	"name" 	: "<fmt:message key='tracking.command.area.areaName' />",
	"radius" : "<fmt:message key='radius' />",
	"remark" : "<fmt:message key='vehicleGroupInfo.reserve' />",
	"availability" : "<fmt:message key='tracking.command.result.validate.true' />",
	"unavailability" : "<fmt:message key='tracking.command.result.validate.false' />",
	"ignition" : "<fmt:message key='tracking.command.tracking.posTime.do.4' />",
	"flameout" : "<fmt:message key='tracking.command.tracking.posTime.do.3' />",
	"target" : "<fmt:message key='tracking.grid.fields.target' />",
	"lat_lng" : "<fmt:message key='tracking.command.line.latlngList' />",
	"speed" : "<fmt:message key='tracking.command.history.speed' />",
	"espeed" : "<fmt:message key='tracking.grid.fields.espeed' />",
	"gps_time" : "<fmt:message key='msGpsInfo.gpsTime' />",
	"pos_time" : "<fmt:message key='tracking.grid.fields.uploadTime' />",
	"status" : "<fmt:message key='tracking.grid.fields.acc' />",
	"validate" : "<fmt:message key='tracking.grid.fields.validate' />",
	"direction" : "<fmt:message key='tracking.grid.fields.angle' />",
	"address" : "<fmt:message key='tracking.grid.fields.address' />",
	"get_address_ing" : "<fmt:message key='tracking.command.getAddressWait' />",
	"get_address" : "<fmt:message key='tracking.command.getAddressWait' />",
	"couldnt_get_address" : "<fmt:message key='map.adapter.getAddreeErrorText' />",
	"get_address_failed" : "<fmt:message key='map.adapter.getAddreeErrorText' />",
	"rectify_error" : "<fmt:message key='map.adapter.getAddreeErrorText' />",
	"play" : "<fmt:message key='tracking.tree.tips.media.play' />",
	"pause" : "<fmt:message key='channelsGroupInfo.useState.1' />",
	"go_on" : "<fmt:message key='tracking.command.history.goon' />", 
	"vehNoCol"     : "<fmt:message key='vehicleInfo.vehNoCol' />",
	"vehicleGroup" : "<fmt:message key='vehicleGroupInfo.info' />",
	"carType"      : "<fmt:message key='tracking.grid.fields.carType' />",
	"industryType" : "<fmt:message key='tracking.grid.fields.industryType' />",
	"region"       : "<fmt:message key='tracking.grid.fields.region' />",
	"simCode"      : "<fmt:message key='tracking.grid.fields.sim' />",
	"driverInfos"  : "<fmt:message key='report.driver' />",
	"mileage"      : "<fmt:message key='csReport.travel.mileage' />",
	"oilinfo"      : "<fmt:message key='report.oil' />",
	"corpName"     : "<fmt:message key='tracking.grid.fields.corpName' />",
	"height"       : "<fmt:message key='tracking.grid.fields.height' />",
	"ebill"        : "<fmt:message key='tracking.grid.ewayInfo' />",
	"warnSrc"      : "<fmt:message key='alarm.warnSrc' />",
	"warn"         : "<fmt:message key='report.alarm.type' />",
	"study"        : "<fmt:message key='studyExtState' />",
	"sub"          : "<fmt:message key='tracking.grid.driverTraining.type.2.sub' />",


	
	"rightClickEnd" : "<fmt:message key='rightClickEnd' />",
	"rightClickReset" : "<fmt:message key='rightClickReset' />",


	"m" : "<fmt:message key='tracking.command.tracking.settings.met' />",
	"distance" : "<fmt:message key='distance' />",
	"showMarker" : "<fmt:message key='map.tool.marker' />"

	
};

</script>