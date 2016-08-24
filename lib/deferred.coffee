class Deferred
  constructor: ->
    @resolved = false
    @failed = false
    @result = null
    
    @doneQueue = []
    @failQueue = []
    @alwaysQueue = []
    
    @promiseObject = new Promise (fulfil, reject) =>
      @fulfilCallback = fulfil
      @rejectCallback = reject
      
    @promiseObject.then ( (result) =>
      @resolved = true
      @result = result
      for callback in @doneQueue
        callback.call @, @result
      for callback in @alwaysQueue
        callback.call @, @result
    ), ( (result) =>
      @failed = true
      @result = result
      for callback in @failQueue
        callback.call @, @result
      for callback in @alwaysQueue
        callback.call @, @result
    )
    
  done: (callback) ->
    if @resolved
      callback.call @, @result
    else
      @doneQueue.push callback
    
  fail: (callback) ->
    if @failed
      callback.call @, @result
    else
      @failQueue.push callback
    
  always: (callback) ->
    if @result
      callback.call @, @result
    else
      @alwaysQueue.push callback
  
  resolve: (result) ->
    @fulfilCallback.call(@, result)
    
  reject: (result) ->
    @rejectCallback.call(@, result)
    
  promise: ->
    {
      done: @done.bind(@)
      fail: @fail.bind(@)
      always: @always.bind(@)
    }
    
root = exports ? this
root.Deferred = Deferred