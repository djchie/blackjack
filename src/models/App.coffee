# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()


    @on 'stand', @get('dealerHand').dealerPlay()

    @checkForBlkJk()

  defaults: 
    gameOver: false
    winner: null

  checkForBlkJk: -> 
    dealerTotal = @get('dealerHand').reduce (memo, card) ->
      memo + card.get('value')
    , 0
    playerTotal = @get('playerHand').reduce (memo, card) ->
      memo + card.get('value')
    , 0  
    if dealerTotal == 21 and playerTotal == 21
      @set 'winner', 'push'

      @set 'winner', 'dealer'
      @set 'gameOver', true
      

