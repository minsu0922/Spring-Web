package iancms.global.util;

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;

import org.springframework.util.StringUtils;

/**  
 *  @ 문자열 관련 util
 */

public class StringUtility extends StringUtils {
	
	/**
	 * null을 0으로 변환한다
	 */
	public static String nullToZero(String value) {
		if (value == null || value.equals("")) {
			value = "0";
		}
		return value;
	}
	
	/**
	 * 문자열(value) 중 특정 문자(keys)가 포함되어 있으면 true를 리턴한다
	 */
	public static boolean containsAny(String value, String... keys) {
	    for (String key : keys) {
	        if (value.contains(key)) {
	            return true;
	        }
	    }
	    return false;
	}

	/**
	 * 문자열 좌측의 공백을 제거한다
	 */
	public static String ltrim(String str) {
		int len = str.length();
		int idx = 0;
		while ((idx < len) && (str.charAt(idx) <= ' ')) {
			idx++;
		}
		return str.substring(idx, len);
	}

	/**
	 * 문자열 우측의 공백을 제거한다
	 */
	public static String rtrim(String str) {
		int len = str.length();
		while ((0 < len) && (str.charAt(len - 1) <= ' ')) {
			len--;
		}
		return str.substring(0, len);
	}
	
	/**
	 * beg, end 사이의 문자열을 리턴한다.
	 */
	public static String getTokenString(String str, String beg, String end) {
		int index = str.indexOf(beg);
		String tmp = str.substring(index+1, str.length()).trim();
		index = tmp.indexOf(end);
		tmp = tmp.substring(0, index).trim();
		return tmp;
	}
	
	/**
	 * 문자열 배열을 List로 변환한다
	 */
	public static List<String> toList(String[] values) {
		List<String> list = new ArrayList<String>();
		if (values == null) {
			return list;
		}
		for (int i=0, n=values.length; i < n; i++) {
			list.add(values[i]);
		}
		return list;
	}

	/**
	 * 문자열 배열의 요소들을 ,로 구분하여 하나의 문자열로 반환한다 
	 * @return null, 빈 문자열은 제외하고 반환
	 * @return 빈 문자열 배열은 null로 반환
	 */
	public static String addComma(String[] strs) {
		boolean isAllNull = true;
		StringBuilder sb = new StringBuilder();
		for (String element : strs) {
		    if (element != null && !element.trim().isEmpty()) {
		        isAllNull = false;
		        sb.append(element).append(",");
		    }
		}
		String result = isAllNull ? null : sb.toString();
		if (result != null && result.endsWith(",")) {
		    result = result.substring(0, result.length() - 1);
		}
		return result;
	}
	
	/**
	 * (키워드 전용) 문자열 배열의 요소들을 ,로 구분하여 하나의 문자열로 반환한다 
	 * @param keywordCnt	DB의 키워드 컬럼 글자 제한 수 (마지막 요소가 제한 글자 수를 넘길 시 마지막 요소는 제외)
	 * @return 배열의 요소 중 null, 빈 문자열은 제외하고 반환
	 * @return 빈 문자열 배열은 null로 반환
	 */
	public static String addCommaForKeyword(String... strs) {
		int keywordCnt = 100;
		boolean isAllNull = true;
		StringBuilder sb = new StringBuilder();
		for (String element : strs) {
		    if (element != null && !element.trim().isEmpty()) {
		        isAllNull = false;
				if (sb.length() + element.length() + 1 <= keywordCnt) {
					sb.append(element).append(",");
				} else {
					break;
				}
		    }
		}
		String result = isAllNull ? null : sb.toString();
		if (result != null && result.endsWith(",")) {
		    result = result.substring(0, result.length() - 1);
		}
		return result;
	}	
	
	/**
	 * 문자열에서 ,를 제거한다
	 */
	public static String removeComma(String str) {
		String rtnValue = str;
		if (!hasText(str)) {
			return "";
		}
		rtnValue = replace(rtnValue, ",", "");
		return rtnValue;
	}
	
	/**
	 * 문자열을 화폐 단위(세번째 자리마다 ,표시)로 변환한다
	 */
	public static String toMoney(String str) {
		DecimalFormat df = new DecimalFormat("###,###");
		return df.format(Integer.parseInt(str));
	}

	/**
	 * 백분율을 구한다 (%는 빼고 값만 리턴)
	 */
	public static String percentValue(int value, int total) {
		double val = Double.parseDouble(String.valueOf(value)) / Double.parseDouble(String.valueOf(total)) * 100;
		DecimalFormat df = new DecimalFormat("##0.0");
		return df.format(val);
	}
	
	/**
	 * String 앞 또는 뒤를 특정문자로 지정한 길이만큼 채워준다
	 * ex) pad("1234","0", 6, -1) -> "123400"
	 * @param str    대상 문자열
	 * @param pad    채울 문자열
	 * @param totLen 총 길이
	 * @param mode   앞/뒤 구분 (1:front, -1:back)
	 */
	public static String pad(String str, String pad, int totLen, int mode) {
		if (str == null) return null;
		String paddedString = "";
		int srcLen = str.length();
		if ((totLen < 1) || (srcLen >= totLen)) return str;
		
		for (int i = 0; i < (totLen - srcLen); i++) {
			paddedString += pad;
		}
		if (mode == 1) {
			paddedString += str;
		} else if (mode == -1) {
			paddedString = str + paddedString;
		} else {
			return str;
		}
		return paddedString;
	}
	
	/**
	 * StringBuilder 안 내용을 모두 치환해 준다.
	 */
	public static StringBuilder replaceAll(StringBuilder sb, String from, String to) {
		int index = 0;
		int beg = 0;
		while (index < sb.length()) {
			index = sb.indexOf(from, beg);
			if (index == -1) break;
			
	        sb.replace(index, index + from.length(), to); // 치환 수행
	        beg = index + to.length(); // 시작 위치(beg)를 업데이트하여 다음 검색 위치 설정
		}
		return sb;
	}

	/**
	 * 폴더명에 사용 가능한 문자로 변경한다
	 */
	public static String convertFolderNm(String str) {
		if (!str.isEmpty() && containsAny(str, "/", ":", "?", "|", "\"", "<", ">", "\\", "*")) {
			str = str.replace("/", "／");
			str = str.replace(":", "：");
			str = str.replace("?", "？");
			str = str.replace("|", "｜");
			str = str.replace("\"", "＂");
			str = str.replace("<", "＜");
			str = str.replace(">", "＞");
			str = str.replace("\\", "￦");
			str = str.replace("*", "＊");
		}
		return str;
	}
	
}
