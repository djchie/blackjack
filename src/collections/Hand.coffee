class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->

  hit: ->
    @add(@deck.pop())
    @last()
    scores = @scores()
    if scores[0] == 21 or scores[1] == 21
      @trigger 'gameEnd', @
    else if scores[0] > 21 and scores[1] > 21
      @trigger 'gameEnd', @

  stand: -> @trigger 'stand', @
  
  revealCards: ->
    _.each @models, (card) -> 
      card.flip() if not card.get('revealed')
    , @

  dealerPlay: -> 
    @revealCards()
    scores = @scores()
    while scores[0] < 17 || scores[1] < 17
      @hit()
      scores = @scores()

    @trigger 'gameEnd', @ 
    

      

  hasAce: -> @reduce (memo, card) ->
    memo or card.get('value') is 1
  , 0

  minScore: -> @reduce (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  cardValuesSum: -> @reduce (val, card) ->
    val += card.get 'value'
  , 0  

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    [@minScore(), @minScore() + 10 * @hasAce()]


