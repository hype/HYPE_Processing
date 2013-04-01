HYPE_processing

A Code and Theory project / http://www.codeandtheory.com

maintained by Joshua Davis and James Cruz, is a collection of classes that performs
heavy lifting tasks while using a minimal amount of code writing.

==============================


How To Import HYPE_Processing?
-------------------------------
Simply add a copy of `HYPE.pde` to your sketch folder. That file contains the all
the classes found in the `pde/` folder. This means you don't have to mess up your
own sketch folder by copying 4 or so dozen files into it.


Why is HYPE not a Library .jar?
-------------------------------
Since the addition of ProcessingJS into Processing 2.0 Beta, and the ability to
publish to HTML using canvas... but the IN-ability to use external .jar libraries,
HYPE was initially created using the .PDE format so that publishing to JavaScript
was still a posibility.


HYPE.pde seems to be missing...
--------------------------------
If so, then it means that we updated our code but we haven't generated a new
`HYPE.pde` yet. If you want to still test the code, you can still do it by
copying the files in the `pde/` directory into your sketch folder.
