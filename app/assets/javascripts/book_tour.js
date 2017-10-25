$(document).on('turbolinks:load', function () {
  $('#book_tour_number_person').on('change', function () {
    $('#price_total').html(I18n.toCurrency($('#price').text().replace(/[$,]/g,'')*$(this).val()));
  });
});
