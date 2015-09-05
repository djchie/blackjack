class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button> <button class="new-button">New Game</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': -> @model.get('game').get('playerHand').hit()
    'click .stand-button': -> @model.get('game').get('playerHand').stand()
    'click .new-button': -> @model.get('game').newGame()
    

  initialize: ->
    @render()

    @model.get('game').on 'change:gameOver', (model) -> 
      @$('.hit-button').prop('disabled', true)
      @$('.stand-button').prop('disabled', true)
      winner = model.get('winner')
      @$el.append("<div class=winmessage>#{winner} won!</div>")
    , @

    @model.get('game').on 'newGame', ->
      @render()
    , @

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get('game').get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get('game').get 'dealerHand').el

