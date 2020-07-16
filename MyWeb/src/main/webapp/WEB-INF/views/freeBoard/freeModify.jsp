<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
        <div class="container">
            <div class="row">
                <div class="col-xs-12 col-md-9 write-wrap">
                        <div class="titlebox">
                            <p>수정하기</p>
                        </div>
                        
                        <form action="" name="modifyForm" method="post">
                            <div>
                                <label>DATE</label>
                                <p><fmt:formatDate value="${boardVO.regdate}" pattern="yyyy-MM-dd"/></p>
                            </div>   
                            <div class="form-group">
                                <label>번호</label>
                                <input class="form-control" name='bno' value="${boardVO.bno}" readonly>
                            </div>
                            <div class="form-group">
                                <label>작성자</label>
                                <input class="form-control" name='writer' value="${boardVO.writer}">
                            </div>    
                            <div class="form-group">
                                <label>제목</label>
                                <input class="form-control" name='title' value="${boardVO.title}">
                            </div>

                            <div class="form-group">
                                <label>내용</label>
                                <textarea class="form-control" rows="10" name='content'>${boardVO.content}</textarea>
                            </div>

                            <button type="button" class="btn btn-dark" id="listBtn">목록</button>    
                            <button type="button" class="btn btn-primary" id="updateBtn">변경</button>
                            <button type="button" class="btn btn-info" id="deleteBtn">삭제</button>
                    </form>
                                    
                </div>
            </div>
        </div>
        </section>
        
        <%@ include file="../include/footer.jsp" %>
        
        <script>
        	//게시판목록페이지로 이동버튼
        	var listBtn = document.getElementById("listBtn");
        	listBtn.onclick = function(){
        		location.href = "freeList";
        	}
        	
        	//게시글 수정 업데이트 버튼
        	var updateBtn = document.getElementById("updateBtn");
        	updateBtn.onclick = function(){
        		if(document.modifyForm.writer.value === ''){
        			alert("작성자 필수");
        			document.modifyForm.writer.focus();
        			return;
        		}else if(document.modifyForm.title.value === ''){
        			alert("제목 필수");
        			document.modifyForm.title.focus();
        			return;
        		}else if(document.modifyForm.content.value === ''){
        			alert("내용 필수");
        			document.modifyForm.content.focus();
        			return;
        		}else{
        			//폼의 action값을 변경
        			document.modifyForm.action = "freeUpdate";
        			document.modifyForm.submit();
        		}
        	}
        	
        	//게시글 삭제 버튼
        	var deleteBtn = document.getElementById("deleteBtn");
        	deleteBtn.onclick = function(){
        		document.modifyForm.action = "freeDelete";
    			document.modifyForm.submit();
        	}
        </script>
</body>
</html>