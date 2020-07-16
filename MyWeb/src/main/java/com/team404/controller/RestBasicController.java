package com.team404.controller;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.team404.command.TestVO;

@RestController
public class RestBasicController {

   //1. RestController는 기본적으로 return에 실린 리졸버 뷰로 전달하는게 아니라, 요청된 주소로 반환합니다.
   @CrossOrigin(origins = "*")
   @GetMapping(value = "/getText", produces = "text/plain; charset=utf-8")
   public String getText() {
      
      return"안녕하세요";
   }
   
   //객체반환(반드시 제이슨데이터바인딩 라이브러리가 필요하다)
   @GetMapping("/getObject")
   public TestVO getObject() {
	   return new TestVO(1,"홍길동","kkk123");
   }
   
   //값을 받고, 객체를 반환
   @GetMapping("/getCollection")
   public ArrayList<TestVO> getCollection(@RequestParam("num") String num) {
	   ArrayList<TestVO> list = new ArrayList<TestVO>();
	   for(int i=1; i<=10; i++) {
		   TestVO vo = new TestVO(1, "홍길자", "aaa123" + num);
		   list.add(vo);
	   }
	   return list;
   }
   
   // /값/값/값 형태로 받고 Map으로 반환
   @GetMapping("/getPath/{id}/{pw}/{name}")
   public HashMap<String, TestVO> getPath(@PathVariable("id") String id,
		   								  @PathVariable("pw") String pw,
		   								  @PathVariable("name") String name){
	   
	   System.out.println(id);
	   System.out.println(pw);
	   System.out.println(name);
	   
	   HashMap<String, TestVO> map = new HashMap<String, TestVO>();
	   TestVO vo = new TestVO(10, "테스트", "test");
	   map.put("info", vo);
	   
	   return map;
	   
   }
   
   //json형태로 받고, 객체로 반환
   //구글확장프로그램 rest Client //http://localhost:8181/myweb/getJson
   @PostMapping("/getJson")
   public ArrayList<TestVO> getJson(@RequestBody TestVO vo){

	   ArrayList<TestVO> list = new ArrayList<TestVO>();
	   list.add(vo);
	   
	   return list;
	   
   }
   
   
}
