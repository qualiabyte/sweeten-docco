
# Syntax demonstrates supported doc-tag syntax variants.

class Syntax

  # Typed Arrays
  # ------------

  # Accepts a foo array.  
  # Demonstrates Codo's **`Array<Type>`** syntax.
  #
  # @param [Array<Foo>] foo The foo array.
  @acceptFoo: (foo) ->
    if foo instanceof Foo
      console.log "Foo accepted!"

  # Accepts a bar array.  
  # Demonstrates JSDoc's **`Type[]`** syntax.
  #
  # @param [Bar[]] bar The bar array.
  @acceptBar: (bar) ->
    if bar instanceof Bar
      console.log "Bar accepted!"
