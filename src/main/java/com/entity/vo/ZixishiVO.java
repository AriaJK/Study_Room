package com.entity.vo;

import com.entity.ZixishiEntity;

import com.baomidou.mybatisplus.annotations.TableName;
import java.util.Date;
import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;
import java.io.Serializable;
 

/**
 * 自习室
 * 手机端接口返回实体辅助类 
 * （主要作用去除一些不必要的字段）
 * @author 
 * @email 
 * @date 2023-03-08 10:25:19
 */
public class ZixishiVO  implements Serializable {
	private static final long serialVersionUID = 1L;

	 			
	/**
	 * 图片
	 */
	
	private String tupian;
		
	/**
	 * 规模
	 */
	
	private String guimo;
		
	/**
	 * 座位
	 */
	
	private Integer zuowei;
		
	/**
	 * 位置
	 */
	
	private String weizhi;
		
	/**
	 * 设施
	 */
	
	private String sheshi;
		
	/**
	 * 可约时间
	 */
	
	private String keyueshijian;
		
	/**
	 * 是否有课
	 */
	
	private String shifouyouke;
		
	/**
	 * 详情
	 */
	
	private String xiangqing;
				
	
	/**
	 * 设置：图片
	 */
	 
	public void setTupian(String tupian) {
		this.tupian = tupian;
	}
	
	/**
	 * 获取：图片
	 */
	public String getTupian() {
		return tupian;
	}
				
	
	/**
	 * 设置：规模
	 */
	 
	public void setGuimo(String guimo) {
		this.guimo = guimo;
	}
	
	/**
	 * 获取：规模
	 */
	public String getGuimo() {
		return guimo;
	}
				
	
	/**
	 * 设置：座位
	 */
	 
	public void setZuowei(Integer zuowei) {
		this.zuowei = zuowei;
	}
	
	/**
	 * 获取：座位
	 */
	public Integer getZuowei() {
		return zuowei;
	}
				
	
	/**
	 * 设置：位置
	 */
	 
	public void setWeizhi(String weizhi) {
		this.weizhi = weizhi;
	}
	
	/**
	 * 获取：位置
	 */
	public String getWeizhi() {
		return weizhi;
	}
				
	
	/**
	 * 设置：设施
	 */
	 
	public void setSheshi(String sheshi) {
		this.sheshi = sheshi;
	}
	
	/**
	 * 获取：设施
	 */
	public String getSheshi() {
		return sheshi;
	}
				
	
	/**
	 * 设置：可约时间
	 */
	 
	public void setKeyueshijian(String keyueshijian) {
		this.keyueshijian = keyueshijian;
	}
	
	/**
	 * 获取：可约时间
	 */
	public String getKeyueshijian() {
		return keyueshijian;
	}
				
	
	/**
	 * 设置：是否有课
	 */
	 
	public void setShifouyouke(String shifouyouke) {
		this.shifouyouke = shifouyouke;
	}
	
	/**
	 * 获取：是否有课
	 */
	public String getShifouyouke() {
		return shifouyouke;
	}
				
	
	/**
	 * 设置：详情
	 */
	 
	public void setXiangqing(String xiangqing) {
		this.xiangqing = xiangqing;
	}
	
	/**
	 * 获取：详情
	 */
	public String getXiangqing() {
		return xiangqing;
	}
			
}
