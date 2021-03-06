<%@ page contentType="text/html; charset=UTF-8" %>
  <!DOCTYPE html>
  <html lang="zh-cn">

  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>找回密码</title>
    <meta name="viewport" content="initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="full-screen" content="yes">
    <meta name="x5-fullscreen" content="true">

    <link rel="stylesheet" href="css/sm.min.css">
    <link rel="stylesheet" href="css/sm-extend.min.css">
    <link rel="stylesheet" href="css/style.css">

  </head>

  <body>
    <div class="page" id="telephone">
      <header class="bar bar-nav bit">
        <a class="icon icon-left pull-left back bit"></a>
        <h1 class="title bit">忘记密码</h1>
      </header>

      <div class="content">
        <!-- <img class="bit-img" src="https://dummyimage.com/375x150"> -->
        <form method="post">
          <div class="list-block">
            <ul>
              <li>
                <div class="item-content">
                  <div class="item-media">
                    <span class="icon icon-me"></span>
                  </div>
                  <div class="item-inner">
                    <div class="item-input">
                      <input name="name" type="email" placeholder="请输入电子邮箱">
                    </div>
                  </div>
                </div>
              </li>
              <li>
                <div class="item-content">
                  <div class="item-media">
                    <span class="icon icon-edit"></span>
                  </div>
                  <div class="item-inner">
                    <div class="item-input">
                      <input name="code" type="text" placeholder="请输入验证码">
                    </div>
                    <input type="button" onclick="gkey()" class="button button-fill login bit disabled btn" style="width:6rem;" value="获取验证码"
                      disabled="disabled">
                  </div>
                </div>
              </li>
            </ul>
          </div>
          <div class="content-block">
            <input type="button" onclick="next()" class="button button-big button-fill button-danger login disabled bit" value="下一步"
              disabled="disabled">
          </div>

        </form>
      </div>
    </div>
    <script type="text/javascript" src="js/zepto.min.js" charset="utf-8"></script>
    <script type="text/javascript" src="js/sm.min.js" charset="utf-8"></script>
    <script type="text/javascript" src="js/sm-extend.min.js" charset="utf-8"></script>
    <!-- 判断网络是否可用，不可用时显示toast提示 -->
    <script>
      if (window.navigator.onLine == false) { $.toast("无可用网络，请检查网络设置~"); }

      // 表单验证
      $('input').bind('input propertychange', function () {
        var email = $("input[type='email']").val();
        var key = $("input[type='text']").val();
        var gitkey = $('.btn');
        var next = $("input[type='button']");
        var Reg = /^[a-zA-Z0-9_-]+@([a-zA-Z0-9]+\.)+(com|cn|net|org)$/;

        if (Reg.test(email)) {
          gitkey.removeClass("disabled");
          gitkey.removeAttr("disabled");
          if (key != "") {
            next.removeClass("disabled");
            next.removeAttr("disabled");
          }
        }

        if (Reg.test(email) == false) {
          gitkey.addClass("disabled");
          gitkey.attr("disabled", "disabled");
          if (Reg.test(email) && key == "") {
            next.addClass("disabled");
            next.attr("disabled", "disabled");
          }
        }
      });

      var countdown = 60;
      function check() {
        var gitkey = $('.btn');
        if (countdown == 0) {
          gitkey.removeClass("disabled");
          gitkey.removeAttr("disabled");
          gitkey.val("获取验证码");
          countdown = 60;
          return;
        } else {
          gitkey.addClass("disabled");
          gitkey.attr("disabled", "disabled");
          gitkey.val("重新发送(" + countdown + ")");
          countdown--;
          setTimeout('check()', 1000);
        }
      }

      function gkey() {
        $.ajax({
          type: "get",
          url: "/BitCandy/sendConfirmCode/" + $("[name=name]").val().toString(), //TODO 获取邮箱地址加入url
          success: function (response) {
            if (response == "1") {
              $.toast("验证码发送成功");
              check();
            } else if (response == "0") {
              $.toast("没有此用户");
            }
          }
        })
      }

      function next() {
        var text = "name=" + $("[name=name]").val().toString() + "&code=" + $("[name=code]").val().toString();
        $.ajax({
          data: text,
          type: "post",
          url: "/BitCandy/checkForChange",
          success: function (response) {
            if (response == "1") {
              window.location.href = "changePwd";
            } else {
              $.toast("验证码错误");
            }
          }
        })
      }

    </script>
  </body>

  </html>