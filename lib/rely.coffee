window.Rely = class RelyonMe
  constructor: ->
    @rely_script = $.find('script[src*="rely.js"]')

  loadDependencies: (dependencies)->
    for script in dependencies
      if script.name
        @loadScript script.name, script.async 
      else
        @loadScript script, false

  loadScript: (script, async)->
    $.ajax(
      url: script
      async: async
      dataType: 'script'
      error: ->
        console.log 'Something really bad happened...'
    )

  loadApp: (app, options)->
    @loadScript "/js/#{app}.js", false
    app = new (eval(app))(options)
    @_loadAppDependencies(app)
    app

  _loadAppDependencies: (app)->
    @loadDependencies(app.dependencies) if app.dependencies

  load: ->
    @loadApp(@rely_script.data('app'), @rely_script.data('options'))

$(new Rely().load())
