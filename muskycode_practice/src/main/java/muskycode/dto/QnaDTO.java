package muskycode.dto;

/*
�씠由�         �꼸?       �쑀�삎             
---------- -------- -------------- 
QNO        NOT NULL NUMBER(5)      
PNO        NOT NULL NUMBER(5)      
MID        NOT NULL VARCHAR2(20)   
QDATE               DATE           
QTITLE              VARCHAR2(50)   
QCONTENT            VARCHAR2(1000) 
QCATEGORY           VARCHAR2(30)   
QANSWER             VARCHAR2(20)   
QACONTENT           VARCHAR2(1000) 
QREF                NUMBER(5)      
QREF_STEP           NUMBER(5)      
QREF_LEVEL          NUMBER(5)      
QADATE              DATE           
QSTATUS             NUMBER(5)  
 */
public class QnaDTO {
	private int QNO;
	private int PNO;
	private String MID;
	private String QDATE;
	private String QTITLE;
	private String QCONTENT;
	private String QCATEGORY;
	private String QANSWER;
	private String QACONTENT;
	private int QREF;
	private int QREF_STEP;
	private int QREF_LEVEL;
	private String QADATE;
	private int QSTATUS;
	private int QHIT;
	public int getQNO() {
		return QNO;
	}
	public void setQNO(int qNO) {
		QNO = qNO;
	}
	public int getPNO() {
		return PNO;
	}
	public void setPNO(int pNO) {
		PNO = pNO;
	}
	public String getMID() {
		return MID;
	}
	public void setMID(String mID) {
		MID = mID;
	}
	public String getQDATE() {
		return QDATE;
	}
	public void setQDATE(String qDATE) {
		QDATE = qDATE;
	}
	public String getQTITLE() {
		return QTITLE;
	}
	public void setQTITLE(String qTITLE) {
		QTITLE = qTITLE;
	}
	public String getQCONTENT() {
		return QCONTENT;
	}
	public void setQCONTENT(String qCONTENT) {
		QCONTENT = qCONTENT;
	}
	public String getQCATEGORY() {
		return QCATEGORY;
	}
	public void setQCATEGORY(String qCATEGORY) {
		QCATEGORY = qCATEGORY;
	}
	public String getQANSWER() {
		return QANSWER;
	}
	public void setQANSWER(String qANSWER) {
		QANSWER = qANSWER;
	}
	public String getQACONTENT() {
		return QACONTENT;
	}
	public void setQACONTENT(String qACONTENT) {
		QACONTENT = qACONTENT;
	}
	public int getQREF() {
		return QREF;
	}
	public void setQREF(int qREF) {
		QREF = qREF;
	}
	public int getQREF_STEP() {
		return QREF_STEP;
	}
	public void setQREF_STEP(int qREF_STEP) {
		QREF_STEP = qREF_STEP;
	}
	public int getQREF_LEVEL() {
		return QREF_LEVEL;
	}
	public void setQREF_LEVEL(int qREF_LEVEL) {
		QREF_LEVEL = qREF_LEVEL;
	}
	public String getQADATE() {
		return QADATE;
	}
	public void setQADATE(String qADATE) {
		QADATE = qADATE;
	}
	public int getQSTATUS() {
		return QSTATUS;
	}
	public void setQSTATUS(int qSTATUS) {
		QSTATUS = qSTATUS;
	}
	public int getQHIT() {
		return QHIT;
	}
	public void setQHIT(int qHIT) {
		QHIT = qHIT;
	}
	
	
	
	
	

	
	
}
