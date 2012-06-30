# Sweeten docco output with syntax-highlighted JSDoc tags.

<a href="https://github.com/downloads/qualiabyte/sweeten-docco/sweeten-docco.png">
  <img src="https://github.com/downloads/qualiabyte/sweeten-docco/sweeten-docco.png" style="max-width: 100%; margin: 20px; box-shadow: 0 0 20px #ccc;">
</a>

## Try Sweeten-Docco if you...

1. Like docco for its Literate Programming style.
2. Like doc-tags for specifying details (param types, return values, api status, etc).
3. Want to combine these documentation styles!

## Features

* Detects [JSDoc][JSDocTags] & [Codo][Codo] tag names (plus a bonus 'api' tag).
* Supports JSDoc & Codo param styles (@param {Type} name desc, @param [Type] name desc).
* Automatically adds linebreaks between tag statements (no need to append spaces for Markdown!).

[JSDocTags]: http://code.google.com/p/jsdoc-toolkit/wiki/TagReference
[Codo]: https://github.com/netzpirat/codo

## Examples

Check out the [coffeescript](https://github.com/qualiabyte/sweeten-docco/blob/master/test/fixtures/ocean.jsdoc.coffee)
for the above sample, also used by our test suite.

## Installing

Just add sweeten-docco to your project. With curl:

<pre>
  $ curl https://github.com/qualiabyte/sweeten-docco/sweeten-docco > bin/sweeten-docco
</pre>

Or npm:

<pre>
  $ npm install sweeten-docco
</pre>

## Usage

1\. Generate docco as you usually do, eg:

<pre>
  $ docco src/*.coffee
  docco: src/file.coffee -> docs/file.html
</pre>

2\. Run sweeten-docco from your project directory:

<pre>
  $ ./bin/sweeten-docco
  Sweetening docco... Done.
</pre>
