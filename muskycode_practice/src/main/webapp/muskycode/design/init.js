

(function(i,s,o,g,r,a,m){
  if(i[g]){return;}
  i[g] = {};
  i[g].indexOf=function(t,a,b){for(var i=(b||0),j=t.length;i<j;i++){if(t[i]===a){return i;}}return-1;};
  function getCookieNoescape(a){var b=a+"=";var c=s.cookie;if(c.length>0){startIndex=i[g].indexOf(c,a);if(startIndex!=-1){startIndex+=a.length;endIndex=i[g].indexOf(c,";",startIndex);if(endIndex==-1)endIndex=c.length;return c.substring(startIndex+1,endIndex);}}return false;}
  function getCookie(a){var b=getCookieNoescape(a);if(b){return unescape(b);}return false;}
  

  i[g].is_manager = function(username){
    return i[g].indexOf(["chichs","dj99","handae","mirakong729","gtosec","kyslong","gywls337","mirakong","yhtest","lgs901","thecrema","thecrema1","thecrema2","thecrema3","thecrema4","mc301","1","2","sadmin","kal0304kr","hyunmi246","kimting33","tfed1214","mutnam","gtosec1","nh@1c868","fa@21caf9a","info@bananavote.com","info11530","isoi","safety","hyunsik.choi@cre.ma","cremaphoto","info84628","info28172","supportpublic@cre.ma","supportpubl19280","supportpubl22864","supportpubl14568","sseonaaa@naver.com","supportpubl13222","mem92","supportpublic@crema.me","supportpubl80173","b1234567","0line","qa_test001","qa_test002","qa_test003","qa_test004","qa_test005","jdh0912","perydot","subicura2","mani00000","kyoungpyo_kim","hyuno_chae","khc218","1056342460@k","supportpubl32674","1064902149@k","988895189@k","988894841@k","985383281@k","977536802@k","hyoloveeu","helele223","rdhujh07","felmata","byulys","alsw99","keathy86","optima2@type45.co.kr","crema1","crema2","nv_45565839","barreltest","aeron","kyh2035","swkwon","likiray","xodud1202@naver.com","soohyun.hong@sisun.com","pej4751@gmail.com","okil12","supportpubl85756","mineralbio","crema_dev","intzvill","minizip","test2","mirrh","kyoungmin.kim@mcircle.biz","cremazzang","minizip","test00867@daewoong.co.kr","keh0103@mcircle.biz","dhwlstlr02@naver.com","forsk89@gmail.com","dior810812@naver.com","eoqkrwlehf@naver.com","dubookim@naver.com","supportpubl90635","jsh0501","supportpubl23683","minyoii@naver.com","crema.live.tester@gmail.com","supportpubl96422","reina.lee@cre.ma","reinalee18496","sungjae.an@cre.ma","172531","thecrema@s","zarpar7755","1276cbf71eaa79ffcd86ad1381caf8fa","e026ffb089d9762f5fb7aa1e8a57f5d4","f08affdd736da84962b9419c865a363e","db68cb59ef604d1201f37cd60cbba28a","235d6c8d2983f2997b4afeacba405b46","5e8b98545d1c36537b0d9dc053c90052","142f1b5578e048f6f0ffa024557f2261","3835d92e11477c9d0493da7a3220a73a","dd10b34d643d34e144a431f23bfc95af","920f78da64480c8f0b01cb5ee408648c","byungjoon","edgeu","jsh7520501@naver.com","lan0531@naver.com","kga203","yaya0819","gyojin3770@juicengrocery.com","one827200","supportpubl16355","supportpubl10180","cremademo","supportpubl14174","supportpubl10733","test1234","yjk1220","songhj2","crematestqa3","namye01","skek1703","testshim3","tester1410","crema","supportpubl32674","bavp01","haja0jk@n","bafa01","yh0321","zxc3737","devTest05","devTest07","bare01","bare03","youngv77","salsu99","X0900521","wkrdmstls2","test01","7018577282@s","testid12","kacelab77","fosk0866","qqqre34","duobackcs","hj0467","did8535","forcrema","eqljooeun1015","sosohappy","btomt","altarigo@naver.com","osh3177@gmail.com","supportpubl23055","limhansol","qwe1234","fbtjr1126","sja0705","supportpubl24208","supportpubl21153"], username) !== -1;
  }

  i[g].get_domain_prefix = function(username){
    var hit = i.location.search.match(/crema-test=([a-z])/);
    var testers = {"nuvodi":"s","qatest":"s","qatest1":"s","qatest2":"s","cremaqa002":"s","cremaqa001":"s","littleblack23":"s","crematest":"s","crematest1":"s","qahbs002":"s","17646":"s","cremababy":"s","wisatest":"s","crema1":"s","makespjjang":"s","cremamof":"s","hicrema":"s","cremachma":"s","honey8922":"s","honey5922":"s","rlaaltmf3699":"s","rlaaltmf12345678":"s","mtest":"s","kkktest01":"s","kkktest02":"s","kkktest03":"s","kkktest04":"s","kkktest05":"s","jgminhnc":"s","cremadev":"l","cremahybrid":"t","mtest6":"s","mtest7":"s","mtest8":"s","mtest2":"s","mtest3":"s","mtest4":"s","mtest5":"s","mtest9":"s","dcdc01":"s","dtest01":"d","dtest02":"d","dtest03":"d","dtest04":"d","dtest05":"d","dtest06":"d","dtest07":"d","dtest08":"d","dtest09":"d","dtest10":"d","stest01":"s","stest02":"s","stest03":"s","stest04":"s","stest05":"s","stest06":"s","stest07":"s","stest08":"s","stest09":"s","stest10":"s","stest021":"s","stest022":"s","stest023":"s","stest024":"s","stest025":"s","stest026":"s","stest027":"s","stest028":"s","stest029":"s","stest030":"s","stest031":"s","stest032":"s","stest033":"s","stest034":"s","stest035":"s","stest036":"s","stest037":"s","stest038":"s","stest039":"s","stest040":"s","stest041":"s","stest042":"s","stest043":"s","stest044":"s","stest045":"s","stest046":"s","stest047":"s","stest048":"s","stest049":"s","stest050":"s","cremanew":"s","eunmidtest01":"d","cremaqa1@gmail.com":"s","cremtest":"d","eunmidtest02":"d","eunmistest03":"s","aim555crema":"s","test1":"s","dtest051":"d","supportpublic@crema.me":"s","supportpubl80173":"s","tjdgnsqn3":"d","cremattest":"t","crematttest":"t","mirakong0729":"d","dtest081":"d","tjdgnsqn133":"t","tester1":"s","barreltest":"s","asdlls":"s","asdlld":"s","admin":"s","hbs298":"s","hbs302":"s","hbs304":"s","hbs307":"s","hbs309":"s","hbs312":"s","ymlee23@lotte.com":"s","cremareview":"t","supportpublic@the-nuvo.com":"t","crematestqa3":"d","0line":"s","gi001":"s","X9218297":"s","mswon6":"b"};
    return (hit && hit[1]) || testers[username];
  }

  i[g].init = function(username, user_name){
    if(username){
      username = "" + username;
    }else{
      username = null;
    }
    var user_type;
    var domain_prefix = i[g].get_domain_prefix(username);
    if(domain_prefix){
      if(domain_prefix !== ""){
        i[g] = undefined;
        try{delete i[g];}catch(e){}
        a = s.getElementById("crema-jssdk");
        a.parentNode.removeChild(a);
        a = s.createElement(o);
        a.src = "http://" + domain_prefix + "widgets.cre.ma/mydahlia.co.kr/init.js";
        a.async = 1;
        a.id = "crema-jssdk";
        m = s.getElementsByTagName(o)[0];
        m.parentNode.insertBefore(a,m);
        if(i.cremaAsyncInit){
          i.cremaAsyncInit.hasRun = false;
        }
        return;
      }
      user_type = "tester";
    }else if(i[g].is_manager(username)){
      user_type = "manager";
    }else{
      user_type = "user";
    }

    
    
i[g].info = {
  solution: "cafe24",
  mid: "mydahlia.co.kr",
  locale: "ko-KR",
  username: username,
  user_type: user_type,
  base_url: "http://review6.cre.ma",
  event_base_url: "http://events6.cre.ma",
  fit_base_url: "http://fit6.cre.ma",
  target_widget_base_url: "http://target.cre.ma",
  ad_base_url: "http://ad.cre.ma/mydahlia.co.kr",
  widgets_base_url: "http://widgets.cre.ma",
  review_api_base_url: "http://review-api6.cre.ma",
  fullscreen_popup: false,
  review_use_renewed_popup: true,
  review_use_inducing_popup_for_pc: false,
  review_show_write_popup: true,
  review_max_popup_count_per_day: 1,
  use_legacy_review_for_powerapps: true,
  file_attach_not_supported_powerapps_android_versions: ["4.4"],
  disable_replace_state_in_mobile_app: false,
  matching_review_with_order_code_in_my_orders: true,
  shop_builder: "cafe24",
  login_redirect_parameter: "",
  show_review_widget: true,
  show_target_widget: false,
  show_fit_widget: false,
  secure_privacy: true,
  passphrase: "rUTEtXpVQ8Go",
  use_common_event: false,
  use_toggle_byapps_bottom_menu: true,
  use_fingerprint_device_token: false,
  use_widget_auto_installation: false,
  widget_install_js: "// const installer = crema.cafe24_widget_installer;\n// switch (installer.page_type()) {\n//   case \'main\':\n//     installer.attach_html(\'body\', \'beforeend\', \'<div class=\"crema-popup\"><\/div>\');\n//     break;\n//   case \'my_reviews\':\n//     installer.attach_html(\'#boardSearchForm\', \'beforeend\', \'<div class=\"crema-reviews\" data-type=\"managing-reviews\"><\/div>\');\n//     break;\n//   case \'product_detail\':\n//     installer.attach_html(\'body\', \'beforeend\', \'<div class=\"crema-popup\"><\/div>\');\n//     const product_no = installer.get_product_no_from_url();\n//     installer.attach_html(\'#prdReview .board\', \'afterend\', \'<div class=\"crema-product-reviews\" data-product-code=\"\' + product_no + \'\"><\/div>\');\n//     installer.hide([\'#prdReview .nodata\', \'#prdReview .board\']);\n//     break;\n//   case \'review_board\':\n//     installer.attach_html(\'#boardSearchForm\', \'afterend\', \'<div class=\"crema-reviews\"><\/div>\');\n//     installer.hide([\'.xans-board-listpackage-4\', \'.xans-board-paging-4\', \'#boardSearchForm\']);\n//     break;\n//   case \'my_orders\':\n//     installer.new_review_link(\'a[href*=\"/board/product/write.html\"][href*=\"product_no=\"]\');\n//     break;\n// }\n",
  zone_id: 6
};
if(user_name){i[g].info.user_name = user_name;}

m = s.getElementsByTagName(o)[0];
r = s.createElement(o);
r.async = 1;
r.src = "http://assets6.cre.ma/widgets/assets/pc-bb9ff5bb9a4db73548f63094abdc06ebfce444c94d8eb8abd4d41b480918c201.js";
r.id = "crema-jssdk";
r.charset = "UTF-8";
m.parentNode.insertBefore(r,m);


      r = document.createElement('link');
  r.href = "http://assets6.cre.ma/widgets/assets/pc-c9334d1331a67b88a5bbb28c4c16b01ef5184ab1c165983eb0e8207debdf3b2d.css";
  r.rel = 'stylesheet';
  r.type = 'text/css';
  m.parentNode.insertBefore(r,m);

  };
          i[g].async_load_user_data = function(iframe_manager) {
  var async_set_user_data = function(username) {
    var review_testing = 'false' === 'true';
    var review_operating = 'true' === 'true';
    var fit_testing = 'false' === 'true';
    var is_target_installing = 'false' === 'true';
    var is_shop_manager_testing = (review_testing || fit_testing || is_target_installing) && i[g].info.user_type === 'user' && i[g].is_manager(username);
    if (is_shop_manager_testing) {
      i[g].info.user_type = 'manager';
      if (review_testing) {
        i[g].info.show_review_widget = true;
      }
      if (fit_testing) {
        i[g].info.show_fit_widget = true;
      }
      if (is_target_installing) {
        i[g].info.show_target_widget = true;
      }
      crema.set_widgets();
    }

    if (!is_shop_manager_testing || review_operating) {
      if(username){
        iframe_manager.update_user_data();
      }
    }
    i[g].run(true);
    i[g].log_current_page();
  }

  if(i.CAFE24API){
    var getMemberId = function() {
      var username = null;
      if (!i.CAPP_ASYNC_METHODS) return null;
      i.CAFE24API.getMemberID(function(result) {
        username = result;
      });
      return username;
    }

    var n = 0;
    var interval_for_method = setInterval(function(){
      if(i.CAPP_ASYNC_METHODS || ++n >= 100){
        clearInterval(interval_for_method);

        var m = 0;
        var interval_for_customer_info = setInterval(function(){
          if(getMemberId() || ++m >= 100){
            clearInterval(interval_for_customer_info);
            if(i.CAPP_ASYNC_METHODS) {
              i.CAFE24API.getCustomerInfo(function(err, res) {
                if(err){
                  i[g].info.username = getMemberId();
                }else{
                  var user = res.customer;
                  i[g].info.username = user.member_id;
                  i[g].info.user_name = user.name;
                }
                async_set_user_data(i[g].info.username);
              });
            } else {
              async_set_user_data();
            }
          }
        }, 10);
      }
    }, 10);
  } else {
    async_set_user_data();
  }
};
i[g].init();


})(window,document,"script","crema");

