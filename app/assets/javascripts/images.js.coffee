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
  this.tagContainer = null
  this.selectionContainer = null

  this.initialize = () ->
    that.loadImage()
    $(that.element).click(that.click.bind(that))
    User.grabAll()

  this.loadImage = () ->
    $.getJSON(
      "/images/" + that.image_id,
      (data) ->
        that.image_url = data.url

        that.render()
    )

  this.render = () ->
    image = $("<img src='" + that.image_url + "'>")
    that.tagContainer = $(".tagContainer")
    that.selectionContainer = $("<div class='selectionContainer'></div>")

    that.element.prepend(image)
    that.element.append(that.selectionContainer)
    that.selectionContainer.mouseleave(() ->
      that.selectionContainer.empty()
    )

  this.click = (event) ->
    console.log("here")
    elementWidth = that.element.width()
    elementHeight = that.element.height()
    elementXpos = (.20 * $(document).width()) # dependent on the fact
    # that the element occupies 70% of the screen's real estate
    elementYpos = that.element.position().top

    pixX = event.pageX # pixel position of the mouse click
    pixY = event.pageY # pixel position of the mouse click

    xpos = (((pixX - elementXpos) / elementWidth) * 100);
    ypos = (((pixY - elementYpos) / elementHeight) * 100);

    that.drawTag(xpos, ypos)

  this.drawTag = (xpos, ypos) ->
    that.selectionContainer.empty()

    container = $("<div></div>")
                  .addClass("container")
                  .css("top", ypos + "%")
                  .css("left", xpos + "%")

    h = new SelectionHandler(container, that.selectionContainer)
    h.setup(xpos, ypos, that.image_id)

    that.selectionContainer.append(container)

  return

this.SelectionHandler = (element, parent) ->
  that = this

  this.element = element
  this.parent = parent

  this.setup = (xpos, ypos, image_id) ->
    pretag = $("<div></div>").addClass("pretag")
    
    selections = $("<div></div>").addClass("select")

    $(User.all).each(() ->
      option = $("<div>" + this.username + "</div>")
      option.addClass("option")
      option.data('all' : {'user': this.username, 'xpos': xpos, 'ypos': ypos, 'user_id': this.id, 'image_id': image_id})

      selections.append(option)
    )

    that.element.append(pretag).append(selections)

    that.element.on("click", ".option", () ->
      that.optionSelect($(this).data('all'))
      that.parent.empty()
      return false
    )

  this.optionSelect = (data) ->
    console.log(data)
    t = new Tag(null, data.user, data.user_id, data.image_id, data.xpos, data.ypos)
    t.save()

  return

