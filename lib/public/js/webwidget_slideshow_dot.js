(function(a){
    a.fn.webwidget_slideshow_dot=function(p){
        var p=p||{};

        var m=p&&p.slideshow_time_interval?p.slideshow_time_interval:"2000";
        var q=p&&p.slideshow_window_width?p.slideshow_window_width:"400";
        var r=p&&p.slideshow_window_height?p.slideshow_window_height:"400";
        var sf=p&&p.soldeshow_foreColor?p.soldeshow_foreColor:"#000";
        var stc=p&&p.slideshow_title_color?p.slideshow_title_color:"#17CCCC";
        var d=p&&p.directory?p.directory:"images/";
        q += "px";
        r += "px";
        var v;
        var w=-1;
        var x=a(this);
        var y=x.find("ul:first").children("li").length;
        if(x.find("ul").length==0||x.find("li").length==0){
            x.append("Require content");
            return null
        }
        init();
        play();
        function init(){
            x.find("ul:first").wrap('<div class="slides_box"></div>');
            x.css("width",q).css("height",r);
            x.find(".slides_box").css("width",q).css("height",r);
            x.find("ul:first").width(parseInt(q)*y);
            x.find("ul:first").children("li").css("width",q).css("height",r);
            x.find("ul:first").children("li").children("span").css("width",q).css("height",r);
            x.find(".slides_box").after('<div class="title_thumb_box"></div>');
            x.find(".title_thumb_box").append('<div class="thumb_box"></div>');
            for (i = 0; i <= y-1; i++)
            {
                x.find(".thumb_box").append('<span class="normal" alt="'+i+'"></span>');
            }
            x.find(".thumb_box").children("span").click(
                function(){
                            if(parseInt($(this).attr("alt")) == 0){
                                w = y -1;
                            }else{
                                w = parseInt($(this).attr("alt")) -1 ;
                            }
                            play();
        }
            )
            x.find(".thumb_box").children("span").hover(
                function(){
                    $(this).addClass('hover');
                },
                function(){
                    $(this).removeClass('hover');
                }
                );
            x.hover(
                function(){
                    stop();
                },
                function(){
                    v=setTimeout(play,m);
                }
                );
        }
        function previous(){
            if(w==0){
                w=y-2
            }else{
                if(w==1){
                    w=y-1
                }else{
                    w-=2
                }
            }
            play()
        }
        function next(){
            play()
        }
        function play(){
            clearTimeout(v);
            w++;
            if(w>=y){
                w=0
      }else{
        x.find(".slides_box").children("ul").animate({
          left:-(w*parseInt(q))
        },600);
        x.find(".thumb_box").children("span").removeClass("active");
        x.find(".thumb_box").children("span").eq(w).addClass("active");

        v=setTimeout(play,m)
            }
        }
        function stop(){
            clearTimeout(v);
        }


    }
})(jQuery);
