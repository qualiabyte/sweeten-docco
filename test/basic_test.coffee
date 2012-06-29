assert  = require 'assert'
{exec}  = require 'child_process'

tests = []
test = (name, fn) -> tests.push [name, fn]

runTests = () ->
  i = 1
  failures = []

  for test in tests
    name = test[0]
    fn = test[1]
    err = null
    try
      process.stdout.write "Test #{i}: #{name}, "
      fn()
    catch err
      console.log "Failed: ", err
      failures.push test
    finally
      if not err
        console.log "Complete"
    i++

  if failures.length
    console.log "Failed #{failures.length} of #{tests.length} total tests."
    process.exit 1
  else
    console.log "All tests passed! (#{tests.length} total)"
    process.exit 0

test 'Sanity Check', ->
  assert.ok 1 + 1 == 2

#test 'Should Fail', ->
#  assert.ok false

test 'JSDoc', ->
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

# Let's do this!
runTests()
