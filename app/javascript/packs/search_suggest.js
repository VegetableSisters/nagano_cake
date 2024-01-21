$(document).on('turbolinks:load', function() {
  $('#search-input').on('input', function() {
    var input = $(this).val();

    $.ajax({
      method: 'GET',
      url: '/search/suggest',
      data: { q: input },
      dataType: 'json',
      success: function(data) {
      }
    });
  });
});
