package muskycode.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Random;
import java.util.regex.Pattern;

//웹프로그램 작성에 필요한 기능을 제공하기 위한 클래스
public class Utility {
	//문자열을 전달받아 암호화 처리하여 반환하는 메소드
	public static String encrypt(String source) {
		//암호화된 문자열을 저장하기 위한 변수 선언
		String password="";
		try {
			//MessageDigest : 암호화 처리 기능을 제공하는 클래스
			//MessageDigest.getInstance(String algorithm) : 암호화 처리 알고리즘을 저장한
			//MessageDigest 인스턴스를 반환하는 메소드
			// => 매개변수에 잘못된 암호화 알고리즘이 전달될 경우 NoSuchAlgorithmException 발생
			//암호화 알고리즘(단방향) : MD5, SHA-1, SHA-256(권장), SHA-512 등
			//암호화 알고리즘(쌍방향) : AES-123, RSA 등
			MessageDigest md=MessageDigest.getInstance("SHA-256");
			
			//MessageDigest.update(byte[] input) : MessageDigest 인스턴스에 암호화 처리하기 위한
			//문자열을 byte 배열로 전달받아 저장하는 메소드
			//String.getBytes() : String 인스턴스에 저장된 문자열을 byte 배열로 반환하는 메소드
			md.update(source.getBytes());
			
			//MessageDigest.digest() : MessageDigest 인스턴스에 저장된 정보를 이용하여 암호화  
			//처리하여 byte 배열로 반환하는 메소드 
			byte[] digest=md.digest();
			
			//암호화 처리되어 반환된 byte 배열의 요소값을 16진수 형식의 문자열로 변환하여 변수에 추가하여 저장
			for(int i=0;i<digest.length;i++) {
				password+=Integer.toHexString(digest[i]&0xff);
			}
		} catch (NoSuchAlgorithmException e) {
			System.out.println("[에러]잘못된 암호화 알고리즘을 사용 하였습니다.");
		}
		return password;
	}
	
	//문자열을 전달받아 태그 관련 문자열을 모두 제거하여 반환하는 메소드
	public static String stripTag(String source) {
		//Pattern 클래스 : 정규표현식을 저장하기 위한 클래스
		//Pattern.compile(String regEx) : 정규표현식이 저장된 Pattern 인스턴스를 반환하는 메소드
		//Pattern.CASE_INSENSITIVE : 정규표현식에서 대소문자를 구분하지 않도록 설정하는 상수
		Pattern htmlTag=Pattern.compile("\\<.*?\\>",Pattern.CASE_INSENSITIVE);
		
		//Pattern.matcher(String source) : 정규표현식과 비교값이 저장된 Matcher 인스턴스를 반환하는 메소드
		//Matcher.replaceAll(String replacement) : Matcher 인스턴스에 저장된 비교값에 정규표현식의
		//문자열을 모두 찾아 변환하여 반환하는 메소드
		source=htmlTag.matcher(source).replaceAll("");//문자열에서 태그를 제거하여 반환
		
		return source;
	}
	
	//문자열을 전달받아 태그 관련 기호를 회피문자로 변경하여 반환하는 메소드
	public static String escapeTag(String source) {
		return source.replace("<", "&lt;").replace(">", "&gt;");
	}
	
	//임시비밀번호를 생성하여 반환하는 메소드
	public static String newPassword() {
		//Random : 난수값 관련 기능을 제공하는 클래스
		Random random=new Random();
		
		//비밀번호로 사용될 문자를 저장한 문자열 생성
		String str="0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
		
		String password="";
		for(int i=1;i<=8;i++) {
			//Random.nextInt(int bound) : 0~bound-1 범위의 정수 난수값을 반환하는 메소드
			password+=str.charAt(random.nextInt(str.length()));
		}
		
		return password;
	}
	
}













