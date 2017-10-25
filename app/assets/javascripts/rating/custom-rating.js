$(document).on('turbolinks:load', function () {
  $('.rating_by_user').on('change', function () {
    star_number = $(this).val();
    travel_id = $(this).parent().find('input[name="travel_id"]').val();
    class_handle = '.travel_' + travel_id;
    $.ajax({
      type: 'POST',
      url: '/action_rating',
      data: {
        "star_number": star_number,
        "travel_id": travel_id
      },
      dataType: "json",
      success: function(data){
        $(class_handle).val(data.star_number);
        $('.rating_by_user').next('span[class="label label-default"]')
          .text(I18n.t("rating_star", {star: star_number}));

        var html = '<input type="hidden" disabled class="rating rating_js travel_'
          + travel_id + ' " value="' + data.star_number + '" />'
          + '<span class="label label-default">'
          + I18n.t("rating_star", {star: data.star_number}) + '</span>';

        $("#counting").html(html);
        $('#counting .rating_js').rating();

        swal(
          I18n.t("flash.mgs_success_rating_thankyou"),
          I18n.t("flash.mgs_success_rating_thankyou"),
          I18n.t("flash.success")
        )
      },
      error: function(data){
        swal(
          I18n.t("flash.oops"),
          data.message,
          I18n.t("flash.error")
        )
      }
    });
  });

  $('.rating_js').rating();
});
