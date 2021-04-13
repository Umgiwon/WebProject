package com.kh.jsp.thumb.model.vo;

import java.io.Serializable;
import java.sql.Date;

public class Attachment implements Serializable {

	private static final long serialVersionUID = 1200L; // 직렬화 처리

	private int fno;
	private int bno;
	private String filename;
	private int flevel;
	private Date uploadDate;
	private String status;

	public Attachment() {
	}

	public Attachment(int fno, int bno, String filename, int flevel, Date uploadDate, String status) {
		super();
		this.fno = fno;
		this.bno = bno;
		this.filename = filename;
		this.flevel = flevel;
		this.uploadDate = uploadDate;
		this.status = status;
	}

	@Override
	public String toString() {
		return "Attachment [fno=" + fno + ", bno=" + bno + ", filename=" + filename + ", flevel=" + flevel
				+ ", uploadDate=" + uploadDate + ", status=" + status + "]";
	}

	public int getFno() {
		return fno;
	}

	public void setFno(int fno) {
		this.fno = fno;
	}

	public int getBno() {
		return bno;
	}

	public void setBno(int bno) {
		this.bno = bno;
	}

	public String getFilename() {
		return filename;
	}

	public void setFilename(String filename) {
		this.filename = filename;
	}

	public int getFlevel() {
		return flevel;
	}

	public void setFlevel(int flevel) {
		this.flevel = flevel;
	}

	public Date getUploadDate() {
		return uploadDate;
	}

	public void setUploadDate(Date uploadDate) {
		this.uploadDate = uploadDate;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

}
