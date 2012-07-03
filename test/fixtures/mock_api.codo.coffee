
# This mock class tests the codo syntax and for false positives.
#
# That is, **sweeten-docco** should pretty-print the @-tags
# in the documentation sections, but not the code.
#
# For example, this code listing should be preserved:
#
#     # A new api instance with @api and @version properties
#     api = new Api('public', '1.0.0')
#
# @api public
# @version 1.0.0
class Api

  # Inits a new Api instance.
  #
  # @param api [String] The api status (public or private).
  # @param version [String] The api version.
  constructor: (@api, @version) ->

  # Returns a string for this api.
  # @return [String] An api string.
  toString: ->
    return "Api: #{@api}, version: #{@version}"

module.exports = Api
