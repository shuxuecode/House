
var zoomOpen = undefined;

(function($) {
	var body = $('body');
	//body.append('<div id="zoom"><a class="close"></a><a href="#previous" class="previous"></a><a href="#next" class="next"></a><div class="content loading"></div></div>');
	//body.append('<div id="zoom"><a class="close"></a><div class="content loading"></div></div>');
	body.append('<div id="zoom"><div class="content loading"><a class="close"></a></div></div>');

	var zoom = $('#zoom').hide(),
	    zoomContent = $('#zoom .content'),
	    overlay = '<div class="overlay"></div>',
	    zoomedIn = false,
	    openedImage = null,
	    windowWidth = (window.innerWidth ? window.innerWidth : $(window).width()) - 160,
	    windowHeight = (window.innerHeight ? window.innerHeight : $(window).height()) - 100;
		
	function open(event) {
		if (event) {
			event.preventDefault();
		}
		var link = $(this),
		    src = link.attr('href'),
		    type = link.attr('type'),
		    url = link.attr('url');
		if (!src) {
			return;
		}
		// 添加默认图片的判断
		if(src == '/img/defPhoto.png'){
			alert('暂无图片！');
			return;
		}
		
		
		// $('#zoom .previous, #zoom .next').show();
		if (link.hasClass('zoom')) {
			$('#zoom .previous, #zoom .next').hide();
		}
		if (!zoomedIn) {
			zoomedIn = true;
			zoom.show();
			body.addClass('zoomed');
		}
		var image = $(new Image()).hide().css({width: 'auto'});
		body.append(image);
		zoomContent.html('').delay(500).addClass('loading');
		zoomContent.prepend(overlay);

		if (type == 'mp4') {
			var video = $('<video>')
            .css({
                'max-height': (windowHeight + 80) + 'px',
                'max-width': (windowWidth + 80) + 'px',
            	//'height': '450px',
            	//'width': 'auto', // '1000px',
                'box-shadow': '0 0 15px 0 #000',
                'cursor': 'pointer',
                'background': 'rgba(0,0,0,0.6)',
            })
            .attr('controls', "controls")
            .attr('autoplay', "true")
            .html('<source src="'+url+'" type="video/mp4"></source>');
			
			borderWidth = parseInt(zoomContent.css('borderLeftWidth')),
			zoomContent.animate({
//				width: 1000,
//				height: 450,
//				marginTop: -(450 / 2) - borderWidth,
//				marginLeft: -(1000 / 2) - borderWidth
				
				width: 150,
				height: 40,
				marginTop: -(40 / 2) - borderWidth,
				marginLeft: -(150 / 2) - borderWidth
			}, 100, function() {
				
				// 加载提示dom
				var loadingHTML = '<div class="caseBlanche loading-me-z">';
				loadingHTML += '<div class="rond">';
				loadingHTML += '<div class="test"></div>';
				loadingHTML += '</div>';
				loadingHTML += '<div class="load">';
				loadingHTML += '<p>加载中</p>';
				loadingHTML += '</div></div>';
				
				zoomContent.html(loadingHTML);
				
				zoomContent.append(video);
				zoomContent.prepend("<a class='close'></a>");
				video.hide(); // 先隐藏video
				zoomContent.removeClass('loading');
				
				
				
//				var videoH = video[0].videoHeight;
//			    var videoW = video[0].videoWidth;
//			    
//			    console.log(videoH);
//			    console.log(videoW);
//			    
//			    videoW = videoW > windowWidth ? windowWidth : videoW;
//			    videoH = videoH > windowHeight ? windowHeight : videoH;
//			    
//			    zoomContent.css({
//			    	width: videoW,
//					height: videoH,
//					marginTop: -(videoH / 2) - borderWidth,
//					marginLeft: -(videoW / 2) - borderWidth
//			    });
//			    
//			    video.css({
//	            	'height': (videoH)+ 'px',
//	            	'width': videoW + 'px',
//	                'text-align': 'center'
//	            });
			    
//				获取视频对象
			    var videoDom = document.getElementsByTagName("video")[0];
			    
			    videoDom.addEventListener("progress", function(){
//			    	当浏览器正在下载指定的音频/视频时，会发生 progress 事件
			    	/*
			    	 * 		videoObject.readyState 
					    	返回值：number值 
					    	表示音频/视频元素的就绪状态： 
					    	0 = HAVE_NOTHING - 没有关于音频/视频是否就绪的信息 
					    	1 = HAVE_METADATA - 关于音频/视频就绪的元数据 
					    	2 = HAVE_CURRENT_DATA - 关于当前播放位置的数据是可用的，但没有足够的数据来播放下一帧/毫秒 
					    	3 = HAVE_FUTURE_DATA - 当前及至少下一帧的数据是可用的 
					    	4 = HAVE_ENOUGH_DATA - 可用数据足以开始播放
			    	*/
			    	if(videoDom.readyState == 4 && $('#zoom .content .caseBlanche').css("display") != "none"){
			    		var videoH = video[0].videoHeight;
					    var videoW = video[0].videoWidth;
					    videoW = videoW > windowWidth ? windowWidth : videoW;
					    videoH = videoH > windowHeight ? windowHeight : videoH;
					    
					    zoomContent.css({
					    	width: videoW,
							height: videoH,
							marginTop: -(videoH / 2) - borderWidth,
							marginLeft: -(videoW / 2) - borderWidth
					    });
					    
					    video.css({
			            	'height': videoH+ 'px',
			            	'width': videoW + 'px',
			                'text-align': 'center'
			            });
					    
					    $(".caseBlanche").hide();
					    video.show();
			    	}
			    });
			    videoDom.addEventListener("canplay", function(){
//			    	当浏览器能够开始播放指定的音频/视频时，发生 canplay 事件

			    	var videoH = video[0].videoHeight;
				    var videoW = video[0].videoWidth;
				    videoW = videoW > windowWidth ? windowWidth : videoW;
				    videoH = videoH > windowHeight ? windowHeight : videoH;
				    
				    zoomContent.css({
				    	width: videoW,
						height: videoH,
						marginTop: -(videoH / 2) - borderWidth,
						marginLeft: -(videoW / 2) - borderWidth
				    });
				    
				    video.css({
		            	'height': (videoH)+ 'px',
		            	'width': videoW + 'px',
		                'text-align': 'center'
		            });
				    
				    $(".caseBlanche").hide();
				    video.show();
			    });
			    
			});
		}else if(type == 'mp3'){
			var audio = $('<audio>')
            .css({
//                'max-height': ( window_height - (plugin.settings.padding*2) ) + 'px',
//                'max-width': ( window_width - (plugin.settings.padding*2) ) + 'px',
                'box-shadow': '0 0 15px 0 #000',
                'cursor': 'pointer',
                'background': 'rgba(0,0,0,0.6)',
            })
            .attr('controls', "controls")
            .attr('autoplay', "true")
            .html('<source src="'+url+'" type="audio/mpeg"></source>');
			borderWidth = parseInt(zoomContent.css('borderLeftWidth')),
			zoomContent.animate({
				width: 160,
				height: 28,
				marginTop: -(28 / 2) - borderWidth,
				marginLeft: -(160 / 2) - borderWidth
			}, 100, function() {
				zoomContent.html(audio);
				zoomContent.prepend("<a class='close'></a>");
				//video.show();
				zoomContent.removeClass('loading');
				
				// 修改关闭按钮的位置
				$('#zoom .content .close').css({
					'right' : "-180px"
				});
			});
		}
		else{
			image.load(render).attr('src', src);
		}
		
		openedImage = link;
		
		function render() {
			var image = $(this),
			    borderWidth = parseInt(zoomContent.css('borderLeftWidth')),
			    maxImageWidth = windowWidth - (borderWidth * 2),
			    maxImageHeight = windowHeight - (borderWidth * 2),
			    imageWidth = image.width(),
			    imageHeight = image.height();
			
			if (imageWidth == zoomContent.width() && imageWidth <= maxImageWidth && imageHeight == zoomContent.height() && imageHeight <= maxImageHeight) {
					show(image);
					return;
			}
			if (imageWidth > maxImageWidth || imageHeight > maxImageHeight) {
				var desiredHeight = maxImageHeight < imageHeight ? maxImageHeight : imageHeight,
				    desiredWidth  = maxImageWidth  < imageWidth  ? maxImageWidth  : imageWidth;
				if ( desiredHeight / imageHeight <= desiredWidth / imageWidth ) {
					image.width(Math.round(imageWidth * desiredHeight / imageHeight));
					image.height(desiredHeight);
				} else {
					image.width(desiredWidth);
					image.height(Math.round(imageHeight * desiredWidth / imageWidth));
				}
			}
			
			// 修改图片的显示尺寸，避免超出屏幕
//			var img_w = image.width() > 
			
			zoomContent.animate({
				width: image.width(),
				height: image.height(),
				marginTop: -(image.height() / 2) - borderWidth,
				marginLeft: -(image.width() / 2) - borderWidth
			}, 100, function() {
				show(image);
			});

			function show(image) {
				zoomContent.html(image);
				zoomContent.prepend("<a class='close'></a>");
				image.show();
				zoomContent.removeClass('loading');
			}
		}
	}
	
	function openPrevious() {
		var prev = openedImage.parent('li').prev();
		if (prev.length == 0) {
			prev = $('.gallery li:last-child');
		}
		prev.find('a').trigger('click');
	}
	
	function openNext() {
		var next = openedImage.parent('li').next();
		if (next.length == 0) {
			next = $('.gallery li:first-child');
		}
		next.children('a').trigger('click');
	}
		
	function close(event) {
		if (event) {
			event.preventDefault();
		}
		zoomedIn = false;
		openedImage = null;
		zoom.hide();
		body.removeClass('zoomed');
		zoomContent.empty();
	}
	
	function changeImageDimensions() {
		windowWidth = (window.innerWidth ? window.innerWidth : $(window).width()) - 160;
		windowHeight = (window.innerHeight ? window.innerHeight : $(window).height()) - 100;
	}
	
	(function bindNavigation() {
		zoom.on('dblclick', function(event) { // 改为双击强制关闭
			event.preventDefault();
			if ($(event.target).attr('id') == 'zoom') {
				close();
			}
		});
		
		// $('#zoom .close').on('click', close);
		$('#zoom .content').on('click', ".close", close);
		
		$('#zoom .previous').on('click', openPrevious);
		$('#zoom .next').on('click', openNext);
		$(document).keydown(function(event) {
			if (!openedImage) {
				return;
			}
			if (event.which == 38 || event.which == 40) {
				event.preventDefault();
			}
			if (event.which == 27) {
				close();
			}
			if (event.which == 37 && !openedImage.hasClass('zoom')) {
				openPrevious();
			}
			if (event.which == 39 && !openedImage.hasClass('zoom')) {
				openNext();
			}
		});

		if ($('.gallery a').length == 1) {
			$('.gallery a')[0].addClass('zoom');
		}
		// $('.zoom, .gallery a').on('click', open);
	})();

	// 改为在这里动态绑定
	zoomOpen = function(selecter){
		$(selecter).on('click', open);
	};

	(function bindChangeImageDimensions() {
		$(window).on('resize', changeImageDimensions);
	})();

	(function bindScrollControl() {
		$(window).on('mousewheel DOMMouseScroll', function(event) {
			if (!openedImage) {
				return;
			}
			event.stopPropagation();
			event.preventDefault();
			event.cancelBubble = false;
		});
	})();
})(jQuery);


