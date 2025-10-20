# pbpp --- Protocol Buffer Pretty Printer

## SYNOPSIS

````
pbpp [ - | file ]
````

## DESCRIPTION

`Pbpp` reads a protocol buffer message in text format and produces a
neatly indented listing of the original message on the standard output.
Messages to be formatted are read from either the named file or standard
input; specifying "-" as the input filename causes standard input to
be read.  Indentation is fixed at two spaces per level, and `pbpp` takes
no options.

Tokenization is simple and grammar rules are derived from observation
of the protocol buffer text format.  The program makes no effort to
validate the contents of the message and `pbpp` is completely unaware of
the message's type.

## SOURCE

https://github.com/dancrossnyc/pbpp/

## SEE ALSO

* lex(1)
* yacc(1)
* [Protocol Buffers](https://developers.google.com/protocol-buffers)

## DIAGNOSTICS

If the input file is unreadable or there is a parse error, a message
will be printed to the standard error.

## LICENSE

Apache 2.0 (Copyright Google)

## BUGS

Comment handling is rudimentary at best and probably does not do what
you expect.

The message type is not validated; other tools exist for that.

The lexical scanner and parser are simple to the point of being
simplistic.

Diagnostics are poor and nonspecific.
