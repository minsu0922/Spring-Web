<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="ko">
    <head>
		<meta charset="utf-8">
		<title>CKEditor 5</title>
<!-- 		<link rel="icon" type="image/png" href="https://ckeditor.com/assets/images/favicons/32x32.png" sizes="32x32">
		<link rel="icon" type="image/png" href="https://ckeditor.com/assets/images/favicons/96x96.png" sizes="96x96">
		<link rel="apple-touch-icon" type="image/png" href="https://ckeditor.com/assets/images/favicons/120x120.png" sizes="120x120">
		<link rel="apple-touch-icon" type="image/png" href="https://ckeditor.com/assets/images/favicons/152x152.png" sizes="152x152">
		<link rel="apple-touch-icon" type="image/png" href="https://ckeditor.com/assets/images/favicons/167x167.png" sizes="167x167">
		<link rel="apple-touch-icon" type="image/png" href="https://ckeditor.com/assets/images/favicons/180x180.png" sizes="180x180">
	 -->	<link rel="stylesheet" href="./style.css">
		<link rel="stylesheet" href="./ckeditor5/ckeditor5.css">
	</head>
<body>
    <div>
        <div class="main-container">
            <div class="editor-container editor-container_classic-editor editor-container_include-style" id="editor-container">
                <div class="editor-container__editor"><div id="editor"></div></div>
            </div>
        </div>
    </div>

    <script type="importmap">
    {
        "imports": {
            "ckeditor5": "/resources/ckeditor5/ckeditor5.js",
            "ckeditor5/": "/resources/ckeditor5/"
        }
    }
    </script>
    <script type="module" src="/resources/main.js"></script>
 <!--    <script>
        window.onload = function() {
            if ( window.location.protocol === "file:" ) {
                alert( "This sample requires an HTTP server. Please serve this file with a web server." );
            }
        };
    </script> -->
</body>
</html>