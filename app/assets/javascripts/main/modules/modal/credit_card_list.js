$(document).ready(function() {
  $("#credit_card_list_modal ul.credit_cards li").on("mouseover", function(e) {
    $(this).siblings().removeClass("cc_selected");
    $(this).addClass("cc_selected");
  });

  $("#credit_card_list_modal ul.credit_cards li").on("mouseout", function(e) {
    $(this).siblings().removeClass("cc_selected");
  });

  $("#credit_card_list_modal ul.credit_cards li .cc_actions a").on("click", function(e) {
    e.preventDefault();
    e.stopPropagation();
  });

  $("#credit_card_list_modal ul.credit_cards li .cc_actions a.delete_card").on("click", function(e) {
    e.preventDefault();
    e.stopPropagation();

    $(this).closest("li").fadeOut(function() {
      // remove card from db
      $(this).remove();
    });
  });
});