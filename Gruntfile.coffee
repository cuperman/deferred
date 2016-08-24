module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'
    
    coffee:
      lib:
        files: 'stage/lib.js': [ 'lib/*.coffee' ]
      spec:
        files: 'stage/spec.js': [ 'spec/*_spec.coffee']
        
    concat:
      options:
        separator: ';';
      deferred:
        files: 'release/deferred.js': [
          'vendor/promise-4.0.0.js',
          'stage/lib.js'
        ]
      
    jasmine:
      deferred:
        src: 'release/deferred.js'
        options:
          specs: 'stage/spec.js'
          
    uglify:
      deferred:
        files: 'release/deferred.min.js': 'release/deferred.js'
    
    watch:
      compile_deferred:
        files: [ 'lib/*.coffee' ]
        tasks: [ 'coffee:lib', 'concat:deferred', 'uglify:deferred' ]
      compile_spec:
        files: [ 'spec/*_spec.coffee' ]
        tasks: [ 'coffee:spec' ]
      test_deferred:
        files: [ 'release/deferred.js', 'stage/spec.js' ]
        tasks: [ 'jasmine:deferred' ]

  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-contrib-jasmine'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  
  grunt.registerTask 'default', [ 'coffee', 'concat', 'uglify', 'jasmine' ]