
# Sweeten-Docco

### Sweeten docco output with syntax-highlighted JSDoc & Codo Tags.

## Should you sweeten your docco?

Do you:

1. Like docco for its literate programming style?
2. Like doc-tags for specifying details (param types, return values, etc.)?
3. Want to combine these documentation styles?

Then, perhaps! 

## How to sweeten docco?

0\. Add sweeten-docco to your project:

<pre>
    $ curl https://github.com/qualiabyte/sweeten-docco/sweeten-docco > bin/sweeten-docco
</pre>

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
