package file;

import java.sql.Timestamp;

public class FileDTO {
	private String fileName;
	private String fileRealName;
	private int downloadCount;
	private String name;
	
	private Timestamp date;
	private String subject;
	private String content;
	private int num;
	private String pwd;
	
	public int getNum() {
		return num;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Timestamp getDate() {
		return date;
	}

	public void setDate(Timestamp date) {
		this.date = date;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}


	public int getDownloadCount() {
		return downloadCount;
	}

	public void setDownloadCount(int downloadCount) {
		this.downloadCount = downloadCount;
	}

	public String getFileName() {
		return fileName;
	}
	
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	
	public String getFileRealName() {
		return fileRealName;
	}
	
	public void setFileRealName(String fileRealName) {
		this.fileRealName = fileRealName;
	}


	
}
