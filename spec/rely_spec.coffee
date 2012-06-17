describe 'rely', ->
  beforeEach ->
    obj = {
      data: (value)->
        return 'testapp' if value == 'app'
        {} if value == 'options'
    }
    @existingEngine = jQuery.find
    jQuery.find = (selector)->
      if selector == 'script[src*="relyr.js"]'
        return obj
      return @existingEngine.find.apply(existingEngine, arguments)
    @ajaxSpy = sinon.spy($, 'ajax')
    $.mockjax(
      url: '*'
      responseText: 
        """
        (function() {
          window.testapp = TestApp = (function(_super) {
            function TestApp(options) {
            }
            TestApp.prototype.hello = function() {
              return 'hi there';
            };
            TestApp.prototype.dependencies = ['a.js', 'b.js'];
            return TestApp;
          })();
        }).call(this);
        """
    )
    @rely = new Rely()

  afterEach ->
    $.mockjaxClear()
    @ajaxSpy.restore()
    jQuery.find = @existingEngine

  it 'loads one dependency', ->
    @rely.loadDependencies ['testapp.js']
    expect(@ajaxSpy).toHaveBeenCalledOnce()

  it 'loads one dependency asynchronously', ->
    spy = sinon.spy(@rely, 'loadScript')
    @rely.loadDependencies [{name: 'async.js', async: true}]
    expect(spy).toHaveBeenCalledWith('async.js', true)
    
  it 'loads dependencies', ->
    @rely.loadDependencies ['test.js', 'another.js']
    expect(@ajaxSpy).toHaveBeenCalledTwice()

  it 'loads the script of the app', ->
    spy = sinon.spy(@rely, 'loadScript')
    stub = sinon.stub(@rely, 'loadDependencies').returns(true)
    @rely.loadApp('testapp', {})
    expect(spy).toHaveBeenCalledWith('/js/testapp.js', false)

  it 'loads app and makes it available', ->
    expect(@rely.load().hello()).toEqual 'hi there'

  it 'loads the dependencies of the app', ->
    spy = sinon.spy(@rely, 'loadDependencies')
    @rely.load()
    expect(spy).toHaveBeenCalledWith(['a.js', 'b.js'])

