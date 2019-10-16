/*! modernizr 3.3.1 (Custom Build) | MIT *
 * https://modernizr.com/download/?-video-setclasses !*/
!function(e,n,a){function o(e,n){return typeof e===n}function s(){var e,n,a,s,t,c,r;for(var p in l)if(l.hasOwnProperty(p)){if(e=[],n=l[p],n.name&&(e.push(n.name.toLowerCase()),n.options&&n.options.aliases&&n.options.aliases.length))for(a=0;a<n.options.aliases.length;a++)e.push(n.options.aliases[a].toLowerCase());for(s=o(n.fn,"function")?n.fn():n.fn,t=0;t<e.length;t++)c=e[t],r=c.split("."),1===r.length?Modernizr[r[0]]=s:(!Modernizr[r[0]]||Modernizr[r[0]]instanceof Boolean||(Modernizr[r[0]]=new Boolean(Modernizr[r[0]])),Modernizr[r[0]][r[1]]=s),i.push((s?"":"no-")+r.join("-"))}}function t(e){var n=p.className,a=Modernizr._config.classPrefix||"";if(f&&(n=n.baseVal),Modernizr._config.enableJSClass){var o=new RegExp("(^|\\s)"+a+"no-js(\\s|$)");n=n.replace(o,"$1"+a+"js$2")}Modernizr._config.enableClasses&&(n+=" "+a+e.join(" "+a),f?p.className.baseVal=n:p.className=n)}function c(){return"function"!=typeof n.createElement?n.createElement(arguments[0]):f?n.createElementNS.call(n,"http://www.w3.org/2000/svg",arguments[0]):n.createElement.apply(n,arguments)}var i=[],l=[],r={_version:"3.3.1",_config:{classPrefix:"",enableClasses:!0,enableJSClass:!0,usePrefixes:!0},_q:[],on:function(e,n){var a=this;setTimeout(function(){n(a[e])},0)},addTest:function(e,n,a){l.push({name:e,fn:n,options:a})},addAsyncTest:function(e){l.push({name:null,fn:e})}},Modernizr=function(){};Modernizr.prototype=r,Modernizr=new Modernizr;var p=n.documentElement,f="svg"===p.nodeName.toLowerCase();Modernizr.addTest("video",function(){var e=c("video"),n=!1;try{(n=!!e.canPlayType)&&(n=new Boolean(n),n.ogg=e.canPlayType('video/ogg; codecs="theora"').replace(/^no$/,""),n.h264=e.canPlayType('video/mp4; codecs="avc1.42E01E"').replace(/^no$/,""),n.webm=e.canPlayType('video/webm; codecs="vp8, vorbis"').replace(/^no$/,""),n.vp9=e.canPlayType('video/webm; codecs="vp9"').replace(/^no$/,""),n.hls=e.canPlayType('application/x-mpegURL; codecs="avc1.42E01E"').replace(/^no$/,""))}catch(a){}return n}),s(),t(i),delete r.addTest,delete r.addAsyncTest;for(var d=0;d<Modernizr._q.length;d++)Modernizr._q[d]();e.Modernizr=Modernizr}(window,document);

if(window.console == undefined){console = {log:function(){}};}

if(window.orientation != undefined){$('html').addClass('Mobile');}else{$('html').addClass('Desktop');}

if( /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent) ) {	if(window.addEventListener){window.addEventListener('load',function(){setTimeout(scrollTo,0,0,1);},false);} }

setClassUAver();
setClassWinWidth();


jQuery(function($){


$(".link").on("click", function(e){			
	e.preventDefault();
	var trb = document.location.href;
	var IE=(document.all)?true:false;
	if (IE) {
		if(confirm("이 글의 트랙백 주소를 클립보드에 복사하시겠습니까?"))
			window.clipboardData.setData("Text", trb);
	} else {
		temp = prompt("이 글의 트랙백 주소입니다. Ctrl+C를 눌러 클립보드로 복사하세요", trb);
	}

});

(function(){
	$('a[href^="tel"]').on('click', function(){
		if( /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent) ) {
			return;
		}else{
			alert('스마트폰일 때 전화걸기가 가능합니다.');
			return false;
		}
	});
}());

(function doToggle(selector){
	$('.toggle').not('.donot').each(function(){
		var $this = $(this); 
		var $that = $($this.attr('href'));
		var $sib = $that.parent().siblings('.' + $that.parent().attr('class')); 

		if( $this.hasClass('on') ){
			$that.addClass('on').show();
		}else{
			$that.removeClass('on').hide();
		}
		$this.on('click', function(){
			var $that = $($this.attr('href')); 
			if( !$(this).is('.on') ){ 
				$('.toggle').removeClass('opener-last');
				$this.addClass('opener-last'); 
			}

			$sib.each(function(){
				$(this).removeClass('on');
				var $this = $('.toggle', this);
				var $that = $($this.attr('href'));
				$this.removeClass('on');
				$that.removeClass('on').hide();
			});

			if($this.hasClass('showhide')){
				$that.toggle();
			}else if($this.hasClass('slide')){
				$that.slideToggle(200, 'swing', function(){});
			}else if($this.hasClass('fade')){
				$that.fadeToggle(100, 'swing', function(){});
			}else if($this.hasClass('animate1')){
				$that.animate({
					left: 'toggle',
					top: 'toggle',
					width: 'toggle',
					height: 'toggle',
					opacity: 'toggle'
				}, 200, function(){});
			}else{
				$that.toggle();
			}
			$this.toggleClass('on');
			$that.toggleClass('on');

			if($this.is('.on')){
				if($this.data('sendFocus') == 'that'){ 
					$that.find('a, button').first().focus(); 
				}else{
					$this.focus();
				}
			}
			return false;
		});
	
		$('.close', $that).on('click', function(){
			var closeHref = $(this).attr('href');
			if( $this.attr('href') == closeHref ){
				$this.filter('.on').triggerHandler('click');
				$this.filter('.opener-last').focus();
			}
			return false;
		});

	});
}());


}); 


$.fn.jQmPR1 = function(options){
	if(!this) return false;
	var config = {
		interval: 6000,
		autoFlag: true,
		effect: null,
		initEffect: null, 
		duration: 400, 
		delay: 0, 
		zIndex: 0,

		onnum: 1,
		oldonnum: 0,
		easing: 'swing',
		preAct: 1, 
		viewNum: 1,
		vertical: 0,
		mTabindex: 0, 
		mNumEvent: 'click',
		gesture: false, 
		threshold: 10,

		mView: '.mView', 
		mCont: '>.mCont', 
		mContC: '>.mContC', 
		c: '', 
		mNum: '.mNum', 
		m: '.m', 
		prev: '.mControl .prev', 
		next: '.mControl .next', 
		stop: '.mControl .stop', 
		play: '.mControl .play', 
		pageOn: '.mPage .on', 
		pageTotal: '.mPage .total', 
		onSync: '.onSync', 		
	};
	$.extend(config, options);

	return this.each(function(){
		var $this = $(this);

		$this.effect = config.effect;
		if($this.effect  == 'accordion'){
			config.initEffect = 'accordion';
		}

		$this.mView = $(config.mView, $this);
		$this.mCont = $(config.mCont, $this.mView);
		$this.mContC = $(config.mContC, $this.mCont); 
		$this.mContCc = $(config.c, $this.mContC); 
		$this.mContCm = $(config.m, $this.mContC); 
		$this.mNum = $(config.mNum, $this);
		$this.prev = $(config.prev, $this);
		$this.next = $(config.next, $this);
		$this.stop = $(config.stop, $this);
		$this.play = $(config.play, $this);
		$this.pageOn = $(config.pageOn, $this); 
		$this.pageTotal = $(config.pageTotal, $this); 
		$this.cTotal = $this.mContC.length; 
		$this.onSync = $(config.onSync, $this); 

		$this.v0 = { 
			endLeft: 0,
			endTop: 0,
			endOpacity: parseInt($this.mContC.css('opacity'))
		};
		($this.setV0 = function(){ 
			
			$this.v1 = {
				startLeft: parseInt($this.mContC.css('width')),
				startTop: parseInt($this.mContC.css('height')),
				mContCcWidth: parseInt($this.mContCc.css('width')), 
				mContCmWidth: parseInt($this.mContCm.css('width')) 
			};
			$.extend($this.v0, $this.v1); 
		})();

		($this.autoOnOff = function(){ 
			if(config.autoFlag){
				$this.play.removeClass('on').addClass('on');
				$this.stop.removeClass('on')
			}else{
				$this.play.removeClass('on')
				$this.stop.removeClass('on').addClass('on');
			}
		})();

		($this.reset = function(){ 
			$this.setV0(); 
		})();

		($this.changOn = function(){
			$this.mNum.each(function(){
				$(this).children('.m').removeClass('on').addClass('off').eq(config.onnum-1).addClass('on').removeClass('off');
			});
			$this.onSync.each(function(){
				$(this).children('.m').removeClass('on').addClass('off').eq(config.onnum-1).addClass('on').removeClass('off');
			});
			$this.mCont.each(function(){ 
				$(this).children('.mContC').css({ zIndex: 0 }) 
					.removeClass('on').addClass('off').eq(config.onnum-1).addClass('on').removeClass('off');
				for(var i = config.viewNum-1; i--;){ 
					$(this).children('.mContC').eq(config.onnum + i).addClass('on');
				}
			});

			$this.cOnNew = $('.mContC.on' + config.c, $this.mCont);
			$this.cOnOld = (config.c)?
				$(config.c, $this.mCont.children().eq(config.oldonnum-1)).delay(config.delay):
				$this.mCont.children().eq(config.oldonnum-1);
			$this.cOnNew.css({ zIndex: 11 }); 
			$this.cOnOld.css({ zIndex: 10 });

			$this.loadContent = function(){
				if($this.cOnNew.html() == ''){
					var onn = (config.onnum < 10)? '0' + config.onnum: config.onnum;
					$this.cOnNew.html('<div class="c"><a href="?' + config.onnum + '"><img src="/img/main/v1/v1' + onn + '.jpg" width="2000" height="300" alt="★대체텍스트' + onn + '" title="" /></a></div>');
				}
			}
			$this.loadContent();

			$this.mContC.each(function(){
				var idxGap = 0; 
				var thisNum = 1 + $(this).prevAll('.mContC').length; 
				idxGap = (thisNum - config.onnum);
				$(this).removeClass('prev-on').removeClass('next-on');
				if( (config.onnum == 1) && (thisNum == $this.cTotal) && $this.cTotal != 1 ){
					idxGap = -1;
				}else if( (config.onnum == $this.cTotal) && (thisNum == 1) && $this.cTotal != 1 ){
					idxGap = 1;
				}
				if( idxGap == -1 ){
					$(this).addClass('prev-on');
				}else if( idxGap == 1 ){
					$(this).addClass('next-on');
				}

				$(this).css({left:(idxGap*$this.v0.startLeft) + 'px', top:(idxGap*$this.v0.startTop) + 'px'});

				if( !( (idxGap == 0) || (idxGap == 1) || (idxGap == -1) ) ){
					$(this).css({left:'-9999px'}); 
				}
			});

			if(config.vertical){$this.v0.startLeft = 0}
			else{$this.v0.startTop = 0}		

			$this.pageOn.text(config.onnum); 
			$this.pageTotal.text($this.cTotal); 

		})();

		($this.action = function(effect){
			switch(effect){
			case 'slide': 
				$this.changOn();
				if(config.onnum > config.oldonnum){config.frontback = 1} 
				else if(config.onnum < config.oldonnum){config.frontback = -1} 
				if(config.onnum == 1 && config.oldonnum == $this.cTotal){config.frontback = 1} 
				else if(config.onnum == $this.cTotal && config.oldonnum == 1){config.frontback = -1} 

				$this.cOnNew.css({
					left:(config.frontback*$this.v0.startLeft) + $this.offsetXdrag + 'px',
					top:(config.frontback*$this.v0.startTop) + 'px',
					opacity:$this.v0.endOpacity
				});
				$this.cOnNew.delay(config.delay).stop().animate({
					left:$this.v0.endLeft + 'px',
					top:$this.v0.endTop + 'px',
					opacity:$this.v0.endOpacity
				}, config.duration, config.easing,function(){});

				$this.cOnOld.css({
					left:(config.frontback*$this.v0.endLeft) + $this.offsetXdrag + 'px',
					top:(config.frontback*$this.v0.endTop) + 'px',
					opacity:$this.v0.endOpacity
				});
				$this.cOnOld.delay(config.delay).stop().animate({
					left:(config.frontback*(-1)*$this.v0.startLeft) + 'px',
					top:(config.frontback*(-1)*$this.v0.startTop) + 'px',
					opacity:$this.v0.endOpacity
				}, config.duration, config.easing,function(){});
				break;
			case 'fade': 
				$this.changOn();
				$this.mContC.css({display: '', left: $this.v0.endLeft, top: $this.v0.endTop, opacity: $this.v0.endOpacity}); 
				$this.cOnNew.css({opacity: 0});
				$this.cOnNew.delay(config.delay).stop().animate({opacity: $this.v0.endOpacity}, config.duration, config.easing, function(){});
				$this.cOnOld.delay(config.delay).stop().animate({opacity: 0}, config.duration, config.easing, function(){}); 
				break;
			case 'accordion': 
				$this.changOn(); 
				$this.mContC.css({left:'auto', top:'auto'});
				$this.mContCc.css({zIndex:''});
				$this.mContC.each(function(){
					if($(this).is('.on')){
						$('.m', this).delay(config.delay).stop().animate({width: 0 + 'px'}, config.duration, config.easing, function(){});
						$('.c', this).delay(config.delay).stop().animate({width: $this.v0.mContCcWidth + 'px'}, config.duration, config.easing, function(){});
					}else{
						$('.m', this).delay(config.delay).stop().animate({width: $this.v0.mContCmWidth + 'px'}, config.duration, config.easing, function(){});
						$('.c', this).delay(config.delay).stop().animate({width: 0 + 'px'}, config.duration, config.easing, function(){});
					}
				});
				break;
			default: 
				$this.changOn();
			}
			$this.offsetXdrag = 0; 
		})(config.initEffect); 

		$this.prevAct = function(){ 
			config.oldonnum = config.onnum;
			config.onnum -= config.viewNum; 
			if(config.onnum < 1){config.onnum = $this.cTotal; 
				config.onnum = config.viewNum*(Math.ceil($this.cTotal/config.viewNum)-1) + 1; 
			}
			$this.action($this.effect);
		}
		$this.nextAct = function(){ 
			
			config.oldonnum = config.onnum;
			config.onnum += config.viewNum; 
			if(config.onnum > $this.cTotal)config.onnum = 1; 
			$this.action($this.effect);
		}

		$this.directAct = function(thisNum){ 
			if(config.onnum == thisNum) return false; 
			config.oldonnum = config.onnum;
			config.onnum = thisNum; 
			$this.action($this.effect);
		}

		$this.autoAct = function(){ 
			if(config.autoFlag){
				$this.nextAct();
			}
		}
		$this.timer1 = setInterval($this.autoAct, config.interval); 
		$this.restartInterval = function(timer){ 
			if(timer){
				clearInterval(timer);
			}
			$this.timer1 = setInterval($this.autoAct, config.interval);
		}

		$this.stopAct = function(){ 
			config.autoFlag = false;
			$this.autoOnOff();
			clearInterval($this.timer1);
		}

		$this.playAct = function(){ 
			config.autoFlag = true;
			$this.autoOnOff();
			$this.restartInterval($this.timer1);
		}

		$this.prev.on('click', function(e){ 
			e.preventDefault();
			$this.prevAct();
		});

		$this.next.on('click', function(e){ 
			e.preventDefault();
			$this.nextAct();
		});

		$(config.m, $this.mNum).on(config.mNumEvent , function(e){ 
			e.preventDefault();

			if($(this).parent().hasClass('mNum')){ 
				var thisNum = 1 + $(this).index() * $(this).parents('.mNum').find('.m').length / $(this).parents('.mNum').children().length;
			}else{ 
				var thisNum = 1 + $(this).parents('.mContC').index() * $(this).parents('.mNum').find('.m').length / $(this).parents('.mNum').children().length;
			}
			$this.directAct(thisNum);
		}).attr('tabindex', config.mTabindex); 

		$this.stop.on('click', function(e){ 
			e.preventDefault();
			$this.stopAct();
		});

		$this.play.on('click', function(e){ 
			e.preventDefault();
			$this.playAct();
		});

		var delta = 300,
			timer0 = null;
		$(window).on('resize', function(){
			if($this.timer1){

			}
			clearTimeout( timer0 );
			timer0 = setTimeout( resizeDone, delta ); 
		});
		function resizeDone(){
			$this.reset();
		}

		$this.find('button, a').addBack().on('focusin mouseenter', function(e){ 

			if(e.type == 'focusin'){
				if($(this).parents('.mContC').length){ 
					$this.effect = null; 
					$this.mContC.css({display:'', left:$this.v0.endLeft, top:$this.v0.endTop, opacity:0});
					$(this).parents('.mContC').css({opacity:$this.v0.endOpacity});
				}
			}
			clearInterval($this.timer1);
		});
		$this.find('button, a').addBack().on('focusout mouseleave', function(e){ 
			if(e.type == 'focusout'){ 
				$this.effect = config.effect; 
				if($(this).parents('.mContC').length){ 
					$this.mContC.css({opacity:$this.v0.endOpacity});
				}
			}
			if(config.autoFlag && !$(':focus', $this.mContC).length){ 
				$this.restartInterval($this.timer1);
			}
		});
		$('a, area', $this.mContC).attr('tabindex',0).on('focusin', function(e){ 
			
			var thisIdx = $(this).parents('.mContC').prevAll('.mContC').length;
			if($(config.m, $this.mNum).length > 0){ 
				$(config.m, $this.mNum).eq(thisIdx).trigger('click');
			}else{ 
				config.oldonnum = config.onnum;
				config.onnum = thisIdx + 1;
				$this.action($this.effect);
			}
		});

		if(!config.gesture) return false;
		($this.gesture1 = function(){
			var o = {
				sx: 0, 
				sy: 0, 
				dx: 0, 
				dy: 0, 
				ex: 0, 
				ey: 0, 
				sl: 0, 
				st: 0, 
				threshold: config.threshold 
			};
			$this.mView.on('touchstart touchmove touchend mousedown mousemove mouseup', function(e){
				 
				$this.offsetLeft = ($(this).offset().left < 0)? 0: $(this).offset().left; 
				$this.offsetTop = ($(this).offset().top < 0)? 0: $(this).offset().top;
				if(e.originalEvent.touches || e.originalEvent.changedTouches){ 
					var touch = e.originalEvent.touches[0] || e.originalEvent.changedTouches[0]; 
					touch.length = e.originalEvent.touches.length || e.originalEvent.changedTouches.length;
				}else{
					var e = e || window.event;
				}
				var x = (e.pageX || touch.pageX) - $this.offsetLeft;
				var y = (e.pageY || touch.pageY) - $this.offsetTop;
				if(x < $(this).width() && x > 0 && y < $(this).height() && y > 0){ 
					if(e.type == 'touchstart' || e.type == 'mousedown'){
						$this.onGesture = 1;
						o.sx = x; o.sy = y; 
						o.dx = 0; o.dy = 0; 
						o.sl = parseInt($this.mCont.css('left')); 
						clearInterval($this.timer1); 
					}
					if(e.type == 'touchmove' || e.type == 'mousemove'){
						if($this.onGesture){
							o.dx = x-o.sx; o.dy = y-o.sy; 
							if(Math.abs(o.dx) > Math.abs(o.dy)){ 
								e.preventDefault();
								$this.mCont.css('left',(o.sl + o.dx) + 'px'); 
							}else{
								$this.onGesture = 0;
							}
						}
					}
					if(e.type == 'touchend' || e.type == 'mouseup'){
						
						$this.onGesture = 0;
						o.ex = x; o.ey = y; 
						if(Math.abs(o.dx) > Math.abs(o.dy)){ 
							$this.offsetXdrag = parseInt($this.mCont.css('left')) || 0; 
							$this.mCont.css('left',(o.sl) + 'px');
							if((o.ex-o.sx) > o.threshold){
								$this.prevAct();
							}
							else if((o.ex-o.sx) < -o.threshold){
								$this.nextAct();
							}
							else{
								$this.returnAct('slide');
							}
						}
						$this.restartInterval($this.timer1);
					}
				}else{ 
					if($this.onGesture){ 
						$this.returnAct('slide');
						$this.onGesture = 0;
					}
				}
				$('a', this).on('click', function(){
					if(Math.abs(o.dx) > 2){ 
						return false;
					}else{
						return;
					}
				});

				if(/touch/.test(e.type)){

				}else{
					return false;
				}
			});
		})();
		$this.returnAct = function(effect){ 
			switch(effect){
			case 'slide':
				$this.mCont.animate({left:0},'slow','swing', function(){});
				break;
			default:
				$this.mCont.css('left',0);
			}
		}
	});
}


$.fn.jQmTicker1 = function(options){
	if(!this) return false;
	var config = {
		interval: 3000, 
		autoFlag: true, 
		effect: null, 
		duration: 0, 
		easing: 'swing', 
		
		mView: '.mView', 
		mCont: '>.mCont', 
		mContC: '>.mContC', 
		prev: '.mControl .prev', 
		next: '.mControl .next', 
		stop: '.mControl .stop', 
		play: '.mControl .play', 
		onPage: 1 
	};
	$.extend(config, options);

	return this.each(function(){
		var $this = $(this);
		$this.effect = config.effect;
		
		$this.mView = $(config.mView, $this);
		$this.mCont = $(config.mCont, $this.mView);
		$this.mContC = $(config.mContC, $this.mCont);
		$this.mNum = $(config.mNum, $this);
		$this.prev = $(config.prev, $this);
		$this.next = $(config.next, $this);
		$this.stop = $(config.stop, $this);
		$this.play = $(config.play, $this);

		($this.autoOnOff = function(){ 
			if(config.autoFlag){
				$this.play.removeClass('on').addClass('on');
				$this.stop.removeClass('on')
			}else{
				$this.play.removeClass('on')
				$this.stop.removeClass('on').addClass('on');
			}
		})();

		$this.reset = function(){ 
			config.onPage = 1;
			$this.action($this.effect);
		};

		$this.action = function(effect){
			switch(effect){
			default:
				$this.mCont.animate({'top': $this.mView.height() * (1 - config.onPage)  + 'px'}, config.duration, config.easing);
			}
			$this.offsetXdrag = 0; 
		};

		$this.prevAct = function(){ 
			var allPage = $this.mCont.height() / $this.mView.height();
			if(config.onPage == 1){
				config.onPage = allPage;
			}else{
				config.onPage--;
			}
			$this.action($this.effect);
		}
		$this.nextAct = function(){ 
			var allPage = $this.mCont.height() / $this.mView.height();
			if(config.onPage == allPage){
				config.onPage = 1;
			}else{
				config.onPage++;
			}
			$this.action($this.effect);
		}


		$this.autoAct = function(){
			if(config.autoFlag){$this.nextAct();}
		}
		$this.timer1 = setInterval($this.autoAct, config.interval); 
		$this.restartInterval = function(timer){ 
			if(timer){
				clearInterval(timer);
			}
			$this.timer1 = setInterval($this.autoAct, config.interval);
		}

		$this.stopAct = function(){ 
			config.autoFlag = false;
			$this.autoOnOff();
			clearInterval($this.timer1);
		}

		$this.playAct = function(){ 
			config.autoFlag = true;
			$this.autoOnOff();
			$this.restartInterval($this.timer1);
		}

		$this.prev.on('click', function(e){ 
			e.preventDefault();
			$this.prevAct();
		});

		$this.next.on('click', function(e){ 
			e.preventDefault();
			$this.nextAct();
		});

		$this.stop.on('click', function(e){ 
			e.preventDefault();
			$this.stopAct();

		});

		$this.play.on('click', function(e){ 
			e.preventDefault();
			$this.playAct();
		});


		$(window).on('resize', function(){
			$this.reset();
			$this.action(); 
		});

		$this.find('button, a').addBack().on('focusin mouseenter', function(e){ 
			clearInterval($this.timer1);
		});
		$this.find('button, a').addBack().on('focusout mouseleave', function(e){
			if(config.autoFlag && !$(':focus', $this.mContC).length){ 
				$this.restartInterval($this.timer1);
			}
		});

		$this.mCont.find('a').first().on('focusin', function(e){ 
			config.onPage = 1;
			$this.mCont.css({'top': $this.mView.height() * (1 - config.onPage)  + 'px'});
		});
		$this.mCont.find('a').last().on('focusin', function(e){ 
		});

	});
} 

$.fn.jQmPrevNext1 = function(options){
	if(!this) return false;
	var config = {
		interval: 120000, 
		autoFlag: true, 
		gesture: false, 
		threshold: 10, 


		mView : '.mView', 
		mCont : '.mView .mCont', 
		mContC : '.mView .mContC', 
		bprev : '.mControl .prev', 
		bnext : '.mControl .next', 
		bstop : '.mControl .stop', 
		bplay : '.mControl .play', 
		mPageNum: '.mPageNum', 
		m: '.m' 
	};
	$.extend(config, options);
	return this.each(function(){
		var $this = $(this);
			$this.$v = $(config.mView, $this);
			$this.$c = $(config.mCont, $this); 
			$this.$cc = $(config.mContC, $this);
			$this.$bprev = $(config.bprev, $this);
			$this.$bnext = $(config.bnext, $this);
			$this.$bstop = $(config.bstop, $this);
			$this.$bplay = $(config.bplay, $this);
			$this.$mPageNum = $(config.mPageNum, $this);
			$this.$mpn = {}; 

		$this.getValue = function(){

			$this.onPage = 1; 
			$this.cTop = 0; 

			$this.$v.css({ height: '', paddingBottom: '' });
			$this.$cc.css({ height: '', paddingBottom: '' });

			$this.vHeight = Math.round( $this.$v.outerHeight() );
			$this.cHeight = Math.round( $this.$c.outerHeight() );
			$this.ccHeight = Math.round( $this.$cc.outerHeight() );

			$this.rpp = Math.round( $this.vHeight / $this.ccHeight );

			$this.allPage = Math.ceil( ( $this.cHeight - ( $this.cHeight / $this.ccHeight ) ) / $this.vHeight );
			$this.data({'total-page': $this.allPage});
			$this.attr({'data-total-page': $this.allPage});

			if( !$('html').is('.lteIE8') ){
				$this.$cc.css({
					height: $this.ccHeight + 'px',
					paddingBottom: 0
				});
				$this.$v.css({
					height: ( $this.ccHeight * $this.rpp ) + 'px', 
					paddingBottom: 0
				});
			}

			$this.vHeight = Math.round( $this.$v.outerHeight() );
			$this.cHeight = Math.round( $this.$c.outerHeight() );
			$this.ccHeight = Math.round( $this.$cc.outerHeight() );

			if( $this.$cc.filter('.on').index() >= 0 ){
				$this.onPage = 1 + Math.round( $this.$cc.filter('.on').position().top / $this.vHeight );
			}

			$this.cTop = -$this.vHeight * ($this.onPage - 1);
			
			$this.$mPageNum.empty();
			for(var i=1; i <= $this.allPage; i++){
				$this.$mPageNum.append('<a href="#?" class="m m' + i + '" title="' + i + '쪽 보기"><i class="ic1"></i> <span class="t1 blind">' + i + '</span></a>');
			}
			$this.$mpn = $(config.mPageNum + '>' + config.m, $this); 
		}

		$this.getActiveValue = function(){ 

			$this.$mpn.eq($this.onPage-1).addClass('on').siblings().removeClass('on');
		}

		$this.action1 = function(effect){ 
			$this.$c.css({'top': $this.cTop+'px' });
			$this.getActiveValue();
		}

		$this.doReset = function(){ 
			$this.getValue();
			$this.action1();
		}

		$this.doPrev = function(effect){ 

			$this.onPage--;
			if($this.onPage <= 0){ 
				$this.onPage = $this.allPage;
			}
			$this.doDirect();
		}
		$this.doNext = function(effect){ 
			
			$this.onPage++;
			if($this.onPage > $this.allPage){ 
				$this.onPage = 1;
			}
			$this.doDirect();
		}
		$this.doDirect = function(effect){ 
			$this.cTop = -$this.vHeight * ($this.onPage - 1);
			$this.action1();
		}

		$this.autoAction = function(){ 
			if(config.autoFlag){
				$this.doNext();
			}
		}
		$this.timer1 = setInterval($this.autoAction, config.interval); 
		$this.restartInterval = function(timer){ 
			if(timer){
				clearInterval(timer);
			}
			$this.timer1 = setInterval($this.autoAction, config.interval);
		}

		$this.doStop = function(){ 
			config.autoFlag = false;
			$this.autoOnOff();
			clearInterval($this.timer1);
		}

		$this.doPlay = function(){ 
			config.autoFlag = true;
			$this.autoOnOff();
			$this.restartInterval($this.timer1);
		}

		$this.autoOnOff = function(){ 
			if(config.autoFlag){
				$this.$bplay.removeClass('on').addClass('on');
				$this.$bstop.removeClass('on')
			}else{
				$this.$bplay.removeClass('on')
				$this.$bstop.removeClass('on').addClass('on');
			}
		};
		$this.autoOnOff(); 

		$this.$bprev.on('click', function(e){ 
			e.preventDefault();
			$this.doPrev();
		});

		$this.$bnext.on('click', function(e){ 
			e.preventDefault();
			$this.doNext();
		});

		$this.$mPageNum.on('click', '>' + config.m, function(e){ 
			e.preventDefault();
			$this.onPage = $(this).index() + 1;
			$this.doDirect();
		});

		$this.$bstop.on('click', function(e){ 
			e.preventDefault();
			$this.doStop();
		});

		$this.$bplay.on('click', function(e){ 
			e.preventDefault();
			$this.doPlay();
		});

		$(window).on('load resize', function(e){
			setTimeout(function(){
				$this.doReset();
			}, 50);
		});

		$this.find('button, a').addBack().on('focusin mouseenter', function(e){ 
			clearInterval($this.timer1);
		});
		$this.find('button, a').addBack().on('focusout mouseleave', function(e){
			if(config.autoFlag && !$(':focus', $this.$cc).length){ 
				$this.restartInterval($this.timer1);
			}
		});


		$this.isMousedown = 0;
		$this.$c.find('a').on('mousedown', function(e){
			$this.isMousedown = 1;
		});
		$this.$c.find('a').on('focusin', function(e){ 
			
			$this.onPage = Math.floor($(this).position().top / $this.vHeight) + 1;
			if(!$this.isMousedown){
				$this.doDirect();
			}
		});
		$('window').on('mouseup', function(){
			$this.isMousedown = 0;
		});

		if(!config.gesture) return false;
		($this.gesture1 = function(){
			var o = {
				sx: 0, 
				sy: 0, 
				dx: 0, 
				dy: 0, 
				ex: 0, 
				ey: 0, 
				sl: 0, 
				st: 0, 
				threshold: config.threshold 
			};
			$this.$v.on('touchstart touchmove touchend mousedown mousemove mouseup', function(e){
				 
				$this.offsetLeft = ($(this).offset().left < 0)? 0: $(this).offset().left; 
				$this.offsetTop = ($(this).offset().top < 0)? 0: $(this).offset().top;
				if(e.originalEvent.touches || e.originalEvent.changedTouches){ 
					var touch = e.originalEvent.touches[0] || e.originalEvent.changedTouches[0]; 
					touch.length = e.originalEvent.touches.length || e.originalEvent.changedTouches.length;
				}else{
					var e = e || window.event;
				}
				var x = (e.pageX || touch.pageX) - $this.offsetLeft;
				var y = (e.pageY || touch.pageY) - $this.offsetTop;
				if(x < $(this).width() && x > 0 && y < $(this).height() && y > 0){ 
					if(e.type == 'touchstart' || e.type == 'mousedown'){
						$this.onGesture = 1;
						o.sx = x; o.sy = y; 
						o.dx = 0; o.dy = 0; 
						clearInterval($this.timer1); 
					}
					if(e.type == 'touchmove' || e.type == 'mousemove'){
						if($this.onGesture){
							o.dx = x-o.sx; o.dy = y-o.sy; 
							if(Math.abs(o.dx) > Math.abs(o.dy)){ 
								e.preventDefault();
							}else{
								$this.onGesture = 0;
							}
						}
					}
					if(e.type == 'touchend' || e.type == 'mouseup'){
						
						$this.onGesture = 0;
						o.ex = x; o.ey = y; 
						if(Math.abs(o.dx) > Math.abs(o.dy)){ 
							if((o.ex-o.sx) > o.threshold){
								$this.doPrev();
							}
							else if((o.ex-o.sx) < -o.threshold){
								$this.doNext();
							}
							else{
								
							}
						}
						$this.restartInterval($this.timer1);
					}
				}else{ 
					if($this.onGesture){ 
						
						$this.onGesture = 0;
					}
				}
				$('a', this).on('click', function(){
					if(Math.abs(o.dx) > 2){ 
						return false;
					}else{
						return;
					}
				});
			});
		})();
	});
} 


$.fn.jQmPrevNext2 = function(options){
	if(!this) return false;
	var config = {
		mView : '.mView', 
		mCont : '.mCont', 
		mContC : '.mContC', 
		bprev : '.mControl .prev', 
		bnext : '.mControl .next', 
		bstop : '.mControl .stop', 
		bplay : '.mControl .play', 
		interval: 12000, 
		autoFlag: true, 
		onPage: 1, 
		onItem: 1 
	};
	$.extend(config, options);
	return this.each(function(){
		var $this = $(this);
		$this.$v = $(config.mView, $this);
		$this.$c = $(config.mCont, $this);
		$this.$cc = $(config.mContC, $this.$c);
		$this.$bprev = $(config.bprev, $this);
		$this.$bnext = $(config.bnext, $this);
		$this.$bstop = $(config.bstop, $this);
		$this.$bplay = $(config.bplay, $this);

		$this.getValue = function(){ 
			$this.vw = parseInt( $this.$v.innerWidth() ); 
			$this.ccw = parseInt( $this.$cc.outerWidth(true) ); 
			$this.sl = parseInt( $this.$c.css('left') ); 
		}

		$this.getActiveValue = function(){ 
			$this.getValue();
			config.onPage =  -1 * Math.round( parseInt($this.$c.css('left')) / $this.vw ) + 1;
			config.onItem = -1 * Math.round( parseInt($this.$c.css('left')) / $this.ccw ) + 1;
		}

		$this.action1 = function(effect){ 
			$this.$c.css({'left': $this.el + 'px'});
			$this.getActiveValue();
		}

		$this.doReset = function(){ 
			$this.getValue(); 
			$this.el = -1 * ( $this.ccw * (config.onItem - 1) );
			$this.$c.css({'left': $this.el + 'px'});
			
			$this.action1();
		}

		$this.doPrev = function(effect){ 
			$this.getValue();
			$this.el = $this.sl + $this.vw;
			if( $this.el > 0 ){
				$this.ccll = parseInt($this.$cc.last().position().left / $this.vw) * $this.vw 
				$this.el = -1 * $this.ccll;
			}
			$this.action1();
		}

		$this.doNext = function(effect){ 
			$this.getValue();
			$this.el = $this.sl - $this.vw; 
			if( $this.el < (-1 * $this.$cc.last().position().left) ){
				$this.el = 0;
			}
			$this.action1();
		}

		$this.doDirect = function(effect){ 
			$this.getValue();
			$this.el = -1 * ( $this.ccw * (config.onItem - 1) );
			$this.action1();
		}

		
		$this.autoAction = function(){ 
			if(config.autoFlag){
				$this.doNext();
			}
		}
		$this.timer1 = setInterval($this.autoAction, config.interval); 
		$this.restartInterval = function(timer){ 
			if(timer){
				clearInterval(timer); 
			}
			$this.timer1 = setInterval($this.autoAction, config.interval);
		}

		$this.doStop = function(){ 
			config.autoFlag = false;
			$this.autoOnOff();
			clearInterval($this.timer1);
		}

		$this.doPlay = function(){ 
			config.autoFlag = true;
			$this.autoOnOff();
			$this.restartInterval($this.timer1);
		}

		$this.autoOnOff = function(){ 
			if(config.autoFlag){
				$this.$bplay.removeClass('on').addClass('on');
				$this.$bstop.removeClass('on')
			}else{
				$this.$bplay.removeClass('on')
				$this.$bstop.removeClass('on').addClass('on');
			}
		};
		$this.autoOnOff();

		$this.$bprev.on('click', function(e){ 
			e.preventDefault();
			$this.doPrev();
		});
		$this.$bnext.on('click', function(e){ 
			e.preventDefault();
			$this.doNext();
		});
		$this.$bstop.on('click', function(e){ 
			e.preventDefault();
			$this.doStop();
		});
		$this.$bplay.on('click', function(e){ 
			e.preventDefault();
			$this.doPlay();
		});

		 
		$(window).on('load resize', function(){
			setTimeout(function(){
				$this.doReset();
			}, 50);
		});

		
		$this.find('button, a').addBack().on('focusin mouseenter', function(e){ 
			clearInterval($this.timer1);
		});
		$this.find('button, a').addBack().on('focusout mouseleave', function(e){
			if(config.autoFlag && !$(':focus', $this.$cc).length){ 
				$this.restartInterval($this.timer1);
			}
		});

		
		$this.isMousedown = 0;
		$this.$c.find('a').on('mousedown', function(e){
			$this.isMousedown = 1;
		});
		$this.$c.find('a').on('focusin', function(e){ 
			var aIndex = $(this).parent('.mContC').index();
			config.onItem = aIndex + 1;
			if(!$this.isMousedown){
				$this.doDirect();
			}
		});
		$('window').on('mouseup', function(){
			$this.isMousedown = 0;
		});

	});
}


function setClassUAver(){
	$.browser = {};
	$.browser.msie = false;
	
	$.browser.ua = navigator.userAgent;
	$.browser.rv = -1;
	if(navigator.appName == 'Microsoft Internet Explorer'){ 
		$.browser.msie = true;
		$.browser.re = new RegExp('MSIE ([0-9]{1,}[\.0-9]{0,})');
		if($.browser.re.exec($.browser.ua) != null){
			$.browser.rv = parseFloat( RegExp.$1 );
		}
		$('html').addClass('IE' + $.browser.rv); 
	}
	if((navigator.appName == 'Netscape' && $.browser.ua.search('Trident') != -1)){
		$('html').addClass('IE11');
	}
	if($.browser.rv > -1 && $.browser.rv <= 8){
		$('html').addClass('lteIE8'); 
	}else{
		$('html').addClass('gteIE9orSUA'); 
	}
	if( ($.browser.ua.indexOf("Chrome") != -1)  && ($.browser.ua.indexOf("Safari") != -1) ){ 
		$('html').addClass('Chrome');
	}
	if( ($.browser.ua.indexOf("Safari") != -1) && ($.browser.ua.indexOf("Chrome") == -1) ){
		$('html').addClass('Safari');
	}
	if($.browser.ua.indexOf("Firefox") != -1){
		$('html').addClass('Firefox');
	}
	
}

function setClassWinWidth(){
	var $window = $(window);
	var $html = $('html');
	$(window).on('load resize', function(){
		var widthscroll = $window.width() + 16; 
		function removeClassWidth(){ 
			$html.removeClass('width-small width-medium width-large width-xlarge lt-width-xlarge');
		}
		removeClassWidth();
		if( widthscroll <= 767 ){
			$('html').addClass('width-small');
		}
		if( (widthscroll >= 768) && (widthscroll <= 999) ){
			$('html').addClass('width-medium');
		}
		if( (widthscroll >= 1000) && (widthscroll <= 1255) ){ 
			$('html').addClass('width-large');
		}
		if( widthscroll >= 1256 ){
			$('html').addClass('width-xlarge');
		}else{
			$('html').addClass('lt-width-xlarge'); 
		}
	});
}

function makeActive2ClickHover(selector, onFilter){
	var $this = $(selector);
	$this.$m = $('li', $this);
	$this.$a = $('li>a[href]', $this);
	var timer = null; 
	$('div.d1 a+div', $this).prev().parent().addClass('hasSub');
	if(onFilter){
		$this.$m.removeClass('on').filter(onFilter).addClass('on');
	}
	$this.$a.on('click', function(){ 
		
		if($(this).parent().is('.on')){
			if( (selector == '#tnb1') || (selector == '#anb1') ){ 
				$(this).parent().removeClass('on');
			}
		}else{
			$(this).parent().siblings().removeClass('on').end().addClass('on');
		}
		
		if($('html').is('.width-xlarge')){ 
			return;
		}else{
			if($(this).next('div[class*=d]').length > 0){ 
				return false;
			}else{ 
				return;
			}
		}

	});
	$this.on('mouseenter', function(){ 
		clearTimeout(timer);
	});
	if($('.hasSub', $this).length > 0){ 
		$('body').on('click', function(){
			
		});
		$this.on('mouseleave', function(){ 
			if($('html').is('.width-xlarge')){ 
				clearTimeout(timer);
				timer = setTimeout(function(){
					
				}, 1000);
			}
		});
	}

	$(function(){
		var timer1over, timer1out; 
		var $this = null;
		$(window).on('load resize', function(){ 
			$this = $('html.width-xlarge #tnb1 .d1>ul>li');
			$this.off(); 
			$this.on('focusin mouseenter', function(){
				var $it = $(this); 
				clearTimeout(timer1over);
				clearTimeout(timer1out);
				timer1over = setTimeout(function(){
					$it.addClass('over').siblings().removeClass('over'); 
				}, 100);

			}).on('focusout mouseleave', function(){
				var $it = $(this);
				clearTimeout(timer1over);
				clearTimeout(timer1out);
				timer1out = setTimeout(function(){
					$it.siblings().addBack().removeClass('over');
				}, 100);
			});
		});
	});

}

function makeActive2ClickHover2(selector, options){
	var $this = $(selector);
	if(!$this) return false;
	var timer = null; 
	var config = {
		onFilter : null, 
		activeThey : 'one' 
	};
	$.extend(config, options);

	$this.$m = $('li', $this);
	$this.$a = $('li>a[href]', $this);

	$('div.d1 a+div', $this).prev().parent().addClass('hasSub');

	if(config.onFilter){
		$this.$m.removeClass('on').filter(config.onFilter).addClass('on');
	}

	$this.$a.off(); 

	$this.$a.on('click', function(){ 
		
		if($(this).parent().is('.on')){
			if( (selector == '#tnb1') || (selector == '#anb1') ){
				$(this).parent().removeClass('on');
			}
		}else{
			$(this).parent().siblings().removeClass('on').end().addClass('on');
		}

		if($('html').is('.width-xlarge')){ 
			return;
		}else{
			if($(this).next('div[class*=d]').length > 0){ 
				return false;
			}else{ 
				return;
			}
		}

	});
	$this.on('mouseenter', function(){ 
		clearTimeout(timer);
	});
	if($('.hasSub', $this).length > 0){ 
		$('body').on('click', function(){ 
		});
		$this.on('mouseleave', function(){
			if($('html').is('.width-xlarge')){
				clearTimeout(timer);
				timer = setTimeout(function(){
				}, 1000);
			}
		});
	}

	$(function(){
		var timer1over, timer1out; 
		var $this = null;
		var $close = null;
		$(window).on('load resize', function(){ 
			
			var $d1 = $('html.width-xlarge #tnb1 div.d1'); 
			
			var $this = $('html.width-xlarge #tnb1 div.d1 ul>li'); 
			var $close = $('#tnb1 .b3.close'); 

			$this.off(); 

			$d1.on('focusin mouseenter', function(){
				$(this).addClass('over');
			}).on('focusout mouseleave', function(){
				$(this).removeClass('over');
			});

			$this.on('focusin mouseenter', function(){
				var $it = $(this); 
				clearTimeout(timer1over);
				clearTimeout(timer1out);
				
					if( config.activeThey == 'one' ){ 
						$it.addClass('over').siblings().removeClass('over'); 
					}else if( config.activeThey == 'all' ){
						$it.siblings().addBack().addClass('over'); 
					}
				
			}).on('focusout mouseleave', function(){
				var $it = $(this);
				clearTimeout(timer1over);
				clearTimeout(timer1out);
				
					if( $it.parent().parent().is('.d1') ){ 
						$it.siblings().addBack().removeClass('over');
						$('.over', $it).removeClass('over');
					}
				
			});

			$('>a', $this).on('focusin', function(){
				var $it = $(this).parent();
				clearTimeout(timer1over);
				clearTimeout(timer1out);
				
					if( config.activeThey == 'one' ){ 
						$it.addClass('over').siblings().removeClass('over');
					}else if( config.activeThey == 'all' ){
						$it.siblings().addBack().addClass('over');
					}
					$it.closest('.d1').addClass('over'); 
				
			}).on('focusout', function(){
				var $it = $(this).parent();
				clearTimeout(timer1over);
				clearTimeout(timer1out);
				
					if( $it.parent().parent().is('.d1') ){ 
						$it.siblings().addBack().removeClass('over');
						$('.over', $it).removeClass('over');
						$it.closest('.d1').removeClass('over');
					}
				
			});

			
			$close.on('click', function(){
				
				if( $('html').is('[class*=" IE"]') ){ 
					var $next = $(this).closest('div.d2').parent('li').next();
					if( !!$next.length && !($next.css('display') == 'none') ){ 
						$next.attr({tabindex: '0'}).focus().attr({tabindex: ''});
					}else{
						$('#anb1 a').focus(); 
					}
				}
				$(this).blur(); 
			});
		});
	});

}

function makeActive(selector, onFilter, option){
	var $this = $(selector);
		$this.$m = $('li', $this);
		$this.$a = $('li>a[href]', $this);
	var isLocationHash = !!$('a[href$="'+ location.hash +'"]', $this).length;
	var option = option;

	$this.$a.on('click', function(){
		if($(this).parent().is('.on')){
			if( option == 'toggle' ){ 
				$(this).parent().removeClass('on');
			}
		}else{
			$(this).parent().addClass('on').siblings().removeClass('on');
		}
		
	});

	if(onFilter){
		$this.$m.removeClass('on').filter(onFilter).addClass('on');
	}

	
	if( isLocationHash ){
		$this.$aa = $('a[href$="'+ location.hash +'"]', $this);
		
		$this.$aa.parent().addClass('on').siblings().removeClass('on');
	}
}

function makeShow(selector, onHash){
	var $this = $(selector);
		$this.$m = $('li', $this);
		$this.$a = $('li>a[href]', $this);
	var myHash = "";
	var isLocationHash = !!$('a[href$="'+ location.hash +'"]', $this).length;
	var gotohere;

	$this.$a.on('click', function(){
		$($(this).attr('href')).show().siblings().hide();
		return false; 
	});

	if( isLocationHash ){
		myHash = location.hash;
	}else{
		myHash = onHash;
	}

	$this.$aa = $('a[href$="'+ myHash +'"]', $this);
	$this.$aa.triggerHandler('click'); 
	if( isLocationHash ){
		gotohere = $this.$aa.offset().top;
		smoothScrollTop( gotohere, setoff ); 
	}
}

var makeMobileScrollbars = function(selector){
	if($(selector).length == 0) return false;
	$(selector).css({position: 'relative', overflow: 'hidden'})
		.wrapInner('<div class="scroller" style="padding-bottom:1em;"></div>'); 
	var myScroll = new IScroll(selector, {
		scrollbars: true
	});
};


function jQscrollTouch(scrollWrapClass, options){
	var $this = $(scrollWrapClass = scrollWrapClass || '.scroll1wrap');
	if(!$this) return false;
	var config={
		contSelector: '>*:first', 
		setDesktop: false, 
		maxWidthNone: '>*', 
		that: 0 
	};
	$.extend(config,options);
	var scrollWrapName = scrollWrapClass.replace(/\./, ''); 
	if($('html').hasClass('Desktop') && !config.setDesktop){ 
		$this.removeClass(scrollWrapName);
		return false;
	}
	if($('html').hasClass('lteIE8')) return false; 
	$this.each(function(index){ 
		var $this = $(this);
		$(window).on('load', function(){ 
			$this.$cont = $(config.contSelector, $this);
			
			$this.css({position: 'absolute'});
			$(config.maxWidthNone, $this.$cont).css({'max-width': 'none'}); 
			$this.$cont.css({width: $this.$cont.width() + 'px'});
			$this.$cont.width = $this.$cont.width();
			$this.css({position: ''});
			
			$this.attr({id: scrollWrapName + index}); 
			$this.myScroll = new IScroll( '#'+$this.attr('id'), { 
				eventPassthrough: true,
				scrollX: true,
				scrollY: false,
				preventDefault: false,
				scrollbars: true,
				mouseWheel: true,
				interactiveScrollbars: true,
				shrinkScrollbars: 'scale',
				fadeScrollbars: false,
				keyBindings: { 
					pageUp: 33,
					pageDown: 34,
					end: 35,
					home: 36,
					left: 37,
					up: 38,
					right: 39,
					down: 40
				}
			});
			$this.$scrollbarFace = $('.iScrollIndicator', $this);
			$this.$scrollbarTrack = $('.iScrollLoneScrollbar', $this);
			$this.$scrollbarFace.attr({'tabindex': '0'});
			
			var maybeConflict = false;
			$this.$scrollbarTrack.on('mouseup', function(e){
				$this.$scrollbarFace.on('mouseup', function(e){
					maybeConflict = true;
				});
				if(!maybeConflict){ 
					var a={
						scrollToX : 0, 
						faceWidth : $this.$scrollbarFace.width(),
						trackWidth : $this.$scrollbarTrack.width() 
					};
					a.scrollToX = - ((e.offsetX - (a.faceWidth / 2)) / a.trackWidth * $this.$cont.width);
					if(a.scrollToX > 0){
						a.scrollToX = 0;
					}else if(a.scrollToX < a.trackWidth - $this.$cont.width){
						a.scrollToX = a.trackWidth - $this.$cont.width;
					}
					$this.myScroll.scrollTo(a.scrollToX, 0, 200, IScroll.utils.ease.circular);
				}else{
					maybeConflict = false; 
				}
			});
		});
		
		$(window).on('load resize', function(){
			if($this.width() > $this.children().eq(0).width()){ 
				$this.$scrollbarTrack.hide();
				$this.removeClass('myscroll');
			}else{
				$this.$scrollbarTrack.show();
				$this.addClass('myscroll'); 
			}
		});
	});
}

function changePic1(e, selector, m, n, c){
	var act_e = (e)? e: 'click',
		str_m = (m)? (selector + ' ' + m): (selector + ' .m'), 
		str_c = (c)? $(selector + ' ' + c): (selector + ' .c'),
		onnum = (n)? n: 0, 
		str_mimg = '>*>img'; 
	var $this = $(selector);
		$this.$m = $(str_m); 
		$this.$c = $(str_c); 
		$this.$img = $('>.p1>img', $this.$c); 
		$this.$t1 = $('.t1', $this.$c); 
		$this.$bprev = $('.mControl .prev', $this); 
		$this.$bnext = $('.mControl .next', $this); 
	
	var $foll1cn = $this.parent().find('.foll1pic1gallery1').children();
	var $foll2cn = $this.parent().find('.foll2pic1gallery1').children();

	
	$('a[href]', $this.$m).on(act_e, function(e){
		e.preventDefault();
		$this.$m.removeClass('on');
		$(this).parent().addClass('on');
		$this.$img.attr({ 
			src: $(this).attr('href'),
			alt: $(str_mimg, this).attr('alt')
		});
	
		$this.$t1.text($this.$img.attr('alt')); 
		
		onnum = $this.$m.filter('.on').index(str_m)+1;
		
		advanceControl();
		$foll1cn.hide().eq($(this).parent().index()).show();
		$foll2cn.hide().eq($(this).parent().index()).show();
	});
	$this.$bprev.on('click', function(e){e.preventDefault(); 
		onnum--;
		if(onnum <= 0) onnum = onnum + $this.$m.length;
		$this.$m.eq(onnum-1).find('a').triggerHandler(act_e);
		advanceControl();
	});
	$this.$bnext.on('click', function(e){e.preventDefault(); 
		onnum++;
		if(onnum > $this.$m.length) onnum -= $this.$m.length;
		$this.$m.eq(onnum-1).find('a').triggerHandler(act_e);
		advanceControl();
	});
	$this.$m.eq(onnum-1).find('a').triggerHandler(act_e); 

	function advanceControl(){ 
		$this.onIdx = $this.$m.filter('.on').index(str_m); 
		if( $this.onIdx == 0){
			$this.$bprev.hide();
		}else{
			$this.$bprev.show();
		}
		if( $this.onIdx == $this.$m.length-1){
			$this.$bnext.hide();
		}else{
			$this.$bnext.show();
		}
	}
}

function fncTab1(e, selector, m, n, c){
	var $this = $(selector);
	$this.e = (e)? e: 'click';
	$this.n = (n)? n: 9999; 
	$this.$m = (m)? $(m, $this): $('.m', $this); 
	$this.$c = (c)? $(c, $this): $('.c', $this); 
	$('a', $this.$m).on($this.e, function(e){
		if($(this).is('[href^=#]')){ 
			$this.$m.removeClass('on');
			$(this).parent().addClass('on');
			$this.$c.removeClass('on').hide();
			$this.$c.filter($(this).attr('href')).addClass('on').show();
			 return false;
		}else{ 
			 return;
		}
	});
	
	$this.$m.eq($this.n-1).find('a').triggerHandler($this.e); 
}

function fncFaq1(e, selector, m, n, c){
    var $this = $(selector);
    $this.e = (e)? e: 'click';
    $this.n = (n)? n: 9999;
    $this.$m = (m)? $(m, $this): $('.m', $this);
    $this.$c = (c)? $(c, $this): $('.c', $this);
    $('a', $this.$m).on($this.e, function(e){
        if($(this).is('[href^=#]')){
            $(this).parent().toggleClass('on');
            $this.$c.filter($(this).attr('href')).addClass('on').toggle();
            return false;
        }else{
            return;
        }
    });

    $this.$m.eq($this.n-1).find('a').triggerHandler($this.e);
}


/* 레이어 팝업 (2018.06.26 추가.) */
function getCookieLayer( name ){
    var nameOfCookie = name + "=";
    var x = 0;
    while ( x <= document.cookie.length ){
        var y = (x+nameOfCookie.length);
        if ( document.cookie.substring( x, y ) == nameOfCookie ) {
            if ( (endOfCookie=document.cookie.indexOf( ";", y )) == -1 )
                endOfCookie = document.cookie.length;
            return unescape( document.cookie.substring( y, endOfCookie ) );
        }
        x = document.cookie.indexOf( " ", x ) + 1;
        if ( x == 0 )
            break;
    }
    return "";
}

function setCookieLayer( name, value, expiredays ){
    var todayDate = new Date();
    todayDate.setDate( todayDate.getDate() + expiredays );
    document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";"
}

function layerpopup_close(id) {
    document.getElementById(id).style.display="none" ;
}

function layerpopup_close_today(id, layer_cookieid) {
    document.getElementById(id).style.display="none" ;
    setCookieLayer(layer_cookieid, "done" , 1);
}

function viewLayer(id, layer_cookieid) {
    if (getCookieLayer(layer_cookieid) == 'done'){
        document.getElementById(id).style.display="none" ;
    }
}