<%@page import="java.sql.PreparedStatement"%>
<%@ page import = "java.io.*,java.util.*" %>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%
String id = request.getParameter("userid");
String driver = "com.mysql.jdbc.Driver";
String connectionUrl = "jdbc:mysql://localhost:3306/";
String database = "blog";
String userid = "root";
String password = "";
Connection connection = null;
Statement statement = null;
ResultSet resultSet = null;
int sameuname=0;
int sameuemail=0;
%>
<!DOCTYPE html>
<html>
  <head>
    <title>Portfolio Java | Sign In</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/style.css">
    <style>
      .mainbody{height:100vh;font-family:var(--fontfamily06);}
      .body2{background:#fff;position: fixed;animation: lol 0.5s forwards;box-shadow:1px 0 6px rgba(0,0,0,0);}
      /* .mbody1{overflow: hidden;z-index: 0;position: fixed;width:100%;background-color: #fff;transition:.3s;} */
      @keyframes navbodyA {
        from{margin-top:0;}
        to{margin-top:-60px;}
      }
      @keyframes navbodyB {
        from{margin-top:-60px;}
        to{margin-top:0;}
      }
      .inrbody2{padding:0 50px;}
      .body2circleBG{display:none;}
      .navtitlebox{padding:10px 0;flex-grow:1;}
      .navtitle{font-size:30px;}
      .navullist{list-style-type:none;}
      .lis{padding:0 5px;}
      .ahr{text-decoration: none;color: #000;padding:5px 10px;}
      .navdecor{background:#000;width:0%;left:50%;height:1px;bottom:0;transition:.35s;}
      .ahr:hover .navdecor{width:60%;left:20%;}
      .nac{width:60%;left:20%;}
      .navlistbox{flex-grow:1;}
      .navbarsbox{display:none;}
      .ibody2B{display:none;}
      .barsbox{height:35px;width:35px;padding-left:0px;}
      .barss{height:2px;width:100%;background:#000;opacity:.7;animation: lol .45s forwards ease-in-out;
        transform: rotate(0deg) translate(0,0);transform-origin: top left;opacity:1;border-radius:2px;}
      .bars3{transform-origin: bottom left;}
      @media only screen and (max-width: 450px) {
        .body2{height: 55px;animation: lol .45s forwards ease-in-out;overflow: hidden;background:#fff;}
        .inrbody2{padding:0 15px;}
        .navlistbox{display: none;}
        .navbarsbox{display:flex;}
        .ibody2B{display:flex;height:60vh;}
        .body2circleBG{height:150px;width:150px;border-radius:50%;top:-150px;right:-150px;transform: scale(1,1);
          animation: lol .45s forwards ease-in-out;background:#000;display:flex;}
        .navullist{flex-direction: column;padding-top:50px;}
        .lis{padding:15px 0;}
        .ahr{text-align: center;width:100%;padding:10px;color:#fff;}
      }
      @keyframes body2A_ {
        from{height:55px;}
        to{height:100vh;}
      }
      @keyframes body2B_ {
        from{height:100vh;}
        to{height:55px;}
      }
      @keyframes body2BgA_ {
        from{transform: scale(1,1);}
        to{transform: scale(15,15);}
      }
      @keyframes body2BgB_ {
        from{transform: scale(15,15);}
        to{transform: scale(1,1);}
      }
      @keyframes bars1A {
        from{transform: rotate(0deg) translate(0,0);background:#000;}
        to{transform: rotate(45deg) translate(4px,-5px);background:#fff;}
      }
      @keyframes bars1B {
        from{transform: rotate(45deg) translate(4px,-5px);background:#fff;}
        to{transform: rotate(0deg) translate(0,0);background:#000;}
      }
      @keyframes bars2A {
        from{transform:translate(0,0);opacity:1;background:#000;}
        to{transform:translate(-12px,0);opacity:0;background:#fff;}
      }
      @keyframes bars2B {
        from{transform:translate(-12px,0);opacity:0;background:#fff;}
        to{transform:translate(0,0);opacity:1;background:#000;}
      }
      @keyframes bars3A {
        from{transform: rotate(0deg) translate(0,0);background:#000;}
        to{transform: rotate(-45deg) translate(4px,5px);background:#fff;}
      }
      @keyframes bars3B {
        from{transform: rotate(-45deg) translate(4px,5px);background:#fff;}
        to{transform: rotate(0deg) translate(0,0);background:#000;}
      }
      .body1{padding-top:60px;height:100vh;}
      .inrbody1{padding:0 100px;overflow: hidden;}
      .room1{height:100%;}
      .signinform{padding:30px 25px;border-radius:3px;}
      .formtitle{font-size:30px;font-weight:500;text-align: center;padding:10px 0;}
      .formtxt0{padding:7px 0 8px 0;font-size:18px;}
      .inputbox0{padding:5px 8px;font-family:var(--fontfamily05);font-size:16px;border-radius:3px;min-width:300px;}
      .formmsg0{padding-top:7px;}
      .formtxt5{text-align: center;text-decoration: underline;cursor: pointer;}
      .loginbtnbox{padding-top:13px;}
      .loginbtn{padding:8px 0px;font-size:20px;text-align: center;border-radius:3px;font-weight:500;background:#a8a8a8;
        border:1px solid #777;cursor: pointer;width:100%;}

      .signinbtnbox{padding-top:15px;}
      .signinbtn{padding:8px 0px;font-size:20px;text-align: center;border-radius:3px;font-weight:500;color:#000;
        border:1px solid #777;cursor: pointer;width:100%;text-decoration: none;}
      .formcover{height:100%;width:100%;top:0;left:0;background:rgba(200,200,200,.8);display:none;}
      .loginmessage{padding:20px 17px;border-radius:5px;font-size:20px;text-align:center;background:#fff;}
      @media only screen and (max-width: 450px) {
        .body1{padding-top:60px;}
        .inrbody1{padding:0 15px;}
        .room1{height:auto;padding-top:80px;}
      }
      <%if(sameuname==1){%>
      .formmsg1::before{content:'This user name is taken';}
      <%}else{%>
      .formmsg1::before{content:'';}
      <%}%>
    </style>
  </head>
  <body>
    <div class="mainbody rel flex fdc">
      <div class="body1 flex fdc abs borde w100">
        <div class="inrbody1 borde h100">
          <div class="room1 borde flex aic jcc rel">
            <form action="signin.jsp" method="POST" class="signinform border rel">
              <div class="formtitle">Sign In</div>
              <div class="formtxt1 formtxt0">Full Name</div>
                <input type="text" class="inputbox1 inputbox0 border" name="userfname">
                <div class="formmsg1 formmsg0 borde"></div>
              <div class="formtxt2 formtxt0">User name</div>
                <input type="text" class="inputbox2 inputbox0 border" name="username">
                <div class="formmsg2 formmsg0 borde"></div>
              <div class="formtxt3 formtxt0">Email</div>
                <input type="text" class="inputbox3 inputbox0 border" name="useremail">
                <div class="formmsg3 formmsg0 borde"></div>
              <div class="formtxt4 formtxt0">Password</div>
                <input type="text" class="inputbox4 inputbox0 border" name="userpass">
                <div class="formmsg4 formmsg0 borde"></div>
              <div class="formtxt1 formtxt0 border">
                <%
//                    out.print("idkkk");
                    String str1 = request.getParameter("username");
                    String str2 = request.getParameter("userfname");
                    String str3 = request.getParameter("useremail");
                    String str4 = request.getParameter("userpass");
                    try{
                    int usrid=5;
                    String tbluname="",tblname="",tblemail="",tblupass="";
                    Class.forName("com.mysql.jdbc.Driver");  
                    connection = DriverManager.getConnection(connectionUrl+database, userid, password);
                    statement=connection.createStatement();
                    String sql = "select * from userinfo where userid = 1";
                    resultSet = statement.executeQuery(sql);
                    while(resultSet.next()){
                        usrid = resultSet.getInt("userid");
                        tbluname = resultSet.getString("username");
                        tblname = resultSet.getString("name");
                        tblemail = resultSet.getString("email");
                        tblupass = resultSet.getString("password");
                        out.print(str1+" = "+tbluname+"<br/>"+str4+" = "+tblupass+"<br/>"+sameuname+"<br/>");
                        if(!str1.equals(tbluname) && !str4.equals(tblupass)){
                        //table name userinfo
                        //attributes => (username,name,email,password)
                            sql = "insert into userinfo(username,name,email,password)values('"+str1+"','"+str2+"','"+str3+"','"+str4+"');";
                            statement.executeUpdate(sql);
                            out.print("Signin Success!!");
                        }
                        else{
                            out.print("Signin Failed!!");
                            if(str1.equals(tbluname)){
                                sameuname=1;
                            }else{
                                sameuname=0;
                            }
                            if(str4.equals(tblupass)){
                                sameuemail=1;
                            }
                            else{
                                sameuemail=0;
                            }
                        }
                    } 
                    
                    connection.close();
                    }catch(Exception ex) {
                        System.out.println(ex.toString());
                    }
                %>
              </div>
              <div class="loginbtnbox borde">
                <input type = "submit" class="loginbtn" value = "Sign In" />
              </div>
              <div class="formtxt5 formtxt0 flex jcc aic">
                  <div class="iformtxt5">Alread have an account?</div>
              </div>
              <div class="formcover border abs flex jcc aic">
                <div class="loginmessage border">
                  Your account is<br/>
                  sucessfully created
                </div>
              </div>
            </form>
          </div>
        </div>
      </div>
      <div class="body2 flex fdc abs borde w100">
        <div class="inrbody2 borde flex fdc rel">
          <div class="body2circleBG flex aic jcc borde abs">+</div>
          <div class="ibody2A borde flex jcsb">
            <div class="navtitlebox borde">
              <div class="navtitle borde">SKYARTS</div>
            </div>
            <div class="navlistbox borde flex aic jcc">
              <ul class="navullist flex borde">
                <li class="lis flex"><a href="#" class="ahr rel"><span class="navdecor abs"></span>Home</a></li>
                <li class="lis flex"><a href="#" class="ahr rel"><span class="navdecor abs"></span>Blog</a></li>
                <li class="lis flex"><a href="#" class="ahr rel"><span class="navdecor abs"></span>Contact</a></li>
                <li class="lis flex"><a href="#" class="ahr rel"><span class="navdecor abs nac"></span>Sign In</a></li>
              </ul>
            </div>
            <div class="navbarsbox borde flex aic">
              <div class="barsbox borde rel flex fdc jcsa aic">
                <span class="bars1 barss"></span>
                <span class="bars2 barss"></span>
                <span class="bars3 barss"></span>
              </div>
            </div>
          </div>
          <div class="ibody2B borde rel">
            <ul class="navullist flex borde w100">
              <li class="lis flex"><a href="#" class="ahr">Home</a></li>
              <li class="lis flex"><a href="#" class="ahr">Blog</a></li>
              <li class="lis flex"><a href="#" class="ahr">Contact</a></li>
              <li class="lis flex"><a href="#" class="ahr">Sign In</a></li>
            </ul>
          </div>
          
        </div>
      </div>
      <!-- <div class="mbody2 flex abs fdc border w100"></div> -->
    </div>
    <script>
      /*
      var body2circleBG = document.querySelector(".body2circleBG");
      var barss = document.querySelectorAll(".barss");
      */
      var barsbox = document.querySelector(".barsbox");
      var body2 = document.querySelector(".body2");
      var body2circleBG = document.querySelector(".body2circleBG");
      var barss = document.querySelectorAll(".barss");
      var barsOpen = false;
      barsbox.addEventListener('click',()=>{
        if(!barsOpen){
          barss[0].style.animationName = "bars1A";
          barss[1].style.animationName = "bars2A";
          barss[2].style.animationName = "bars3A";
          body2.style.animationName = "body2A_";
          body2circleBG.style.animationName = "body2BgA_";
          barsOpen=true;
        }
        else if(barsOpen){
          barss[0].style.animationName = "bars1B";
          barss[1].style.animationName = "bars2B";
          barss[2].style.animationName = "bars3B";
          body2.style.animationName = "body2B_";
          body2circleBG.style.animationName = "body2BgB_";
          barsOpen=false;
        }
      });
    </script>
    <script>
      /*
      var formmsg1 = document.querySelector(".formmsg1");
      var inrgmblock = document.querySelectorAll(".inrgmblock");
      */
     var formmsg1 = document.querySelector(".formmsg1");
    </script>
    <script>
      window.onscroll = function(e) {
        let scroll = this.scrollY;
        console.log(scroll);
        if(scroll > 150){
          body2.style.boxShadow = "1px 0 6px rgba(0,0,0,.5)";
        }
        else{
          body2.style.boxShadow = "1px 0 6px rgba(0,0,0,0)";
        }
        if(this.oldScroll < this.scrollY && scroll > 600){
          body2.style.animationName = "navbodyA";
        }
        else if(this.oldScroll > this.scrollY){
          body2.style.animationName = "navbodyB";
        }
        this.oldScroll = this.scrollY;
      }
       <%if(sameuname==1){out.print("sameuname"+sameuname);%>
            formmsg1.innerHTMl = "This user name is taken";
      <%}else{%>
            formmsg1.innerHTMl = "";
      <%}%>
    </script>
  </body>
</html>
