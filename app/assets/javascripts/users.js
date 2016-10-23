$(document).on("turbolinks:load",function(){
  $('.alert').delay(1000).slideUp();
  $('.detail_message').on('show.bs.modal', function(e){
    var $modal = $(this);
    var name =  $(e.relatedTarget).attr('data-name');
    var email =  $(e.relatedTarget).attr('data-email');
    var sent_at =  $(e.relatedTarget).attr('data-time');
    var content =  $(e.relatedTarget).attr('data-content');
    $modal.find('.message-content').find('.name').html(name);
    $modal.find('.message-content').find('.email').html(email);
    $modal.find('.message-content').find('.sent_at').html(sent_at);
    $modal.find('.message-content').find('.content').html(content);
  });

  $('.show_detail_message').on('click', function(e){
    e.preventDefault();
    var message_id = $(this).data('id');
    $.ajax({
      url: '/messages/' + message_id,
      type: 'PATCH',
      dataType: 'JSON',
      data: {message_id: message_id},
      cache: false,
      success: function(result){
          $('.message-' + result.id).css('background-color', '#fff');
      }
    })
  })

});
