package com.neusoft.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by Administrator on 2018/12/6.
 */
@Controller
public class IndexController {

    @RequestMapping("/")
    public String index()
    {
        return "index";
    }
}
