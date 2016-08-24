(function() {
  "use strict";
  
  var getFoo = function() {
    var d = new Deferred();
    
    setTimeout(function() {
      console.debug("resolve foo");
      d.resolve("foo");
    }, 500);
    
    return d.promise();
  };
  
  var getBar = function() {
    var d = new Deferred();
    
    setTimeout(function() {
      console.debug("resolve bar");
      d.resolve("bar");
    }, 250);
    
    return d.promise();
  };
  
  var foo = getFoo(),
      bar = getBar();
      
  console.debug("foo", foo);
  console.debug("bar", bar);
      
  foo.done(function(fooResult) {
    bar.done(function(barResult) {
      console.debug("foo result:", fooResult);
      console.debug("bar result:", barResult);
    });
  });

})();