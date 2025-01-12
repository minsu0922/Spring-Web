package iancms.domain.admin.contents.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping(value="/admin/contents/")
public class ContentsController {
	
	// 로그인 화면	
		@RequestMapping(value = "/contentList.do", method = RequestMethod.GET)
		public String contentList(Model model) throws Exception {
			
			return "admin/contents/contentList";
		}

}
