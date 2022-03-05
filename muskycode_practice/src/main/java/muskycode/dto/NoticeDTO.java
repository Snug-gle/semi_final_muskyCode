package muskycode.dto;

/*
�̸�       ��?       ����             
-------- -------- -------------- 
NNO      NOT NULL NUMBER(5)      
NTITLE            VARCHAR2(40)   
NCONTENT          VARCHAR2(2000) 
NHIT              NUMBER(10)     
NDATE             DATE       
 */
public class NoticeDTO {

	private int NNO;
	private String NTITLE;
	private String NCONTENT;
	private int NHIT;
	private String NDATE;
	
	public NoticeDTO() {
		// TODO Auto-generated constructor stub
	}


	public int getNNO() {
		return NNO;
	}

	public void setNNO(int nNO) {
		NNO = nNO;
	}

	public String getNTITLE() {
		return NTITLE;
	}

	public void setNTITLE(String nTITLE) {
		NTITLE = nTITLE;
	}

	public String getNCONTENT() {
		return NCONTENT;
	}

	public void setNCONTENT(String nCONTENT) {
		NCONTENT = nCONTENT;
	}

	public int getNHIT() {
		return NHIT;
	}

	public void setNHIT(int nHIT) {
		NHIT = nHIT;
	}

	public String getNDATE() {
		return NDATE;
	}

	public void setNDATE(String nDATE) {
		NDATE = nDATE;
	}
	
	
	
}


