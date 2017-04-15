# --------------------------------
# FORM
# --------------------------------
class App.CategoryForm

  constructor: () ->
    @element = $('#js-photos')
    $('#js-progress-bar').hide()
    @bindEvents()

  # ---- Binding de Eventos
  bindEvents: () ->
    $('#fileupload').fileupload
      dataType: 'script'
      start: ->
        $('#js-progress-bar').show()
        $('#js-progress-bar').find('.progress-bar').css('width', '0%')
      progressall: (e, data)->
        progress = parseInt(data.loaded / data.total * 100, 10)
        $('#js-progress-bar').find('.progress-bar').css('width', "#{progress}%")
      fail: ->
        App.flash_snackbar_render
          danger: 'Uploading images has failed'
      always: ->
        $('#js-progress-bar').hide()

  # ---- Funciones
  removePhoto: (photo_id)->
    $("#photo_#{photo_id}").remove()
# ---------------------------------



# --------------------------------
# --------------------------------
$(document).on "turbolinks:load page:change", ->
  App.category_form = new App.CategoryForm() unless $(".categories.new, .categories.edit, .categories.create, .categories.update, .categories.upload_category_photos").length == 0

