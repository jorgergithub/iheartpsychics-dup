$(document).ready(function() {
  $("#credit_card_list_modal ul.credit_cards li").on("mouseover", function(e) {
    $(this).siblings().removeClass("cc_selected");
    $(this).addClass("cc_selected");
  });

  $("#credit_card_list_modal ul.credit_cards li").on("mouseout", function(e) {
    $(this).siblings().removeClass("cc_selected");
  });

  $("#purchase_select_card_modal ul.credit_cards li").on("click", function(e) {
    e.preventDefault();
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

  $("#purchase_select_card_modal .paypal_tab").on("click", function(e) {
    $(this).siblings().removeClass("tab_selected");
    $(this).addClass("tab_selected");
    $(".modal_panel.paypal_panel").show();
    $(".modal_panel.credit_cards_panel").hide();
  });

  $("#purchase_select_card_modal .credit_card_tab").on("click", function(e) {
    $(this).siblings().removeClass("tab_selected");
    $(this).addClass("tab_selected");
    $(".modal_panel.paypal_panel").hide();
    $(".modal_panel.credit_cards_panel").show();
  });
});