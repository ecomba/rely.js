window.Rely = class RelyonMe
  constructor: ->
    @rely_script = $.find('script[src*="rely.js"]')

  path: ->
    src_attribute = @rely_script.attr('src')
    src_attribute.substring(0, src_attribute.search('rely.js'))

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
    @loadScript "#{@path()}#{app}.js", false
    new (eval(app))(options, @)

  load: ->
    @loadApp(@rely_script.data('app'), @rely_script.data('options'))

$(new Rely().load())
