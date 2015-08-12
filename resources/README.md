# HYPE Processing Library

A project maintained by [Joshua Davis](https://github.com/hype/).

A collection of classes that performs heavy lifting tasks while using a minimal amount of code writing.

This library is currently under heavy development. You can keep track of the latest changes here in the [CHANGELOG][1].

## Getting Started ##

### Install with the Contribution Manager

Add contributed libraries by selecting the menu item _Sketch_ → _Import Library..._ → _Add Library..._ This will open the Contribution Manager, where you can browse for ##library.name##, or any other library you want to install.

Not all available libraries have been converted to show up in this menu. If a library isn't there, it will need to be installed manually by following the instructions below.

### Manual Install

Contributed libraries may be downloaded separately and manually placed within the `libraries` folder of your Processing sketchbook. To find (and change) the Processing sketchbook location on your computer, open the Preferences window from the Processing application (PDE) and look for the "Sketchbook location" item at the top.

By default the following locations are used for your sketchbook folder:
  * For Mac users, the sketchbook folder is located inside `~/Documents/Processing`
  * For Windows users, the sketchbook folder is located inside `My Documents/Processing`

Download ##library.name## from ##library.url##

Unzip and copy the contributed library's folder into the `libraries` folder in the Processing sketchbook. You will need to create this `libraries` folder if it does not exist.

The folder structure for library ##library.name## should be as follows:

```
Processing
  libraries
    ##project.name##
      examples
      library
        ##project.name##.jar
      reference
      src
```

Some folders like `examples` or `src` might be missing. After library ##library.name## has been successfully installed, restart the Processing application.

### Documentation
TODO: Add link to Java docs here

### Contributors
James Cruz, [Benjamin Fox](https://github.com/tracerstar), [Christopher Tino](https://github.com/christophertino)

### License
##library.name## is available under the BSD license. See [LICENSE][2] for full details.

[1]: CHANGELOG.md
[2]: LICENSE.txt