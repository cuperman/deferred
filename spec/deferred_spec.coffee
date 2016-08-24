describe 'Deferred', ->
  describe '#resolve', ->
    it 'should call done callbacks', (done) ->
      d = new Deferred()
      d.done ->
        done()
      d.resolve()
    
    it 'should call always callbacks', (done) ->
      d = new Deferred()
      d.always ->
        done()
      d.resolve()
      
    it 'should not call fail callbacks', (done) ->
      d = new Deferred()
      d.fail ->
        expect(true).toBe(false) # fail
      d.always ->
        done()
      d.resolve()
    
  describe '#reject', ->
    it 'should call fail callbacks', (done) ->
      d = new Deferred()
      d.fail ->
        done()
      d.reject()
    
    it 'should call always callbacks', (done) ->
      d = new Deferred()
      d.always ->
        done()
      d.reject()
    
    it 'should not call done callbacks', (done) ->
      d = new Deferred()
      d.done ->
        expect(true).toBe(false) # fail
      d.always ->
        done()
      d.reject()
      
  describe '#done', ->
    it 'should return results if already resolved', ->
      d = new Deferred()
      d.resolve('foo')
      d.done (result) ->
        expect(result).toBe('foo')
        
  describe '#fail', ->
    it 'should return results if already rejected', ->
      d = new Deferred()
      d.reject('foo')
      d.fail (result) ->
        expect(result).toBe('foo')
        
  describe '#always', ->
    it 'should return results if already resolved', ->
      d = new Deferred()
      d.resolve('foo')
      d.always (result) ->
        expect(result).toBe('foo')
        
    it 'should return results if already rejected', ->
      d = new Deferred()
      d.reject('foo')
      d.always (result) ->
        expect(result).toBe('foo')
        
  describe '#promise', ->
    it 'should return a promise object', ->
      d = new Deferred()
      
      expect(typeof d.promise()).toBe("object")
      
    it 'should have methods done, fail, and always', ->
      d = new Deferred()
      promise = d.promise()
      
      expect(typeof promise.done).toBe("function")
      expect(typeof promise.fail).toBe("function")
      expect(typeof promise.always).toBe("function")