assert  = require 'assert'
{exec}  = require 'child_process'

tests = []
test = (name, fn) -> tests.push [name, fn]

runTests = () ->
  i = 0
  for test in tests
    name = test[0]
    fn = test[1]
    err = null
    try
      process.stdout.write "Test #{i}: #{name} "
      fn()
    catch err
      console.log "Failed: ", err
    finally
      if not err
        console.log "Complete"
    i++

test 'JSDoc', ->
  exec "./node_modules/docco/bin/docco test/fixtures/jsdoc.coffee", (err, stdout, stderr) ->
    assert.equal err, null, "docco should run successfully"

    exec "./sweeten-docco", (err, stdout, stderr) ->
      assert.equal err, null, "sweeten-docco should run successfully"
      assert.equal stdout, "Sweetening docco... Done.\n"

      exec "cat docs/jsdoc.html", (err, stdout, stderr) ->
        assert.equal err, null, "cat should run successfully"
        assert.ok stdout.match /<b>api<\/b>/
        assert.ok stdout.match /<b>return<\/b>/
        assert.ok stdout.match /<b>param<\/b>/
        assert.ok stdout.match /<i>Water<\/i>/
        assert.ok stdout.match /<div class="doc-tag"><b>api<\/b> public<\/div>/
        assert.ok stdout.match /<div class="doc-tag"><b>param<\/b> <code>water<\/code> <i>Water<\/i> The water in the ocean.<\/div>/
        assert.ok stdout.match /<div class="doc-tag"><b>return<\/b> <i>Ocean<\/i> For chaining./

# Let's do this!
runTests()
