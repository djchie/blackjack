class window.Game extends Backbone.Model 
  initialize: ->
    @set 'deck', deck = new Deck()
    @newGame()

    

  defaults: 
    gameOver: false
    winner: null

  determineWinner: ->
    playerTotal = @get('playerHand').scores()
    dealerTotal = @get('dealerHand').scores()

    if playerTotal[0] > 21 and playerTotal[1] > 21
      @set 'winner', 'dealer' 
      @set 'gameOver', true
    
    else if dealerTotal[0] > 21 and dealerTotal[1] > 21  
      @set 'winner', 'player'
      @set 'gameOver', true
    
    playerTotal = playerTotal.filter (score) ->
      score <= 21  
    dealerTotal = dealerTotal.filter (score) ->
      score <= 21

    if playerTotal.length == 2
      playerMax =  Math.max(playerTotal[0], playerTotal[1])
    else playerMax = playerTotal[0] 

    if dealerTotal.length == 2
      dealerMax =  Math.max(dealerTotal[0], dealerTotal[1])
    else dealerMax = dealerTotal[0] 

    if playerMax == dealerMax
      @set 'winner', 'push'
      @set 'gameOver', true
    else if playerMax > dealerMax
      @set 'winner', 'player'
      @set 'gameOver', true
    else if dealerMax > playerMax
      @set 'winner', 'dealer' 
      @set 'gameOver', true

    console.log("GameOv: " + @get('gameOver') + " winner: " + @get('winner'))  


  checkForBlkJk: -> 
    dealerBJ = @get('dealerHand').hasAce() and @get('dealerHand').cardValuesSum() == 11
    playerBJ = @get('playerHand').hasAce() and @get('playerHand').cardValuesSum() == 11

    if (playerBJ and dealerBJ)
      @set 'winner', 'push'
      @get('dealerHand').revealCards()
      @set 'gameOver', true
      @trigger 'gameEnd', @
    else if (playerBJ)
      @set 'winner', 'player'
      @get('dealerHand').revealCards()
      @set 'gameOver', true
      @trigger 'gameEnd', @
    else if (dealerBJ)
      @set 'winner', 'dealer' 
      @get('dealerHand').revealCards()
      @set 'gameOver', true
      @trigger 'gameEnd', @

    console.log("blkjk: " + @get('gameOver') + " winner: " + @get('winner'))  
  
  newGame: ->
    if @get('deck').models.length < 11
      @set 'deck', new Deck()

    @set 'gameOver', false
    @set 'winner', null
    @set 'playerHand', @get('deck').dealPlayer()
    @set 'dealerHand', @get('deck').dealDealer()
    @get('playerHand').on 'stand', @get('dealerHand').dealerPlay, @get('dealerHand')
    @get('playerHand').on 'gameEnd', @determineWinner, @
    @get('dealerHand').on 'gameEnd', @determineWinner, @
    @trigger 'newGame', @
    console.log 'New game created'
    @checkForBlkJk()
    
      

