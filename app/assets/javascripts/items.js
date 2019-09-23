$( document ).ready(function() {
  indexes = [];
  $( ".item" ).each(function() {
    indexes.push(parseInt($(this).data('index'), 10));
  });
  window.itemIndex = Math.min.apply(null, indexes);
  currentItem().show();
});

$(document).on("change", ".radio-container input", function(){
  var key = $(this).val();
  var keyToShowMoreDetail = $(this).parents(".radio-container").data("key-to-show-more-detail-prompt");
  if($(this).parents(".radio-container").data("key-to-show-more-detail-prompt") == key){
    currentItem().find(".more-detail").show();
    $("[name='answer[explanation]']").val("");
  } else {
    currentItem().find(".more-detail").hide();
  }
  currentItem().find(".select-answer-warning").hide();
});

$(document).on("click", ".submit-answer-button button", function(e){
  if(currentItem().find("input[name='answer[answer]']:checked").length){
    next();
  } else {
    currentItem().find(".select-answer-warning").show();
  }
});

$(document).on("click", ".skip", function(e){
  e.preventDefault();
  $form = currentItem().find("form");
  // Uncheck anything they have selected
  $form.find("input[name='answer[answer]']").prop('checked',false);
  $form.submit();
  next();
  return false;
});

function next(){
  currentItem().fadeOut();
  showNextItem();
}

function currentItem(){
  return $(".item[data-index='" + itemIndex + "']");
}

function showNextItem(){
  itemIndex++;
  var $nextItem = $(".item[data-index='" + itemIndex + "']");
  if($nextItem.length){
    setTimeout(function(){  $nextItem.fadeIn('fast'); }, 800);
  } else {
    $("#itemsContainer").hide();
    $("#finishedContainer").show();
  }
}
