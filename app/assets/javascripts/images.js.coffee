# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

this.Image = (id, url) ->
  this.id = id
  this.url = url

  return

this.Image.all = []

this.Image.grabAll = (user_id, callback) ->
  console.log("grabbing images")
  Image.all = []

  $.getJSON(
    "/users/" + user_id + "/images.json",
    (data) ->
      $(data).each(() ->
        console.log(this)
        Image.all.push(new Image(this.id, this.url))
      )

      callback() if callback

      return
  )

  return

this.ImageCanvas = (element, image_id) ->
  that = this

  this.element = element
  this.image_id = image_id
  this.image_url = null

  this.loadImage = () ->
    $.getJSON(
      "/images/" + that.image_id,
      (data) ->
        that.image_url = data.url

        that.render()
    )

  this.render = () ->
    image = $("<img src='" + that.image_url + "'>")
    tagContainer = $("<div class='tagContainer'></div>")
    selectionContainer = $("<div class='selectionContainer'></div>")

    that.element.append(image)
    that.element.append(tagContainer)
    that.element.append(selectionContainer)

  return
