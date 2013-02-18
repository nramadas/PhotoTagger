# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

this.Tag = (id, user, user_id, image_id, xpos, ypos) ->
  that = this

  this.id = id
  this.user = user
  this.user_id = user_id
  this.image_id = image_id
  this.xpos = xpos
  this.ypos = ypos

  this.save = (callback) ->
    $.post(
      "/tags.json",
      {
        tag: {
          id: that.id,
          user_id: that.user_id,
          image_id: that.image_id,
          xpos: that.xpos,
          ypos: that.ypos
        }
      },
      (response) ->
        that.id = response.id

        Tag.all.push(that)

        callback() if callback
    )

  return

this.Tag.all = []

this.Tag.grabAll = (image_id, callback) ->
  Tag.all = []
  console.log("grabbing tags")

  $.getJSON(
    "/images/" + image_id + "/tags",
    (data) ->
      $(data).each(() ->

        t = new Tag(this.id,
                    this.user,
                    this.user_id,
                    this.image_id,
                    this.xpos,
                    this.ypos)

        Tag.all.push(t)
      )

      callback() if callback

  )

  return

this.TagToggler = (button, element, image_id) ->
  that = this

  this.button = button
  this.element = element
  this.image_id = image_id
  this.display = true

  this.show = () ->
    that.element.empty()
    Tag.grabAll(that.image_id, that.show_helper)

  this.show_helper = () ->
    $(Tag.all).each(() ->
      console.log(this)
      tag = $("<div>" + this.user + "</div>")
              .addClass("tag")
              .css("top", (parseInt(this.ypos)) + "%")
              .css("left", (parseInt(this.xpos)) + "%")

      that.element.append(tag)
    )

    that.display = false

  this.hide = () ->
    that.element.empty()
    that.display = true

  this.toggle = () ->
    if that.display
      that.show()
    else
      that.hide()

  this.initialize = () ->
    $(that.button).click(() ->
      that.toggle()
    )

  return