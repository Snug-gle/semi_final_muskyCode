package muskycode.dto;

public class OrderDTO {

	private int ONO;
	private int PNO;
	private String MID;
	private String ONAME;
	private String OPHONE;
	private String ODATE;
	private int OQUANTITY;
	private String OPAYMENT;
	private String OADDRESS1;
	private String OADDRESS2;
	private String OZIP;
	private int OSTATUS;
	private int OGROUP;

	public OrderDTO() {
		// TODO Auto-generated constructor stub
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

	public int getONO() {
		return ONO;
	}

	public void setONO(int oNO) {
		ONO = oNO;
	}

	public String getONAME() {
		return ONAME;
	}

	public void setONAME(String oNAME) {
		ONAME = oNAME;
	}

	public String getOPHONE() {
		return OPHONE;
	}

	public void setOPHONE(String oPHONE) {
		OPHONE = oPHONE;
	}

	public String getODATE() {
		return ODATE;
	}

	public void setODATE(String oDATE) {
		ODATE = oDATE;
	}

	public int getOQUANTITY() {
		return OQUANTITY;
	}

	public void setOQUANTITY(int oQUANTITY) {
		OQUANTITY = oQUANTITY;
	}

	public String getOPAYMENT() {
		return OPAYMENT;
	}

	public void setOPAYMENT(String oPAYMENT) {
		OPAYMENT = oPAYMENT;
	}

	public String getOADDRESS1() {
		return OADDRESS1;
	}

	public void setOADDRESS1(String oADDRESS1) {
		OADDRESS1 = oADDRESS1;
	}

	public String getOADDRESS2() {
		return OADDRESS2;
	}

	public void setOADDRESS2(String oADDRESS2) {
		OADDRESS2 = oADDRESS2;
	}

	public String getOZIP() {
		return OZIP;
	}

	public void setOZIP(String oZIP) {
		OZIP = oZIP;
	}

	public int getOSTATUS() {
		return OSTATUS;
	}

	public void setOSTATUS(int oSTATUS) {
		OSTATUS = oSTATUS;
	}

	public int getOGROUP() {
		return OGROUP;
	}

	public void setOGROUP(int oGROUP) {
		OGROUP = oGROUP;
	}

}
