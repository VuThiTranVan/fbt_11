$(document).on('ready turbolinks:load', function () {
  $('.rating').each(function () {
    var load = $(this).next('span[class="label label-default"]').length > 0;

    $('<span class="label label-default"></span>')
      .text($(this).val() + I18n.t("rating_star_max") || ' ')
      .insertAfter(this);
    if(load == true) {
      $(this).next('span[class="label label-default"]').html("");
    }
  });

  $('.rating_js').rating();
});
