$(function(){
  $(".star-on, .star-off").click(function() {
    rateNumber = $(this).attr('data-rate-number');
    changeRating(rateNumber)
  });
  var changeRating = function(rateNumber) {
    $('#rate').val(rateNumber);
    $(".star-on").toggleClass("star-on star-off");
    $(".star-off").each(function() {
      if ($(this).attr('data-rate-number') <= rateNumber) {
        $(this).toggleClass("star-on star-off");
      }
    });
  }
});


