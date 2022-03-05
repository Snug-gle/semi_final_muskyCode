package muskycode.dto;

public class ProductDTO {
	private int PNO;
	private String PNAME;
	private int PPRICE;
	private int PSTOCK;
	private String PCATEGORY;
	private String PCONTENT;
	private String PIMGURL;
	private int PSTATUS;

	public ProductDTO() {
		// TODO Auto-generated constructor stub
	}

	public int getPNO() {
		return PNO;
	}

	public void setPNO(int pNO) {
		PNO = pNO;
	}

	public String getPNAME() {
		return PNAME;
	}

	public void setPNAME(String pNAME) {
		PNAME = pNAME;
	}

	public int getPPRICE() {
		return PPRICE;
	}

	public void setPPRICE(int pPRICE) {
		PPRICE = pPRICE;
	}

	public int getPSTOCK() {
		return PSTOCK;
	}

	public void setPSTOCK(int pSTOCK) {
		PSTOCK = pSTOCK;
	}

	public String getPCATEGORY() {
		return PCATEGORY;
	}

	public void setPCATEGORY(String pCATEGORY) {
		PCATEGORY = pCATEGORY;
	}

	public String getPCONTENT() {
		return PCONTENT;
	}

	public void setPCONTENT(String pCONTENT) {
		PCONTENT = pCONTENT;
	}

	public String getPIMGURL() {
		return PIMGURL;
	}

	public void setPIMGURL(String pIMGURL) {
		PIMGURL = pIMGURL;
	}

	public int getPSTATUS() {
		return PSTATUS;
	}

	public void setPSTATUS(int pSTATUS) {
		PSTATUS = pSTATUS;
	}

}
