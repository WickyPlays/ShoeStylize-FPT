<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Forgot password | ShoeStylize</title>
        <link rel="icon" href="./assets/logo.png" type="image/x-icon">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/base.css">

        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/forgot-password.css">
        <link rel="stylesheet" type="text/css"
              href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css"
              integrity="sha512-SzlrxWUlpfuzQ+pcUCosxcglQRNAq/DZjVsC0lE40xsADsfeQoEypE+enwcOiGjk/bSuGGKHEyjSoQ1zVisanQ=="
              crossorigin="anonymous" referrerpolicy="no-referrer"/>
        <link href="https://fonts.googleapis.com/css2?family=Send+Flowers&display=swap" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">

    </head>

    <body>
        <div class="app">
            <jsp:include page="/templates/header.jsp"/>
            <div class="content">
                <div>
                    <div class="content-tab">
                        <h3>Forgot password</h3>
                    </div>
                    <hr>
                    <div class="content-info">
                        <form action="${pageContext.request.contextPath}/forgot-password" method="post">
                            <p>Please type the email address to receive confirmation.</p>
                            <div>
                                <input type="email" name="email" id="i-email" placeholder="Your email">
                            </div>
                            <div>
                                <input type="submit" class="btn btn-success" value="Verify my email">
                            </div>
                        </form>
                            <div class="noti">
                                <p>${noti}</p>
                            </div>
                    </div>
                </div>

            </div>
            <jsp:include page="/templates/footer.jsp"/>
            <script type="text/javascript" src="./js/jquery-3.7.1.min.js"></script>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
                    integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
            crossorigin="anonymous"></script>
            <script type="text/javascript" src="${pageContext.request.contextPath}/js/loader.js"></script>
        </div>

    </body>

</html>