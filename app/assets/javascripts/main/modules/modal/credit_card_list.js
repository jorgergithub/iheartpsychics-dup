$(document).ready(function() {
  $("#credit_card_list_modal ul.credit_cards li").on("mouseover", function(e) {
    $(this).siblings().removeClass("cc_selected");
    $(this).addClass("cc_selected");
  });

  $("#credit_card_list_modal ul.credit_cards li .cc_actions a.edit_card").on("click", function(e) {
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

  $("#psychics_modal .modal_right_arrow").on("click", function() {
    var selected = $("#psychics_modal nav ul.modal_selected");

    if (selected.next().length > 0) {
      selected.removeClass("modal_selected");
      selected.next().addClass("modal_selected");
    }
  });

  $("#psychics_modal .modal_left_arrow").on("click", function() {
    var selected = $("#psychics_modal nav ul.modal_selected");

    if (selected.prev().length > 0) {
      selected.removeClass("modal_selected");
      selected.prev().addClass("modal_selected");
    }
  });

  $("#psychics_modal nav ul").first().addClass("modal_selected");
});