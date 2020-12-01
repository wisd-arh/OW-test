$(document).ready(function(){
	var $fotoramaDiv = $("#slider").fotorama({
		nav: false,
		width: '100%',
		height: '408px',
		arrows: false,
		click: false,
		swipe: false
	});
	var fotorama = $fotoramaDiv.data('fotorama');
	$(".content__slider_pag span:first-child").click(function(){
		fotorama.show('<');
	});
	$(".content__slider_pag span:last-child").click(function(){
		fotorama.show('>');
	});
});