var setoff = 0, 
	do1 = {}; 

$(function(){
	$("html, body").on('mousewheel DOMMouseScroll', function(e) {
		var e = e.originalEvent,
			delta = 0;
		if (e.detail) {
			delta = e.detail * -28; 
		}else{ 
			delta = e.wheelDelta;
		}
	});
});

$(function(){ 
	
	var $nav1a = $('.mousewheel1[class*="scroll1"]'),
		$nav1top = $('#gotop1'); 

	$nav1a.each(function(index, element){
		$(this).on('click', function(e){
			e.preventDefault();
			smoothScrollToHash($(this), setoff);
		});
	});

	$nav1top.on('click', function(e){
		e.preventDefault();
		smoothScrollTop(0);
	});

});

function smoothScrollToHash($this, setoff){
	this_hash = $this[0].hash;
	this_hash_top = $(this_hash).offset().top;
	smoothScrollTop( this_hash_top, setoff ); 
}

function smoothScrollTop(end_top, setoff){ 
	(setoff)? setoff: setoff = 0;
	$('html, body').stop().animate({ 
		scrollTop: end_top + setoff
	}, 400, 'swing', function(){
	});
}