$(document).on("click", "#startButtonContainer", function(){
  tryStartSwiping();
});

$(document).on("keypress", "input[name='name']", function(e){
  if (e.which == 13) {
    tryStartSwiping();
    return false;
  }
});

function tryStartSwiping(){
  var name = $("input[name='name']").val();
  if(String(name).length > 0){
    $("#nameContainer").hide();
    $("#itemsContainer").show();
    $("#answer_user_name").val(name);

    var height = $("#fixedBottom").outerHeight();
    $(".content").css('paddingBottom', height + 'px');
  } else {
    alert("Please enter your name");
  }
}

window.itemIndex = 0;
$(document).on("click", ".answer-buttons button", function(){
  var $currentItem = $(".item[data-index='" + itemIndex + "']");
  storeAnswer($currentItem, $(this));
  removeCurrentItem($(this), $currentItem);
  showNextItem();
});

function storeAnswer($item, $answer){
  $("#answer_question").val($item.find(".question-container").find("h2").text());
  $("#answer_answer").val($answer.data("key"));
  $("#answer_item_id").val($item.data("id"));
  $("#answerForm").submit();
  $("[name='answer[explanation]']").val("");
}

function removeCurrentItem($answerButton, $currentItem){
  var swipeDirection = $answerButton.data("swipe-direction");
  if(swipeDirection == "left"){
    swipeLeft($currentItem);
  } else if(swipeDirection == "right") {
    swipeRight($currentItem);
  } else {
    $currentItem.fadeOut();
  }
}

function swipeRight($element){
  $element.addClass('rotate-left').delay(700).fadeOut(0.6);
}

function swipeLeft($element) {
  $element.addClass('rotate-right').delay(700).fadeOut(0.6);
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

$(document).on("click", "#quitButtonContainer", function(){
  var confirmation = confirm("Are you sure you want to quit?");
  if (confirmation == true) {
    $("#itemsContainer").hide();
    $("#finishedContainer").show();
  }
});
