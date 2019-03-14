$(function() {
    var h = $(window).height(); 
    $('#result').css('display','none');
    $('#loading-bg ,#loader').height(h).css('display','block'); 
});
    $(window).load(function () {
    $('#loading-bg').delay(900).fadeOut(800); 
    $('#loading').delay(600).fadeOut(300); 
    $('#result').css('display', 'block');
});
