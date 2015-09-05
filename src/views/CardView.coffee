class window.CardView extends Backbone.View
  className: 'card'

  template: _.template '<%= rankName %> of <%= suitName %>'

  initialize: -> @render()

  render: ->
    if @model.get 'revealed'
      image = "#{@model.get('rankName')}-#{@model.get('suitName')}.png"
      url = 'url("./img/cards/' + image + '")'
      @$el.css({
        'background-image': url, 
        'background-size': 'contain'
      })
    @$el.children().detach()
    #@$el.html @template @model.attributes
    @$el.addClass 'covered' unless @model.get 'revealed'

