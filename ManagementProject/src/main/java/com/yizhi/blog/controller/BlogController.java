package com.yizhi.blog.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.yizhi.blog.domain.ContentDO;
import com.yizhi.blog.service.ContentService;
import com.yizhi.common.utils.DateUtils;
import com.yizhi.common.utils.PageUtils;
import com.yizhi.common.utils.Query;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RequestMapping("/blog")
@Controller
public class BlogController {
	@Autowired
    ContentService bContentService;

	@GetMapping()
	String blog() {
		return "blog/index/main";
	}

	@ResponseBody
	@GetMapping("/open/list")
	public PageUtils opentList(@RequestParam Map<String, Object> params) {
		// 查询列表数据
		Query query = new Query(params);

		List<ContentDO> bContentList = bContentService.list(query);
		int total = bContentService.count(query);

		PageUtils pageUtils = new PageUtils(bContentList, total);

		return pageUtils;
	}

	@GetMapping("/open/post/{cid}")
	String post(@PathVariable("cid") Long cid, Model model) {
		ContentDO bContentDO = bContentService.get(cid);
		model.addAttribute("bContent", bContentDO);
		model.addAttribute("gtmModified", DateUtils.format(bContentDO.getGtmModified()));
		return "blog/index/post";
	}
	@GetMapping("/open/page/{categories}")
	String about(@PathVariable("categories") String categories, Model model) {
		Map<String, Object> map = new HashMap<>(16);
		map.put("categories", categories);
		ContentDO bContentDO = bContentService.list(map).get(0);
		model.addAttribute("bContent", bContentDO);
		return "blog/index/post";
	}
}
