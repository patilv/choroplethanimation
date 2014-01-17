(function($) {
    $(document).ready(function() {
	
	$('#decadeplots').scianimator({
	    'images': ['decadeplots/decadeplots1.png', 'decadeplots/decadeplots2.png', 'decadeplots/decadeplots3.png', 'decadeplots/decadeplots4.png', 'decadeplots/decadeplots5.png'],
	    'width': 600,
	    'delay': 1000,
	    'loopMode': 'loop'
	});
	$('#decadeplots').scianimator('play');
    });
})(jQuery);
