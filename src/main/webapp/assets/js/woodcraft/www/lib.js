jQuery(function($){

	jQscrollTouch('.scroll1wrap', {setDesktop: false});
	jQscrollTouch('.scroll1wrap1all1', {setDesktop: true});

	$(window).on('load', function(){ 
		$('.bsContain').css({backgroundSize: 'contain'});
		$('.bsCover').css({backgroundSize: 'cover'});
	});

	/* 공통 */
	makeActive2ClickHover2('#tnb1'); 
	
	// 레이어 팝업 창 닫기 (18.11.15)
	$("a.b1.closelayer").on("click",function(e){				
		e.preventDefault();
		var $that = $($(this).attr('href')); 
		$that.hide();		
	});	

});

