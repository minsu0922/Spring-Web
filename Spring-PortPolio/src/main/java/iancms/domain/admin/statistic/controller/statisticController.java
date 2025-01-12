package iancms.domain.admin.statistic.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping(value="/admin/statistic/")
public class statisticController {

		// 통계 조회 화면
		@RequestMapping(value = "/statistic_list.do", method = RequestMethod.GET)
		public String statisticList(Model model) throws Exception {
			return "admin/statistic/NewFile";
		}
				
}
