$ ->

  removeOldModalBackdrop = ->
    $('.modal-backdrop').remove()

  loadModalDialogFromServer = (location) ->
    $.get location, (data) ->
      $(modal_holder_selector).html(data).find(modal_selector).modal()

  replaceOldModalWithNewOne = ->
    $(modal_holder_selector).html(data).find(modal_selector).modal();

  modal_holder_selector = '#modal-holder'
  modal_selector = '.modal'

  $(document).on 'click', 'a[data-modal]', ->
    location = $(this).attr('href')
    #Load modal dialog from server
    loadModalDialogFromServer(location)
    false

  $(document).on 'ajax:success',
    'form[data-modal]', (event, data, status, xhr)->
      url = xhr.getResponseHeader('Location')
      if url
        # Redirect to url
        window.location = url
      else
        # Remove old modal backdrop
        removeOldModalBackdrop()

        # Replace old modal with new one
        replaceOldModalWithNewOne()
