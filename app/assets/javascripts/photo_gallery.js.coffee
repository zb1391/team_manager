jQuery ->
  if $('#photo-infinite-scroll').size() > 0
    $(window).on 'scroll', ->
      if ($(window).scrollTop() == $(document).height() - $(window).height())
        loadImages()


  loadImages = ->
    path = window.location.pathname+'.json'
    $.get(path,{last: $('#photo-infinite-scroll').data('last')}, handlePhotoAjax)

  handlePhotoAjax = (data) ->
    $.each(data,appendToGallery)
    newLast = data[data.length-1].id
    console.log(newLast)
    $('#photo-infinite-scroll').data('last',newLast)

  appendToGallery = (index, photoData) ->
    newPhoto = createPhotoHtml(photoData)
    $('.instagram-gallery .row').append(newPhoto)
    
  createPhotoHtml= (pic) ->
    html = '<div class="col-md-4 col-lg-4"><div class="pic"><img style="width:100%" src="'+pic.images.standard_resolution.url+'" />'
    if pic.caption?
      html+='<p>'+ pic.caption.text+'</p>'
    if pic.comments.data.length > 0
      html+='<dl>'
      $.each(pic.comments.data, (index,comment) ->
        html+='<dd><strong>@'+comment.from.username+':&nbsp;</strong>'+comment.text+'</dd>'
      )
      html+='</dl>'
    html+='</div></div>'

