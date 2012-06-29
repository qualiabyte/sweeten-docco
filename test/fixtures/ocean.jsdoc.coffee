
# Ocean simulates the tides, which can't be explained.  
# Also demonstrates **sweeten-docco**:
#
#     ocean = new Ocean water, fish
#     ocean.tideGoesIn()
#          .tideGoesOut()   # You can't explain that!
#
# @api public
# @version 1.0.0
# @see sweeten-docco
class Ocean

  # Inits a new Ocean instance.
  #
  #     ocean = new Ocean( water, fish )
  #
  # @param {Water} water The water in the ocean.
  # @param {Fish} fish The fish in the sea.
  constructor: (@water, @fish) ->
    @tide = "Out"

  # Causes the tides to go in.
  #
  #     ocean.tideGoesIn()
  #
  # @return {Ocean} For chaining.
  tideGoesIn: () ->
    @tide = "In"
    console.log "Tide goes in..."
    return @

  # Causes the tides to go out.
  #
  #     ocean.tideGoesOut()
  #
  # @note Can't explain that!
  # @return {Ocean} For chaining.
  tideGoesOut: () ->
    @tide = "Out"
    console.log "Tide goes out..."
    return @

module.exports = Ocean
