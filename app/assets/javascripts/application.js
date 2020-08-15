// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery
//= require moment
//= require fullcalendar
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require bootstrap-sprockets
//= require_tree .

$(document).on('turbolinks:load', function(){
	$('#tab-contents .tab[id != "tab1"]').hide();

	$('#tab-menu a').on('click', function() {
	  $("#tab-contents .tab").hide();
	  $("#tab-menu .active").removeClass("active");
	  $(this).addClass("active");
	  $($(this).attr("href")).show();
	  return false;
	});
});

$(document).on('turbolinks:load', function(){
    $(".btn-gnavi").on("click", function(){
        // ハンバーガーメニューの位置を設定
        var rightVal = 0;
        if($(this).hasClass("open")) {
            // 位置を移動させメニューを開いた状態にする
            rightVal = -300;
            // メニューを開いたら次回クリック時は閉じた状態になるよう設定
            $(this).removeClass("open");
        } else {
            // メニューを開いたら次回クリック時は閉じた状態になるよう設定
            $(this).addClass("open");
        }

        $("#global-navi").stop().animate({
            right: rightVal
        }, 200);
    });
});

$(document).on('turbolinks:load', (function() {
  $('#back a').on('click',function(){
    $('body, html').animate({
      scrollTop:0
    }, 800);
      event.preventDefault();
  });
});
