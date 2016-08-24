# Deferred.js

Deferred.js provides deferred objects which implement the promise interface. They make async calls easier. Inspired by [jQuery deferred objects](http://api.jquery.com/category/deferred-object/).

Utilizes promise [pollyfill](https://www.promisejs.org/polyfills/promise-4.0.0.js) from [promisejs.org](https://www.promisejs.org/)

## Creating a Deferred Object

Use the `new` operator to create a new deferred object instance:

```javascript
var d = new Deferred();
```

## Resolve/Reject

When your async