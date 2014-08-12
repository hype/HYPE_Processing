HYPE_Processing
===============
A project maintained by Joshua Davis and James Cruz.

A collection of classes that performs the heavy lifting for you by writing a
minimal amount of code. This library is compatible with both [Processing][1] and
[Processing.js][2]

This library is currently under heavy development. You can keep track of the
latest changes here in the [changelog][3].


Links
-----
- Website: http://www.hypeframework.org/
- Source Code: https://github.com/hype/HYPE_Processing


Importing HYPE to your Sketch
-----------------------------
Simply put a copy of `HYPE.pde` in your sketch folder, and you can now start
using HYPE's classes in Processing. This will work for both Java and Javascript
mode.

If in case you strictly need to use one file, just copy the contents of
`HYPE.pde` at the end of your pde file.

For developers who want to study or tweak the code in Processing, you can look
at the contents of the `pde/` folder into your sketch folder. For those who want
to tweak with the base Java source code you can look at the `java/src/` folder.
The Java code is converted to processing by the `j2p.pl` script.


Why is HYPE not a JAR file?
---------------------------
Putting HYPE in a pde file instead of a JAR file lets you use the library in
Processing.js.

In case you need HYPE in a JAR file, you could try to compile one yourself with
the base Java code in the `java/src/` folder.


Documentation
-------------
This project's documentation is generated with [Doxygen][4] and is located in
`doc/html/index.html`. Be noted that since this library is under heavy
development, especially in the staging branch, the documentation may not be 100%
complete.





[1]: http://processing.org/
[2]: http://processingjs.org/
[3]: CHANGELOG.md
[4]: http://www.stack.nl/~dimitri/doxygen/
