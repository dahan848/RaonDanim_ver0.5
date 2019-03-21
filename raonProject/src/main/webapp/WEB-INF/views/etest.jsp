<%@ page language='java' contentType='text/html; charset=UTF-8'
    pageEncoding='UTF-8'%>
<!DOCTYPE html>
<html>
<head>
<meta charset='UTF-8'>
<title>Insert title here</title>
</head>
<body>
<table border='0' cellpadding='0' cellspacing='0' width='100%' style='table-layout: fixed;'>
    <tr>
        <td bgcolor='#ffffff' align='center' style='padding: 70px 15px 70px 15px;' class='section-padding'>
            <table border='0' cellpadding='0' cellspacing='0' width='500' class='responsive-table'>
                <tr>
                    <td>
                        <table width='100%' border='0' cellspacing='0' cellpadding='0'>
                            <tr>
                                <td>
                                    <table width='100%' border='0' cellspacing='0' cellpadding='0'>
                                        <tbody>
                                             <tr>
                                                  <td class='padding-copy'>
                                                      <table width='100%' border='0' cellspacing='0' cellpadding='0'>
                                                          <tr>
                                                              <td>
                                                                  <a target='_blank'><img src='https://i.imgur.com/JhhrjFD.jpg' width='500' height='200' border='0' alt='Can an email really be responsive?' style='display: block; padding: 0; color: #666666; text-decoration: none; font-family: Helvetica, arial, sans-serif; font-size: 16px; width: 500px; height: 200px;' class='img-max'></a>
                                                              </td>
                                                            </tr>
                                                        </table>
                                                  </td>
                                              </tr>
                                        </tbody>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <table width='100%' border='0' cellspacing='0' cellpadding='0'>
                                        <tr>
                                            <td align='center' style='font-size: 25px; font-family: Helvetica, Arial, sans-serif; color: #333333; padding-top: 30px;' class='padding-copy'><br><br>[이름]님 라온다님 회원가입을 환영합니다.</td>
                                        </tr>
                                        <tr>
                                            <td align='center' style='padding: 20px 0 0 0; font-size: 16px; line-height: 25px; font-family: Helvetica, Arial, sans-serif; color: #666666;' class='padding-copy'>하단의 인증 버튼 클릭 시<br>정상적으로 회원가입이 완료됩니다.<br></td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <table width='100%' border='0' cellspacing='0' cellpadding='0' class='mobile-button-container'>
                                        <tr>
                                            <td align='center' style='padding: 25px 0 0 0;' class='padding-copy'>
                                                <table border='0' cellspacing='0' cellpadding='0' class='responsive-table'>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
	<div style='width: 100%; text-align:center;'>
		<div style='margin: 0 auto; '>
		    <form method='post' action='http://localhost:8081/accounts/certify'>
		    <input type='hidden' name='user_id' value='" + user.getUser_id() + "'>
		    <input type='hidden' name='user_verify_code' value='" + user.getUser_verify_code() + "'>
	    	<input type='submit' value='인증' style='font-size: 16px; font-family: Helvetica, Arial, sans-serif; font-weight: normal; color: #ffffff; text-decoration: none; background-color: #5D9CEC; border-top: 15px solid #5D9CEC; border-bottom: 15px solid #5D9CEC; border-left: 25px solid #5D9CEC; border-right: 25px solid #5D9CEC; border-radius: 3px; -webkit-border-radius: 3px; -moz-border-radius: 3px; display: inline-block;' class='mobile-button'></form>
	    </div>
    </div>
</body>
</html>