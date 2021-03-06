package com.ltmonitor.mobile.action;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.ibatis.sqlmap.client.PageResult;
import com.ltmonitor.entity.BasicData;
import com.ltmonitor.entity.PointLatLng;
import com.ltmonitor.entity.StringUtil;
import com.ltmonitor.entity.VehicleData;
import com.ltmonitor.service.IVehicleService;
import com.ltmonitor.service.MapFixService;
import com.ltmonitor.util.Constants;
import com.ltmonitor.util.DateUtil;
import com.ltmonitor.web.action.PaginateResult;
import com.ltmonitor.web.action.QueryAction;
/**
 * 历史轨迹回放
 * @author DELL
 *
 */
public class MobileHisGpsInfoAction extends QueryAction {

	private int vehicleId;

	private String plateNo;
	private int pageNo;

	private int limit;
	
	private String startTime;
	
	private String endTime;

	protected IVehicleService vehicleService;

	@SuppressWarnings("rawtypes")
	private Map resultMap = new HashMap();

	// 打开页面的Action 方法,不做操作，直接打开页面
	public String view() {
		return "view";
	}

	/**
	 * 分页查询终端命令列表
	 * 
	 * @return
	 */
	public String execute() {
		queryId = "selectGpsInfos";
		Map params = this.getParams();
		// String queryId = "select";
		if (getOnlineUser() != null) {
			// 只查询用户自己下发的命令
			params.put("userId", getOnlineUser().getEntityId());
		}
		try {

			if (plateNo != null) {
				VehicleData vd = this.vehicleService
						.getVehicleByPlateNo(plateNo);
				if (vd != null)
					vehicleId = vd.getEntityId();
			}

			if (vehicleId == 0)
				return json(false, "该车辆不存在");

			// 单车监控，用于生成监控车辆轨迹

			String queryId1 = "selectStaticVehicleInfo"; // 查询单个车辆的综合信息
			params.put("vehicleId", vehicleId);
			result = (getQueryDao().queryForList(queryId1, params));
			Map vehicleInfoMap = new HashMap();
			if (result.size() > 0) {
				vehicleInfoMap = (Map) result.get(0);
				// 转换车牌号数字为文字描述
				this.convert(vehicleInfoMap, "plateColor", "plateColor");
			}
			startTime = startTime.substring(0,10).replace("-","");
			endTime = endTime.substring(0,10).replace("-","");
			String today = DateUtil.toStringByFormat(new Date(), "yyyyMMdd");
			if(endTime.compareTo(today) > 0)
				endTime = today;
			String tableName1 = "gpsInfo"+startTime;
			params.put("tableName1", tableName1);
			String tableName2 = "gpsInfo"+endTime;
			params.put("tableName2", tableName2);
			
			if(tableName1.equals(tableName2) == false)
			{
				queryId = "selectGpsInfosIn2Days";
			}
			
			limit = 30;

			// params.put("valid", 1);
			PageResult result = getQueryDao().queryByPagination(queryId,
					params, pageNo, limit);
			int rowNo = (pageNo - 1) * limit + 1;
			List<PointLatLng> pointList = new ArrayList<PointLatLng>();
			List mapList = result.getResults();
			for (Object obj : mapList) {
				Map rowData = (Map) obj;
				rowData.putAll(vehicleInfoMap);

				rowData.put("RowNum", rowNo++);

				Double latitude = Double.parseDouble(""
						+ rowData.get("latitude"));
				Double longitude = Double.parseDouble(""
						+ rowData.get("longitude"));
				rowData.put("orgLatitude", latitude);
				rowData.put("orgLongitude", longitude);
				// 坐标加偏
				PointLatLng pl = MapFixService.fix(latitude, longitude,
						Constants.MAP_GOOGLE);
				rowData.put("latitude", pl.getLat());
				rowData.put("longitude", pl.getLng());

				// }

				String valid = "" + rowData.get("valid");
				if ("true".equals(valid)) {
					rowData.put("valid", "有效");
				} else
					rowData.put("valid", "无效");

				int direction = (Integer) rowData.get("direction");
				String directionDescr = this.getDirectionDescr(direction);
				rowData.put("directionDescr", directionDescr);

				int status = (Integer) rowData.get("status");
				String strStatus = Integer.toBinaryString(status);
				strStatus = StringUtil.leftPad(strStatus, 32, '0');
				strStatus = getStatusDescr(strStatus);
				rowData.put("status", strStatus);

				int alarmState = (Integer) rowData.get("alarmState");
				String alarmStateDescr = this.getAlarmDescr(alarmState);
				rowData.put("alarm", alarmStateDescr);

			}
			 HashMap pr = new HashMap();
             pr.put("total",result.getTotalCount());
             pr.put("rows", result.getResults());
             
			return json(true, pr);

		} catch (Exception ex) {
			String msg = ex.getMessage();
			if(msg.indexOf("对象") > 0 && msg.indexOf("无效") > 0)
				msg = "该时间段没有记录";
			log.error(ex.getMessage(), ex);
			return json(false, msg);
		}
		//return "success";
	}

	protected String getStatusDescr(String status) {
		StringBuilder sb = new StringBuilder();

		if (StringUtil.isNullOrEmpty(status) == false) {
			char[] ch = status.toCharArray();
			if (ch.length == 32) {
				int m = 31;
				int c = ch[m - 0] - 48;
				sb.append(c == 1 ? "ACC开" : "ACC关").append(",");
				c = ch[m - 1] - 48;
				sb.append(c == 1 ? "定位" : "未定位").append(",");
				c = ch[m - 4] - 48;
				sb.append(c == 1 ? "停运" : "运营").append(",");
				c = ch[m - 10] - 48;
				sb.append(c == 1 ? "油路断开" : "油路正常").append(",");
				c = ch[m - 11] - 48;
				sb.append(c == 1 ? "电路断开" : "电路正常").append(",");
				c = ch[m - 12] - 48;
				sb.append(c == 1 ? "车门加锁" : "车门解锁").append(",");
			}
		}

		return sb.toString();
	}

	protected String getDirectionDescr(int direction) {
		Map directionMap = new HashMap();
		String descr = "";
		if (direction == 0) {
			descr = "正东";
		} else if (direction == 90) {
			descr = "正北";
		} else if (direction == 180) {
			descr = "正西";
		} else if (direction == 270) {
			descr = "正南";
		} else if (direction == 45) {
			descr = "东北";
		} else if (direction == 135) {
			descr = "西北";
		} else if (direction == 225) {
			descr = "西南";
		} else if (direction == 315) {
			descr = "东南";
		} else if (direction < 90) {
			descr = "东偏北" + direction + "度";
		} else if (direction > 90 && direction < 180) {
			descr = "西偏北" + (180 - direction) + "度";
		} else if (direction > 180 && direction < 270) {
			descr = "西偏南" + (direction - 180) + "度";
		} else if (direction > 270 && direction < 360) {
			descr = "东偏南" + (360 - direction) + "度";
		}
		return descr;
	}

	/**
	 * 报警描述
	 * 
	 * @param alarm
	 * @return
	 */
	protected String getAlarmDescr(int alarmState) {
		StringBuilder sb = new StringBuilder();
		String alarm = Integer.toBinaryString(alarmState);
		alarm = StringUtil.leftPad(alarm, 32, '0');
		if (StringUtil.isNullOrEmpty(alarm) == false) {
			char[] ch = alarm.toCharArray();
			for (int m = 0; m < ch.length; m++) {
				int tag = Integer.parseInt("" + ch[m]);
				if (tag == 1) {
					int alarmId = 31 - m; // 倒序，转换为部标的报警序号
					BasicData bd = basicDataService.getBasicDataByCode(""
							+ alarmId, "AlarmType");
					if (bd != null) {
						sb.append(bd.getName()).append(",");
					}
				}
			}
		}

		return sb.toString();
	}

	public int getLimit() {
		return limit;
	}

	public void setLimit(int limit) {
		this.limit = limit;
	}


	public Map getResultMap() {
		return resultMap;
	}

	public void setResultMap(Map commandList) {
		this.resultMap = commandList;
	}

	public int getPageNo() {
		return pageNo;
	}

	public void setPageNo(int page) {
		this.pageNo = page;
	}

	public IVehicleService getVehicleService() {
		return vehicleService;
	}

	public void setVehicleService(IVehicleService vehicleService) {
		this.vehicleService = vehicleService;
	}

	public String getPlateNo() {
		return plateNo;
	}

	public void setPlateNo(String plateNo) {
		this.plateNo = plateNo;
	}

	public String getStartTime() {
		return startTime;
	}

	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}

	public String getEndTime() {
		return endTime;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

}
