$(function(){ 
    if($(".menuCategory > li").length==0){
         $(".menuCategory").hide();
    };
});
/**
 * 조건별 검색 기능 스크립트
 */
$(document).ready(function()
{
    var sParentElement = 'select.SecondSelect';
    $('select.FirstSelect').change(function()
    {
        var iGroupNo = $(this).find('option:selected').val();
        if (iGroupNo > 0) {
            $.ajax({
                url : '/product/provider/selectsearch.xml?GroupNo=' + iGroupNo,
                dataType : 'text',
                success : function(data){
                    if ( window.DOMParser ) {
                        tmp = new DOMParser();
                        xml = tmp.parseFromString( data , "text/xml" );
                    } else {
                        xml = new ActiveXObject( "Microsoft.XMLDOM" );
                        xml.async = "false";
                        xml.loadXML( data );
                    }

                    $(sParentElement).html('');
                    getOptionElement('','-세부항목선택-').appendTo(sParentElement);
                    var nodes = $(xml).find('searchkey');
                    for ( var x = 0 ; x < nodes.length ; x++) {
                        getOptionElement($(nodes[x]).find('search_value').text(),$(nodes[x]).find('search_value').text()).appendTo(sParentElement);
                    }
                }
            });
        }
    });
    $('a.SelectSearch').click(function()
    {
        var sGroup = $('select.FirstSelect').val();
        var sItem = $('select.SecondSelect').val();
        if (!sGroup) {
            alert('조건을 선택해 주세요.');
            return false;
        }
        if (!sItem) {
            alert('세부 항목을 선택해 주세요.');
            return false;
        }
        location.href = document.location.href.split('?')[0].split(document.domain)[1] + '?' + sSSUrl + '&sGroup=' + sGroup + '&sItem=' + sItem;
    });

    function getOptionElement(sVal, sTitle)
    {
        return $("<option value='" + sVal + "'>" + sTitle + "</option>");
    }
});
/**
 * 카테고리 마우스 오버 이미지
 * 카테고리 서브 메뉴 출력
 */

$(document).ready(function(){

    var methods = {
        aCategory    : [],
        aSubCategory : {},

        get: function()
        {
             $.ajax({
                url : '/exec/front/Product/SubCategory',
                dataType: 'json',
                success: function(aData) {

                    if (aData == null || aData == 'undefined') return;
                    for (var i=0; i<aData.length; i++)
                    {
                        var sParentCateNo = aData[i].parent_cate_no;

                        if (!methods.aSubCategory[sParentCateNo]) {
                            methods.aSubCategory[sParentCateNo] = [];
                        }

                        methods.aSubCategory[sParentCateNo].push( aData[i] );
                    }
                }
            });
        },

        getParam: function(sUrl, sKey) {

            var aUrl         = sUrl.split('?');
            var sQueryString = aUrl[1];
            var aParam       = {};

            if (sQueryString) {
                var aFields = sQueryString.split("&");
                var aField  = [];
                for (var i=0; i<aFields.length; i++) {
                    aField = aFields[i].split('=');
                    aParam[aField[0]] = aField[1];
                }
            }
            return sKey ? aParam[sKey] : aParam;
        },

        getParamSeo: function(sUrl) {
            var aUrl         = sUrl.split('/');
            return aUrl[3] ? aUrl[3] : null;
        },

        show: function(overNode, iCateNo) {

            if (methods.aSubCategory[iCateNo].length == 0) {
                return;
            }

            var aHtml = [];
            aHtml.push('<ul>');
            $(methods.aSubCategory[iCateNo]).each(function() {
                aHtml.push('<li><a href="'+this.link_product_list+'">'+this.name+'</a></li>');
            });
            aHtml.push('</ul>');


            var offset = $(overNode).offset();
            $('<div class="sub-category"></div>')
                .appendTo(overNode)
                .html(aHtml.join(''))
                .find('li').mouseover(function(e) {
                    $(this).addClass('over');
                }).mouseout(function(e) {
                    $(this).removeClass('over');
                });
        },

        close: function() {
            $('.sub-category').remove();
        }
    };

    methods.get();


        /*$('.xans-layout-category li').mouseenter(function(e) {
        var $this = $(this).addClass('on'),
        iCateNo = Number(methods.getParam($this.find('a').attr('href'), 'cate_no'));

        if (!iCateNo) {
            iCateNo = Number(methods.getParamSeo($this.find('a').attr('href')));
        }

        if (!iCateNo) {
           return;
        }

        methods.show($this, iCateNo);
     }).mouseleave(function(e) {
        $(this).removeClass('on');

          methods.close();
     });*/
    
    (function($) {
        $(function() {
            $('.xans-layout-category li.cate1').each(function(e) {

                var $this = $(this).addClass('on'),
                    iCateNo = Number(methods.getParam($this.find('a').attr('href'), 'cate_no'));
                if (!iCateNo) {
                    iCateNo = Number(methods.getParamSeo($this.find('a').attr('href')));
                }
                if (!iCateNo) {
                    return;
                }

                $(this).children('a').addClass('cateList').prepend('<span class="icon"></span>');

                setTimeout(function () {
                    methods.show($this, iCateNo);
                },200);

                //asdf

                setTimeout(function () {
                    $(".leftCategory > .category > .position > li > .sub-category").each(function() {
                        var sublen = $(this).find("li").length;
                        if (sublen > 0)
                        {
                            /*
							var st = $(this).parent().find(".st");				
							st.prependTo(this);
					     	var cc1 = - ($(this).width() / 2);
                            var cc2 = $(this).parent().width() / 2;
                            $(this).css("left",cc1 + cc2);*/
                        } else {
                            $(this).remove();
                        }

                    });
                },210);	

            },function(){		
                $(this).removeClass('on');
                methods.close();
            });
        }); 		
        $(".btn-allcate").click(function(){
            $(".allCate_con ul").remove();
            var cateClone = $(".category > ul").clone();
            cateClone.prependTo(".allCate_con");
            //$(".allCate_con > .position > li").eq(0).remove();  /* 첫번째 삭제*/
        });
        $("#allCate .sub-category > ul > li").click(function(){
            window.location = $(this).find("a").attr("href");
        });
    })(jQuery);
});

setTimeout(function () {
    $(".category > .position > li > .sub-category").each(function(){
        var st = $(this).find(".st")
        var stlen = st.length;
        if (stlen > 0)
        {			
            var thisW = $(this).width();
            var thisH = $(this).height();
            var stW = st.width() + thisW;
            var stW2 = stW + 80;		
            $(this).css("width",stW2);
            var stH = st.height();
            var stH2 = stH + 0;
            if (stH > thisH)
            {	
                $(this).css("height",stH2);
            }
        }
    });
},300);	

$('.leftCategory .category > ul > li.etc').each(function(){
    var etcDisplay = $(this).css('display');
    if (etcDisplay=='none')
    {
        $(this).remove();
    }
});
/**
 * 움직이는 배너 Jquery Plug-in
 * @author  cafe24
 */

(function($){

    $.fn.floatBanner = function(options) {
        options = $.extend({}, $.fn.floatBanner.defaults , options);

        return this.each(function() {
            var aPosition = $(this).position();
            var jbOffset = $(this).offset();
            var node = this;

            $(window).scroll(function() {
                var _top = $(document).scrollTop();
                _top = (aPosition.top < _top) ? _top : aPosition.top;

                setTimeout(function () {
                    var newinit = $(document).scrollTop();

                    if ( newinit > jbOffset.top ) {
                        _top -= jbOffset.top;
                        var container_height = $("#wrap").height();
                        var quick_height = $(node).height();
                        var cul = container_height - quick_height;
                        if(_top > cul){
                            _top = cul;
                        }
                    }else {
                        _top = 0;
                    }

                    $(node).stop().animate({top: _top}, options.animate);
                }, options.delay);
            });
        });
    };

    $.fn.floatBanner.defaults = {
        'animate'  : 500,
        'delay'    : 500
    };

})(jQuery);

/**
 * 문서 구동후 시작
 */
$(document).ready(function(){
    $('#banner:visible, #quick:visible').floatBanner();

    //placeholder
    $(".ePlaceholder input, .ePlaceholder textarea").each(function(i){
        var placeholderName = $(this).parents().attr('title');
        $(this).attr("placeholder", placeholderName);
    });
    /* placeholder ie8, ie9 */
    $.fn.extend({
        placeholder : function() {
            //IE 8 버전에는 hasPlaceholderSupport() 값이 false를 리턴
           if (hasPlaceholderSupport() === true) {
                return this;
            }
            //hasPlaceholderSupport() 값이 false 일 경우 아래 코드를 실행
            return this.each(function(){
                var findThis = $(this);
                var sPlaceholder = findThis.attr('placeholder');
                if ( ! sPlaceholder) {
                   return;
                }
                findThis.wrap('<label class="ePlaceholder" />');
                var sDisplayPlaceHolder = $(this).val() ? ' style="display:none;"' : '';
                findThis.before('<span' + sDisplayPlaceHolder + '>' + sPlaceholder + '</span>');
                this.onpropertychange = function(e){
                    e = event || e;
                    if (e.propertyName == 'value') {
                        $(this).trigger('focusout');
                    }
                };
                //공통 class
                var agent = navigator.userAgent.toLowerCase();
                if (agent.indexOf("msie") != -1) {
                    $(".ePlaceholder").css({"position":"relative"});
                    $(".ePlaceholder span").css({"position":"absolute", "padding":"0 4px", "color":"#878787"});
                    $(".ePlaceholder label").css({"padding":"0"});
                }
            });
        }
    });

    $(':input[placeholder]').placeholder(); //placeholder() 함수를 호출

    //클릭하면 placeholder 숨김
    $('body').delegate('.ePlaceholder span', 'click', function(){
        $(this).hide();
    });

    //input창 포커스 인 일때 placeholder 숨김
    $('body').delegate('.ePlaceholder :input', 'focusin', function(){
        $(this).prev('span').hide();
    });

    //input창 포커스 아웃 일때 value 가 true 이면 숨김, false 이면 보여짐
    $('body').delegate('.ePlaceholder :input', 'focusout', function(){
        if (this.value) {
            $(this).prev('span').hide();
        } else {
            $(this).prev('span').show();
        }
    });

    //input에 placeholder가 지원이 되면 true를 안되면 false를 리턴값으로 던져줌
    function hasPlaceholderSupport() {
        if ('placeholder' in document.createElement('input')) {
            return true;
        } else {
            return false;
        }
    }
});

/**
 *  썸네일 이미지 엑박일경우 기본값 설정
 */
$(window).load(function() {
    $("img.thumb,img.ThumbImage,img.BigImage").each(function($i,$item){
        var $img = new Image();
        $img.onerror = function () {
                $item.src="//img.echosting.cafe24.com/thumb/img_product_big.gif";
        }
        $img.src = this.src;
    });
});

/**
 *  tooltip
 */
$('.eTooltip').each(function(i){
    $(this).find('.btnClose').attr('tabIndex','-1');
});
//tooltip input focus
$('.eTooltip').find('input').focus(function() {
    var targetName = returnTagetName(this);
    targetName.siblings('.ec-base-tooltip').show();
});
$('.eTooltip').find('input').focusout(function() {
    var targetName = returnTagetName(this);
    targetName.siblings('.ec-base-tooltip').hide();
});
function returnTagetName(_this){
    var ePlacename = $(_this).parent().attr("class");
    var targetName;
    if(ePlacename == "ePlaceholder"){ //ePlaceholder 대응
        targetName = $(_this).parents();
    }else{
        targetName = $(_this);
    }
    return targetName;
}

/**
 *  eTab
 */
 $("body").delegate(".eTab a", "click", function(e){
    // 클릭한 li 에 selected 클래스 추가, 기존 li에 있는 selected 클래스는 삭제.
    var _li = $(this).parent("li").addClass("selected").siblings().removeClass("selected"),
    _target = $(this).attr("href"),
    _siblings = $(_target).attr("class"),
    _arr = _siblings.split(" "),
    _classSiblings = "."+_arr[0];

    //클릭한 탭에 해당하는 요소는 활성화, 기존 요소는 비활성화 함.
    $(_target).show().siblings(_classSiblings).hide();


    //preventDefault 는 a 태그 처럼 클릭 이벤트 외에 별도의 브라우저 행동을 막기 위해 사용됨.
    e.preventDefault();
});



$(document).ready(function(){
    $("#header .top_section .contents ul.right .search").click(function(){
        $(".searchWrap").slideToggle();
    });
});

/* 상품가 할인율 (메인,상품목록) */
<!-- 
function calculate_discount() {
	$('.discount').each(function() {

		var custom = $(this).attr('data-custom');
		var price = $(this).attr('data-price');

		custom = parseInt(custom.replace(/,/g, ''));
		price = parseInt(price.replace(/,/g, ''));

		var rate = 0;
		if (!isNaN(custom) && !isNaN(price) && 0 < custom) {
			rate = Math.round((custom - price) / custom * 100);
		}
		if(rate>0) {
			$(this).html(rate + '<span>%</span>')/*.css("box-shadow" , "2px 4px 9px 2px rgba(0,0,0,0.05)").css("background" , "#fff");*/
		}

		$(this).removeAttr('data-custom');
		$(this).removeAttr('data-price');
	});
}

$(document).ready(function() {
	calculate_discount();
});

/* 카테고리 상단고정 */
$( document ).ready( function() {
    var jbOffset = $( '#header' ).offset();
    $( window ).scroll( function() {
      if ( $( document ).scrollTop() > jbOffset.top ) {
        $( '#header' ).addClass( 'fixed' );
      }
      else {
        $( '#header' ).removeClass( 'fixed' );
      }
    });
  });


/* prd tab */
$(document).ready(function(){
    $(".prd_tab .tab_menu li").click(function(){
        var thisNum = $(this).index();
        console.log(thisNum);
        $(".prd_tab .tab_menu li").removeClass("active");
        $(this).addClass("active");
        $(".prd_tab .prd").hide();
        $(".prd_tab .prd").eq(thisNum).show();
    });
});

/* 스크롤시 나타나는 TOP버튼 */
$(document).ready(function(){
    $(window).scroll(function () {
        if ($(this).scrollTop() > 10) { 
            $('.sns_area').fadeIn();
        } else {
            $('.sns_area').fadeOut();
        }
    });
});

/* ft_banner */
$(document).ready(function(){
    $(".mainBanner01 .section ul li").mouseover(function(){
        $(this).find(".img").css({"top":"-10px"});
    }).mouseleave(function(){
        $(this).find(".img").css({"top":0});
    });

    /* 스크롤시 나타나는 TOP버튼 */
    $(document).ready(function(){
        $(window).scroll(function () {
            if ($(this).scrollTop() > 10) { 
                $('.back-top').fadeIn();
            } else {
                $('.back-top').fadeOut();
            }
        });

        $('.back-top').click(function () {
            $('body,html').animate({
                scrollTop: 0
            }, 200);
            return false;
        });
    });

    /*** TOP,BOTTOM 버튼 ***/
    $(document).ready(function(){
        var top_btn = $("#goBtn").offset().top;
        $(window).scroll(function(){
            if($(window).scrollTop() > top_btn+400) {
                $('#goBtn').addClass('btnFixed');
            }

        });

        $(".btn.up").click(function(){
            return $("html, body").animate({scrollTop:0},1200,"easeInOutExpo"),!1});

        $(".btn.down").click(function(){
            return $("html, body").animate({scrollTop:$(document).height()},1200,"easeInOutExpo"),!1});
    });    
});
    
/* 리뷰 게시판 마우스 엔터 효과 */
$(document).ready(function() {
    $('.main_board .galleryList li').mouseover(function(e) {
       $(this).find(".imgLink").css({"top":"-10px"});
    }).mouseleave(function(){
        $(this).find(".imgLink").css({"top":0});       
    });
});    


jQuery.easing.jswing=jQuery.easing.swing;jQuery.extend(jQuery.easing,{def:"easeOutQuad",swing:function(e,f,a,h,g){return jQuery.easing[jQuery.easing.def](e,f,a,h,g)},easeInQuad:function(e,f,a,h,g){return h*(f/=g)*f+a},easeOutQuad:function(e,f,a,h,g){return -h*(f/=g)*(f-2)+a},easeInOutQuad:function(e,f,a,h,g){if((f/=g/2)<1){return h/2*f*f+a}return -h/2*((--f)*(f-2)-1)+a},easeInCubic:function(e,f,a,h,g){return h*(f/=g)*f*f+a},easeOutCubic:function(e,f,a,h,g){return h*((f=f/g-1)*f*f+1)+a},easeInOutCubic:function(e,f,a,h,g){if((f/=g/2)<1){return h/2*f*f*f+a}return h/2*((f-=2)*f*f+2)+a},easeInQuart:function(e,f,a,h,g){return h*(f/=g)*f*f*f+a},easeOutQuart:function(e,f,a,h,g){return -h*((f=f/g-1)*f*f*f-1)+a},easeInOutQuart:function(e,f,a,h,g){if((f/=g/2)<1){return h/2*f*f*f*f+a}return -h/2*((f-=2)*f*f*f-2)+a},easeInQuint:function(e,f,a,h,g){return h*(f/=g)*f*f*f*f+a},easeOutQuint:function(e,f,a,h,g){return h*((f=f/g-1)*f*f*f*f+1)+a},easeInOutQuint:function(e,f,a,h,g){if((f/=g/2)<1){return h/2*f*f*f*f*f+a}return h/2*((f-=2)*f*f*f*f+2)+a},easeInSine:function(e,f,a,h,g){return -h*Math.cos(f/g*(Math.PI/2))+h+a},easeOutSine:function(e,f,a,h,g){return h*Math.sin(f/g*(Math.PI/2))+a},easeInOutSine:function(e,f,a,h,g){return -h/2*(Math.cos(Math.PI*f/g)-1)+a},easeInExpo:function(e,f,a,h,g){return(f==0)?a:h*Math.pow(2,10*(f/g-1))+a},easeOutExpo:function(e,f,a,h,g){return(f==g)?a+h:h*(-Math.pow(2,-10*f/g)+1)+a},easeInOutExpo:function(e,f,a,h,g){if(f==0){return a}if(f==g){return a+h}if((f/=g/2)<1){return h/2*Math.pow(2,10*(f-1))+a}return h/2*(-Math.pow(2,-10*--f)+2)+a},easeInCirc:function(e,f,a,h,g){return -h*(Math.sqrt(1-(f/=g)*f)-1)+a},easeOutCirc:function(e,f,a,h,g){return h*Math.sqrt(1-(f=f/g-1)*f)+a},easeInOutCirc:function(e,f,a,h,g){if((f/=g/2)<1){return -h/2*(Math.sqrt(1-f*f)-1)+a}return h/2*(Math.sqrt(1-(f-=2)*f)+1)+a},easeInElastic:function(f,h,e,l,k){var i=1.70158;var j=0;var g=l;if(h==0){return e}if((h/=k)==1){return e+l}if(!j){j=k*0.3}if(g<Math.abs(l)){g=l;var i=j/4}else{var i=j/(2*Math.PI)*Math.asin(l/g)}return -(g*Math.pow(2,10*(h-=1))*Math.sin((h*k-i)*(2*Math.PI)/j))+e},easeOutElastic:function(f,h,e,l,k){var i=1.70158;var j=0;var g=l;if(h==0){return e}if((h/=k)==1){return e+l}if(!j){j=k*0.3}if(g<Math.abs(l)){g=l;var i=j/4}else{var i=j/(2*Math.PI)*Math.asin(l/g)}return g*Math.pow(2,-10*h)*Math.sin((h*k-i)*(2*Math.PI)/j)+l+e},easeInOutElastic:function(f,h,e,l,k){var i=1.70158;var j=0;var g=l;if(h==0){return e}if((h/=k/2)==2){return e+l}if(!j){j=k*(0.3*1.5)}if(g<Math.abs(l)){g=l;var i=j/4}else{var i=j/(2*Math.PI)*Math.asin(l/g)}if(h<1){return -0.5*(g*Math.pow(2,10*(h-=1))*Math.sin((h*k-i)*(2*Math.PI)/j))+e}return g*Math.pow(2,-10*(h-=1))*Math.sin((h*k-i)*(2*Math.PI)/j)*0.5+l+e},easeInBack:function(e,f,a,i,h,g){if(g==undefined){g=1.70158}return i*(f/=h)*f*((g+1)*f-g)+a},easeOutBack:function(e,f,a,i,h,g){if(g==undefined){g=1.70158}return i*((f=f/h-1)*f*((g+1)*f+g)+1)+a},easeInOutBack:function(e,f,a,i,h,g){if(g==undefined){g=1.70158}if((f/=h/2)<1){return i/2*(f*f*(((g*=(1.525))+1)*f-g))+a}return i/2*((f-=2)*f*(((g*=(1.525))+1)*f+g)+2)+a},easeInBounce:function(e,f,a,h,g){return h-jQuery.easing.easeOutBounce(e,g-f,0,h,g)+a},easeOutBounce:function(e,f,a,h,g){if((f/=g)<(1/2.75)){return h*(7.5625*f*f)+a}else{if(f<(2/2.75)){return h*(7.5625*(f-=(1.5/2.75))*f+0.75)+a}else{if(f<(2.5/2.75)){return h*(7.5625*(f-=(2.25/2.75))*f+0.9375)+a}else{return h*(7.5625*(f-=(2.625/2.75))*f+0.984375)+a}}}},easeInOutBounce:function(e,f,a,h,g){if(f<g/2){return jQuery.easing.easeInBounce(e,f*2,0,h,g)*0.5+a}return jQuery.easing.easeOutBounce(e,f*2-g,0,h,g)*0.5+h*0.5+a}});
/*! Respond.js v1.4.2: min/max-width media query polyfill
 * Copyright 2014 Scott Jehl
 * Licensed under MIT
 * http://j.mp/respondjs */

//window popup script
function winPop(url) {
    window.open(url, "popup", "width=300,height=300,left=10,top=10,resizable=no,scrollbars=no");
}
/**
 * document.location.href split
 * return array Param
 */
function getQueryString(sKey)
{
    var sQueryString = document.location.search.substring(1);
    var aParam       = {};

    if (sQueryString) {
        var aFields = sQueryString.split("&");
        var aField  = [];
        for (var i=0; i<aFields.length; i++) {
            aField = aFields[i].split('=');
            aParam[aField[0]] = aField[1];
        }
    }

    aParam.page = aParam.page ? aParam.page : 1;
    return sKey ? aParam[sKey] : aParam;
};

$(document).ready(function(){
    // tab
    $.eTab = function(ul){
        $(ul).find('a').click(function(){
            var _li = $(this).parent('li').addClass('selected').siblings().removeClass('selected'),
                _target = $(this).attr('href'),
                _siblings = '.' + $(_target).attr('class');
            $(_target).show().siblings(_siblings).hide();
            return false
        });
    }
    if ( window.call_eTab ) {
        call_eTab();
    };
});
(function($){
$.fn.extend({
    center: function() {
        this.each(function() {
            var
                $this = $(this),
                $w = $(window);
            $this.css({
                position: "absolute",
                top: ~~(($w.height() - $this.outerHeight()) / 2) + $w.scrollTop() + "px",
                left: ~~(($w.width() - $this.outerWidth()) / 2) + $w.scrollLeft() + "px"
            });
        });
        return this;
    }
});
$(function() {
    var $container = function(){/*
<div id="modalContainer">
    <iframe id="modalContent" scroll="0" scrolling="no" frameBorder="0"></iframe>
</div>');
*/}.toString().slice(14,-3);
    $('body')
    .append($('<div id="modalBackpanel"></div>'))
    .append($($container));
    function closeModal () {
        $('#modalContainer').hide();
        $('#modalBackpanel').hide();
    }
    $('#modalBackpanel').click(closeModal);
    zoom = function ($piProductNo, $piCategoryNo, $piDisplayGroup) {
        var $url = '/product/image_zoom.html?product_no=' + $piProductNo + '&cate_no=' + $piCategoryNo + '&display_group=' + $piDisplayGroup;
        $('#modalContent').attr('src', $url);
        $('#modalContent').bind("load",function(){
            $(".header .close",this.contentWindow.document.body).bind("click", closeModal);
        });
        $('#modalBackpanel').css({width:$("body").width(),height:$("body").height(),opacity:.4}).show();
        $('#modalContainer').center().show();
    }
});
})(jQuery);
$(document).ready(function(){
    if (typeof(EC_SHOP_MULTISHOP_SHIPPING) != "undefined") {
        var sShippingCountryCode4Cookie = 'shippingCountryCode';
        var bShippingCountryProc = false;

        // 배송국가 선택 설정이 사용안함이면 숨김
        if (EC_SHOP_MULTISHOP_SHIPPING.bMultishopShippingCountrySelection === false) {
            $('.xans-layout-multishopshipping .xans-layout-multishopshippingcountrylist').hide();
            $('.xans-layout-multishoplist .xans-layout-multishoplistmultioption .xans-layout-multishoplistmultioptioncountry').hide();
        } else {
            $('.thumb .xans-layout-multishoplistitem').hide();
            var aShippingCountryCode = document.cookie.match('(^|;) ?'+sShippingCountryCode4Cookie+'=([^;]*)(;|$)');
            if (typeof(aShippingCountryCode) != 'undefined' && aShippingCountryCode != null && aShippingCountryCode.length > 2) {
                var sShippingCountryValue = aShippingCountryCode[2];
            }

            // query string으로 넘어 온 배송국가 값이 있다면, 그 값을 적용함
            var aHrefCountryValue = decodeURIComponent(location.href).split("/?country=");

            if (aHrefCountryValue.length == 2) {
                var sShippingCountryValue = aHrefCountryValue[1];
            }

            // 메인 페이지에서 국가선택을 안한 경우, 그 외의 페이지에서 셋팅된 값이 안 나오는 현상 처리
            if (location.href.split("/").length != 4 && $(".xans-layout-multishopshipping .xans-layout-multishopshippingcountrylist").val()) {
                $(".xans-layout-multishoplist .xans-layout-multishoplistmultioption a .ship span").text(" : "+$(".xans-layout-multishopshipping .xans-layout-multishopshippingcountrylist option:selected").text().split("SHIPPING TO : ").join(""));

                if ($("#f_country").length > 0 && location.href.indexOf("orderform.html") > -1) {
                    $("#f_country").val($(".xans-layout-multishopshipping .xans-layout-multishopshippingcountrylist").val());
                }
            }
            if (typeof(sShippingCountryValue) != "undefined" && sShippingCountryValue != "" && sShippingCountryValue != null) {
                sShippingCountryValue = sShippingCountryValue.split("#")[0];
                var bShippingCountryProc = true;

                $(".xans-layout-multishopshipping .xans-layout-multishopshippingcountrylist").val(sShippingCountryValue);
                $(".xans-layout-multishoplist .xans-layout-multishoplistmultioption a .ship span").text(" : "+$(".xans-layout-multishopshipping .xans-layout-multishopshippingcountrylist option:selected").text().split("SHIPPING TO : ").join(""));
                var expires = new Date();
                expires.setTime(expires.getTime() + (30 * 24 * 60 * 60 * 1000)); // 30일간 쿠키 유지
                document.cookie = sShippingCountryCode4Cookie+'=' + $(".xans-layout-multishopshipping .xans-layout-multishopshippingcountrylist").val() +';path=/'+ ';expires=' + expires.toUTCString();
                if ($("#f_country").length > 0 && location.href.indexOf("orderform.html") > -1) {
                    $("#f_country").val(sShippingCountryValue).change();;
                }
            }
        }
        // 언어선택 설정이 사용안함이면 숨김
        if (EC_SHOP_MULTISHOP_SHIPPING.bMultishopShippingLanguageSelection === false) {
            $('.xans-layout-multishopshipping .xans-layout-multishopshippinglanguagelist').hide();
            $('.xans-layout-multishoplist .xans-layout-multishoplistmultioption .xans-layout-multishoplistmultioptionlanguage').hide();
        } else {
            $('.thumb .xans-layout-multishoplistitem').hide();
        }

        // 배송국가 및 언어 설정이 둘 다 사용안함이면 숨김
        if (EC_SHOP_MULTISHOP_SHIPPING.bMultishopShipping === false) {
            $(".xans-layout-multishopshipping").hide();
            $('.xans-layout-multishoplist .xans-layout-multishoplistmultioption').hide();
        } else if (bShippingCountryProc === false && location.href.split("/").length == 4) { // 배송국가 값을 처리한 적이 없고, 메인화면일 때만 선택 레이어를 띄움
            var sShippingCountryValue = $(".xans-layout-multishopshipping .xans-layout-multishopshippingcountrylist").val();
            $(".xans-layout-multishopshipping .xans-layout-multishopshippingcountrylist").val(sShippingCountryValue);
            $(".xans-layout-multishoplist .xans-layout-multishoplistmultioption a .ship span").text(" : "+$(".xans-layout-multishopshipping .xans-layout-multishopshippingcountrylist option:selected").text().split("SHIPPING TO : ").join(""));
            // 배송국가 선택을 사용해야 레이어를 보이게 함
            if (EC_SHOP_MULTISHOP_SHIPPING.bMultishopShippingCountrySelection === true) {
                $(".xans-layout-multishopshipping").show();
            }
        }

        $(".xans-layout-multishopshipping .close").bind("click", function() {
            $(".xans-layout-multishopshipping").hide();
        });

        $(".xans-layout-multishopshipping .ec-base-button a").bind("click", function() {
            var expires = new Date();
            expires.setTime(expires.getTime() + (30 * 24 * 60 * 60 * 1000)); // 30일간 쿠키 유지
            document.cookie = sShippingCountryCode4Cookie+'=' + $(".xans-layout-multishopshipping .xans-layout-multishopshippingcountrylist").val() +';path=/'+ ';expires=' + expires.toUTCString();

            // 도메인 문제로 쿠키로 배송국가 설정이 안 되는 경우를 위해 query string으로 배송국가 값을 넘김
            var sQuerySting = (EC_SHOP_MULTISHOP_SHIPPING.bMultishopShippingCountrySelection === false) ? "" : "/?country="+encodeURIComponent($(".xans-layout-multishopshipping .xans-layout-multishopshippingcountrylist").val());

            location.href = '//'+$(".xans-layout-multishopshipping .xans-layout-multishopshippinglanguagelist").val()+sQuerySting;
        });
        $(".xans-layout-multishoplist .xans-layout-multishoplistmultioption a").bind("click", function() {
            $(".xans-layout-multishopshipping").show();
        });
    }
});
