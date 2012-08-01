assert  = require 'assert'
{exec}  = require 'child_process'

tests = []
test = (name, fn) -> tests.push [name, fn]

runTests = () ->
  queue = []
  failures = []
  pending = {}

  runTest = (test, i, cb) ->
    [name, fn] = test
    err = null

    process.stdout.write "Test #{i}: #{name}, "

    # Async tests have a 'done' callback
    isAsync = fn.length == 1

    if isAsync
      pending[i] = test

      # Timeout after 5 seconds
      timeoutId = setTimeout () ->
        console.log "Timed out."
        failures.push test
        done()
      , 5000

      # Done callback will run on success or timeout
      done = () ->
        console.log "Complete"
        clearTimeout timeoutId
        delete pending[i]
        cb()

      # Start the test
      fn done

    else
      # Run a non-async test
      try
        fn()
      catch err
        console.log "Failed: ", err
        failures.push test
      finally
        if not err
          console.log "Complete"
        cb()

  runNext = (cb) ->
    return if queue.length is 0
    i = tests.length - queue.length + 1
    test = queue.shift()
    runTest(test, i, cb)

  runRemaining = () ->
    runNext runRemaining

  queueTest = (test) ->
    queue.push test

  runAll = () ->
    queueTest(test) for test in tests
    runRemaining()

  runAll()

  # When all tests complete
  process.once 'exit', ->
    if failures.length
      console.log "Failed #{failures.length} of #{tests.length} total tests."
      process.exit 1
    else
      console.log "All tests passed! (#{tests.length} total)"
      process.exit 0

test 'Sanity Check', ->
  assert.ok 1 + 1 == 2

test 'JSDoc', (done) ->
  exec "./node_modules/docco/bin/docco test/fixtures/ocean.jsdoc.coffee", (err, stdout, stderr) ->
    assert.equal err, null, "docco should run successfully"

    exec "./sweeten-docco", (err, stdout, stderr) ->
      assert.equal err, null, "sweeten-docco should run successfully"
      assert.equal stdout, "Sweetening docco... Done.\n"

      exec "cat docs/ocean.jsdoc.html", (err, stdout, stderr) ->
        assert.equal err, null, "cat should run successfully"
        assert.ok stdout.match /<b>api<\/b>/
        assert.ok stdout.match /<b>return<\/b>/
        assert.ok stdout.match /<b>param<\/b>/
        assert.ok stdout.match /<i>Water<\/i>/
        assert.ok stdout.match /<div class="doc-tag"><b>api<\/b> public<\/div>/
        assert.ok stdout.match /<div class="doc-tag"><b>param<\/b> <code>water<\/code> <i>Water<\/i> The water in the ocean.<\/div>/
        assert.ok stdout.match /<div class="doc-tag"><b>return<\/b> <i>Ocean<\/i> For chaining./
        done()

test 'Codo', (done) ->
  exec "./node_modules/docco/bin/docco test/fixtures/mock_api.codo.coffee", (err, stdout, stderr) ->
    assert.equal err, null, "docco should run successfully"

    exec "./sweeten-docco", (err, stdout, stderr) ->
      assert.equal err, null, "sweeten-docco should run successfully"
      assert.equal stdout, "Sweetening docco... Done.\n"

      exec "cat docs/mock_api.codo.html", (err, stdout, stderr) ->
        assert.equal err, null, "cat should run successfully"
        assert.ok stdout.match /<div class="doc-tag"><b>api<\/b> public<\/div>/
        assert.ok stdout.match /<div class="doc-tag"><b>version<\/b> 1.0.0<\/div>/
        assert.ok stdout.match /# A new api instance with @api and @version properties/
        assert.ok stdout.match /(@api, @version)/
        assert.ok stdout.match /Api: .*@api.*, version.*@version/
        done()

test 'Syntax', (done) ->
  exec "./node_modules/docco/bin/docco test/fixtures/syntax.coffee", (err, stdout, stderr) ->
    assert.equal err, null, "docco should run successfully"

    exec "./sweeten-docco", (err, stdout, stderr) ->
      assert.equal err, null, "sweeten-docco should run successfully"
      assert.equal stdout, "Sweetening docco... Done.\n"

      exec "cat docs/syntax.html", (err, stdout, stderr) ->
        assert.equal err, null, "cat should run successfully"
        assert.ok ~stdout.indexOf('<div class="doc-tag"><b>property</b> <code>VERSION</code> <i>String</i> The module version.</div>'), 'check property tag syntax'
        assert.ok ~stdout.indexOf('<div class="doc-tag"><b>param</b> <code>foo</code> <i>Array&lt;Foo&gt;</i> The foo array.</div>'), 'check Array<Type> syntax'
        assert.ok ~stdout.indexOf('<div class="doc-tag"><b>param</b> <code>bar</code> <i>Bar[]</i> The bar array.</div>'), 'check Array<Type> syntax'
        done()

# Let's do this!
runTests()
