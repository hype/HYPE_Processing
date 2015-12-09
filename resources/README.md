# HYPE Processing Library

A project maintained by [Joshua Davis](https://github.com/hype/) / [twitter.com/joshuadavis](https://twitter.com/joshuadavis/).

##library.sentence##

##library.paragraph##

This library is currently under heavy development. You can keep track of the latest changes here in the [CHANGELOG][1].

## Getting Started ##

### Install to Processing Sketchbook

The ##project.name## library may be uzipped from the distribution folder and manually placed within the `libraries` folder of your Processing sketchbook. To find (and change) the Processing sketchbook location on your computer, open the Preferences window from the Processing application (PDE) and look for the "Sketchbook location" item at the top.

By default the following locations are used for your sketchbook folder:
  * For Mac users, the sketchbook folder is located inside `~/Documents/Processing`
  * For Windows users, the sketchbook folder is located inside `My Documents/Processing`

Download ##project.name## from ##library.url##

Unzip and copy the ##project.name## folder into the `libraries` folder in the Processing sketchbook. You will need to create this `libraries` folder if it does not exist.

The folder structure for ##project.name## should be as follows:

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

After ##project.name## has been successfully installed, restart the Processing application.

#### Build Sources with ANT

Run build.xml in the Resources folder. If you're running Windows, you'll need to update 'sketchbook.location' and 'classpath.local.location' in build.properties.

The HYPE library will be added to your sketchbook folder automatically.

### Documentation
TODO: Add link to Java docs here

### Contributors
James Cruz, [Benjamin Fox](https://github.com/tracerstar), [Christopher Tino](https://github.com/christophertino)

### License
##project.name## is available under the BSD license. See [LICENSE][2] for full details.

[1]: CHANGELOG.md
[2]: LICENSE.txt