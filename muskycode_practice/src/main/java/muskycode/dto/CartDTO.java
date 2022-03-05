package muskycode.dto;

public class CartDTO {
	private int CNO;
	private int PNO;
	private String MID;
	private int CQUANTITY;

	public CartDTO() {
		// TODO Auto-generated constructor stub
	}

	public int getCNO() {
		return CNO;
	}

	public void setCNO(int cNO) {
		CNO = cNO;
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

	public int getCQUANTITY() {
		return CQUANTITY;
	}

	public void setCQUANTITY(int cQUANTITY) {
		CQUANTITY = cQUANTITY;
	}

}
