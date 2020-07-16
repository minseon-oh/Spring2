<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>인덱스를 만들어 보자</title>

    <link href="${pageContext.request.contextPath }/resources/css/bootstrap.css" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
    <!--개인 디자인 추가-->
    <link href="${pageContext.request.contextPath }/resources/css/style.css" rel="stylesheet">
    <script src="${pageContext.request.contextPath }/resources/js/bootstrap.js"></script>
	
	
</head>
<body>

	<%@ include file="../include/header.jsp" %>
   	<!--게시판-->
    <section>
        <div class="container-fluid">
            <div class="row">
                <!--lg에서 9그리드, xs에서 전체그리드-->   
                <div class="col-lg-9 col-xs-12 board-table">
                    <div class="titlebox">
                        <p>자유게시판</p>
                    </div>
                    <hr>
                    
                    <!--form select를 가져온다 -->
                    <form action="freeList">
		    <div class="search-wrap">
		    	<span>총 ${pageVO.total}개</span>
                       <button type="submit" class="btn btn-info search-btn">검색</button>
                       <input type="text" class="form-control search-input" name="searchName">
                       <select class="form-control search-select" name="searchType">
                            <option value="title">제목</option>
                            <option value="content">내용</option>
                            <option value="writer">작성자</option>
                            <option value="titcont">제목+내용</option>
                       </select>
                       
                       <input type="hidden" name="pageNum" value="1">
                       <input type="hidden" name="amount" value="10">                       
                       
                    </div>
		    </form>
                   
                    <table class="table table-bordered">
                        <thead>
                            <tr>
                                <th>번호</th>
                                <th class="board-title">제목</th>
                                <th>작성자</th>
                                <th>등록일</th>
                                <th>수정일</th>
                            </tr>
                        </thead>
                        <tbody>
                        
                        	<c:forEach var="vo" items="${boardList}"> 
	                            <tr>
	                                <td>${vo.bno}</td>
	                                <td><a href="freeDetail?bno=${vo.bno}">${vo.title}</a></td>
	                                <td>${vo.writer}</td>
	                                <td><fmt:formatDate value="${vo.regdate}" pattern="yyyy-MM-dd hh:mm:ss"/></td>
	                                <td><fmt:formatDate value="${vo.updatedate}" pattern="yyyy-MM-dd hh:mm:ss"/></td>
	                            </tr>
	                        </c:forEach>
	                        
                        </tbody>
                        
                    </table>


                    <!--페이지 네이션을 가져옴-->
		    <form action="freeList" name="pageForm">
                    <div class="text-center">
                    <hr>
                    
                    <%-- 
                    <ul class="pagination pagination-sm">
                    	
                    	<c:if test="${pageVO.prev}">
                        <li><a href="freeList?pageNum=${pageVO.startPage -1}&amount=${pageVO.amount}">이전</a></li>
                        </c:if>
                        
                        <c:forEach var="num" begin="${pageVO.startPage }" end="${pageVO.endPage }">
	                        <li class="${num == pageVO.pageNum? 'active' : '' }">
	                        	<a href="freeList?pageNum=${num}&amount=${pageVO.amount}">${num }</a>
	                        </li>
                        </c:forEach>
                        
                        <c:if test="${pageVO.next}">
                        <li><a href="freeList?pageNum=${pageVO.endPage +1}&amount=${pageVO.amount}">다음</a></li>
                        </c:if>
                        
                    </ul>
                    --%>
                    
                     <ul class="pagination pagination-sm" id = "pagenation">
                     <c:if test="${pageVO.prev}">
                        <li><a    href="#" data-pagenum="${pageVO.startPage - 1}">이전</a></li>
                        </c:if>
                        <c:forEach var="i" begin="${pageVO.startPage }"
                           end="${pageVO.endPage }">
                           <li class="${i == pageVO.pageNum ? 'active' : '' }">
                           <a   href="#" data-pagenum="${i}">${i}</a>
                           </li>
                        </c:forEach>
                        <c:if test="${pageVO.next}">
                           <li><a    href="#" data-pagenum="${pageVO.endPage + 1 }">다음</a></li>
                        </c:if>
                     </ul>
                     
                     <!-- 페이지 클릭시 숨겨서 보낼 값 -->
                     <input type = "hidden" name = "pageNum"  value="${pageVO.cri.pageNum}">
                     <input type = "hidden" name = "amount"  value="${pageVO.cri.amount}">
                     <input type = "hidden" name = "searchType"  value="${pageVO.cri.searchType}">
                     <input type = "hidden" name = "searchName"  value="${pageVO.cri.searchName}">

                    
                    <button type="button" class="btn btn-info" onclick="location.href='freeRegist'">글쓰기</button>
                    </div>
		    </form>

                </div>
            </div>
        </div>
	</section>
	<%@ include file="../include/footer.jsp" %>
	
	<script>
		window.onload = function(){//화면로딩이 끝난 직후에 실행
			
			//기록이 변경되었다면 함수종료
			if(history.state === ''){
				return;
			}
			
			var msg = '${msg}';
			if(msg !== ''){
				alert(msg);
				//(추가할 데이터, 페이지 제목, 변경할 주소) - 기존 기록을 삭제하고 새로운 기록을 추가
				//이렇게 추가된 데이터를 history.state로 확인가능
				history.replaceState('',null,null); 
			}
			
		}
		
	
      //페이지
      /*
      	1. 아래페이지버튼을 a태그에서 폼전송으로 변경
      	2. Criteria에 검색키워드를 추가
      	3. 검색폼과, 페이지폼이 동일한 값을 가지고 넘어가도록 hidden값을 추가
      	4. SQL문을 동적쿼리로 변경, total sql문 동적쿼리로변경
      	5. pageVO에 검색키워드를 지정하도록 처리
      	6. 화면에서 페이지폼과 검색폼 select박스 키워드처리, input 태그 키워드처리
      	7. 페이지를 이동하거나,. 검색버튼을 클릭했을 때 검색조건이 유지되도록 처리
      */
      var pagenation = document.getElementById("pagenation");
      pagenation.onclick = function(){
         event.preventDefault();//버튼의 고유 이벤트 속성 중지
         
         var value = event.target.dataset.pagenum; //출력한 타겟의 데이터셋
         document.pageForm.pageNum.value = value;  // 폼에 pageNum 타겟값 저장
         document.pageForm.submit();
         
      }

	</script>

</body>
</html>

