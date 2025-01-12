package iancms.global.util;

/**  
 *  @ HTML 변환 관련 util
 */

public class HtmlUtility {

	public HtmlUtility() {
	}

	/**
	 * HTML 태그 제거
	 * @param html
	 * @return
	 */
	public static String removeHtml(String html) {
		if (html == null || html.isEmpty())
			return "";
		return html.replaceAll("&nbsp;", "") //공백태그 제거
				.replaceAll("<meta[^>]*(/)?>", "") //meta 태그 제거
				.replaceAll("<style[^>]*>(.*?)</style>", "")  //css제거
				.replaceAll("<script[^>]*>(.*?)</script>", "") //스크립트 제거
				.replaceAll("<!--[^>]*-->", "")                  //주석처리 제거
				.replaceAll("<(/)?(b|B)(r|R) ?/?>", "\n")
				.replaceAll("</(p|P)>", "\n")
				.replaceAll("<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>", "")  // HTML 태그 제거
				.replaceAll("<o:p>", "")
				.replaceAll("</o:p>", "\n")
				.replaceAll("(<\\?(xml|XML))[^>]*/>", "");
	}
	
	/**
	 * \r\n 문자를 <br/> 로 변환
	 * @param html
	 * @return
	 */
	public static String preview(String html) {
		if (html == null || html.isEmpty())
			return "";
		String preview = html.replaceAll("&nbsp;", "") //공백태그 제거
				.replaceAll("<meta[^>]*(/)?>", "") //meta 태그 제거
				.replaceAll("<style[^>]*>(.*?)</style>", "")  //css제거
				.replaceAll("<script[^>]*>(.*?)</script>", "") //스크립트 제거
				.replaceAll("<!--[^>]*-->", "")                  //주석처리 제거
				.replaceAll("<(/)?(b|B)(r|R)(p|P) ?/?>", "<br/>")
//				.replaceAll("</(p|P)>", "\n")
				.replaceAll("<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>", "")  // HTML 태그 제거
				.replaceAll("<o:p>", "")
				.replaceAll("</o:p>", "\n")
				.replaceAll("\r\n", "<br/>")
				.replaceAll("(<\\?(xml|XML))[^>]*/>", "");
		int len = preview.length() > 100 ? 100: preview.length();
		return preview.substring(0, len);
	}

	/**
	 * \r\n 문자를 <br/> 로 변환
	 * @param html
	 * @return
	 */
	public static String nl2br(String html) {
		if (html == null || html.isEmpty())
			return "";
		StringBuilder sb = new StringBuilder(html);
		StringUtility.replaceAll(sb, "\r\n", "<br/>");
		StringUtility.replaceAll(sb, "\n", "<br/>");
		return sb.toString();
	}

	/**
	 * <br/> 문자를 \r\n 로 변환
	 * @param html
	 * @return
	 */
	public static String br2nl(String html) {
		if (html == null || html.isEmpty())
			return "";
		StringBuilder sb = new StringBuilder(html);
		StringUtility.replaceAll(sb, "<br/>", "\n");
		return sb.toString();
	}

	/**
	 * HTML 문자를 HTML 특수문자로 변환
	 * @param html
	 * @return
	 */
	public static String escape(String html) {
		if (html == null || html.isEmpty())
			return "";
		StringBuilder sb = new StringBuilder(html);
		StringUtility.replaceAll(sb, "&", "&amp;");
		StringUtility.replaceAll(sb, "<", "&lt;");
		StringUtility.replaceAll(sb, ">", "&gt;");
		StringUtility.replaceAll(sb, "\"", "&quot;");
		StringUtility.replaceAll(sb, "'", "&apos;");
		StringUtility.replaceAll(sb, "\n", "<br/>");
		return sb.toString();
	}

	/**
	 * HTML 특수문자를 HTML 문자로 변환
	 * @param html
	 * @return
	 */
	public static String unescape(String html) {
		if (html == null || html.isEmpty())
			return "";
		StringBuilder sb = new StringBuilder(html);
		StringUtility.replaceAll(sb, "&amp;", "&");
		StringUtility.replaceAll(sb, "<br/>", "\n");
		StringUtility.replaceAll(sb, "&apos;", "'");
		StringUtility.replaceAll(sb, "&quot;", "\"");
		StringUtility.replaceAll(sb, "&gt;", ">");
		StringUtility.replaceAll(sb, "&lt;", "<");
		return sb.toString();
	}

	/**
	 * 문자열이 HTML 특수문자를 가지고 있는지 확인
	 * @param str
	 * @return
	 */
	public static Boolean hasHtml(String str) {
		Boolean result = false;
		result = StringUtility.containsAny(str, "&amp;", "<br/>", "&apos;", "&quot;", "&gt;", "&lt;");
		return result;
	}
	
	/**
	 * HTML 문서를 TEXT 형식으로 변환해서 리턴한다.
	 * @param html
	 * @return
	 */
	public static String toText(String html) {
		String text = HtmlUtility.unescape(html);
		return text.replaceAll("&nbsp;", "") //공백태그 제거
				.replaceAll("<meta[^>]*(/)?>", "") //meta 태그 제거
				.replaceAll("<style[^>]*>(.*?)</style>", "")  //css제거
				.replaceAll("<script[^>]*>(.*?)</script>", "") //스크립트 제거
				.replaceAll("<!--[^>]*-->", "")                  //주석처리 제거
				.replaceAll("<(/)?(b|B)(r|R) ?/?>", "\n")
				.replaceAll("</(p|P)>", "\n")
				.replaceAll("<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>", "")  // HTML 태그 제거
				.replaceAll("<o:p>", "")
				.replaceAll("</o:p>", "\n")
				.replaceAll("(<\\?(xml|XML))[^>]*/>", "");
	}
	
	/**
	 * HWP(한글)파일 HTML 문자를 HTML 특수문자로 변환
	 * @param html
	 * @return
	 */
	public static String hwpEscape(String html) {
		if (html == null || html.isEmpty())
			return "";
		StringBuilder sb = new StringBuilder(html);
		StringUtility.replaceAll(sb, "&", "&amp;");
		StringUtility.replaceAll(sb, "<", "&lt;");
		StringUtility.replaceAll(sb, ">", "&gt;");
		StringUtility.replaceAll(sb, "\"", "&quot;");
		return sb.toString();
	}

}
