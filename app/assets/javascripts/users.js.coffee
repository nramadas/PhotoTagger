# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

this.IndexCanvas = (element) ->
  that = this

  this.element = element

  this.populate = (user_id) ->
    Image.grabAll(user_id, this.render)


  this.render = () ->
    that.element.empty()

    $(Image.all).each(() ->
      link = $("<a href='/images/" + this.id + "'></a>")
      image = $("<div class='image'></div>")
      image.html("<img src='" + this.url + "'>")
      link.append(image)
      that.element.append(link)
    )

  return