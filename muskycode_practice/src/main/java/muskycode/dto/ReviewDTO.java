package muskycode.dto;

/*
�씠由�         �꼸?       �쑀�삎             
---------- -------- -------------- 
RNO        NOT NULL NUMBER(5)      
MID        NOT NULL VARCHAR2(20)   
RTITLE              VARCHAR2(40)   
RCONTENT            VARCHAR2(1000) 
RDATE               DATE           
RHIT                NUMBER(10)     
RIMGURL             VARCHAR2(60)   
RREF                NUMBER(5)      
RREF_STEP           NUMBER(5)      
RREF_LEVEL          NUMBER(5)      
RSTATUS             NUMBER(5)    
 */
public class ReviewDTO {

	private int RNO;
	private String MID;
	private String RTITLE;
	private String RCONTENT;
	private String RDATE;
	private int RHIT;
	private String RIMGURL;
	private int RREF;
	private int RREF_STEP;
	private int RREF_LEVEL;
	private int RSTATUS;
	
	public int getRNO() {
		return RNO;
	}
	public void setRNO(int rNO) {
		RNO = rNO;
	}
	public String getMID() {
		return MID;
	}
	public void setMID(String mID) {
		MID = mID;
	}
	public String getRTITLE() {
		return RTITLE;
	}
	public void setRTITLE(String rTITLE) {
		RTITLE = rTITLE;
	}
	public String getRCONTENT() {
		return RCONTENT;
	}
	public void setRCONTENT(String rCONTENT) {
		RCONTENT = rCONTENT;
	}
	public String getRDATE() {
		return RDATE;
	}
	public void setRDATE(String rDATE) {
		RDATE = rDATE;
	}
	public int getRHIT() {
		return RHIT;
	}
	public void setRHIT(int rHIT) {
		RHIT = rHIT;
	}
	public String getRIMGURL() {
		return RIMGURL;
	}
	public void setRIMGURL(String rIMGURL) {
		RIMGURL = rIMGURL;
	}
	public int getRREF() {
		return RREF;
	}
	public void setRREF(int rREF) {
		RREF = rREF;
	}
	public int getRREF_STEP() {
		return RREF_STEP;
	}
	public void setRREF_STEP(int rREF_STEP) {
		RREF_STEP = rREF_STEP;
	}
	public int getRREF_LEVEL() {
		return RREF_LEVEL;
	}
	public void setRREF_LEVEL(int rREF_LEVEL) {
		RREF_LEVEL = rREF_LEVEL;
	}
	public int getRSTATUS() {
		return RSTATUS;
	}
	public void setRSTATUS(int rSTATUS) {
		RSTATUS = rSTATUS;
	}


	

}
