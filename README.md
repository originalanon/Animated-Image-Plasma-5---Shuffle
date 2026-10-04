# Animated Image wallpaper for KDE Plasma Desktop - Now with folder slideshow options!

NOTE: This is ONLY for Plasma 5 at the moment, as I'm working on the Plasma 6 release. This entire fork was born out of the desire to have a version of Animated Image with slideshows on my KDE-Mint build, which is only Plasma 5.

This is a version of Animated Image (originally by darkeye -- please see donation information below; they're the real architect of all thist) that supports timed, folder-based slideshows and shuffling. That's basically it.

Throw some love towards darkeye's way!

![donation widget](http://img.shields.io/liberapay/receives/darkeye.svg?logo=liberapay)

If you can and found this software helpful please [Donate](https://liberapay.com/darkeye/). 

# Installtion
```
git clone git@github.com:originalanon/Animated-Image-Plasma-5---Shuffle.git
cd Animated-Image-Plasma-5---Shuffle
plasmapkg2 --install .

```
# Usage

1. Right-click your desktop, and navigate to Configure Desktop and Wallpaper.
2. Change your Wallpaper Type to "Animated Image (Shuffle)".
3. To use slideshow mode, check "Shuffle images from a folder". Then, select the folder icon on the bottom right of the path bar.
4. Select your folder containing your wallpapers.
5. Set your change time in seconds.
6. Apply, and watch your animated wallpapers change!

# Development

Just fork or clone the project :

`git clone git@github.com:originalanon/Animated-Image-Plasma-5---Shuffle.git`

Then you can apply/install you're changes by running : 

`plasmapkg2 --install .` from the repository root. For an already installed copy, use `plasmapkg2 --upgrade .`.

And remove the installed wallpaper with

`plasmapkg2 --remove com.orianon.animatedImageShuffle`


## General structure and notes:

- **metadata.desktop**: maetadata used to identify and escribe the wallpaper to plasma desktop
- **contents/ui/main.qml**: Main renderer of the wallpaper
- **contents/ui/config.qml**: The configuration form for the wallpaper
- **contents/ui/BackgroundComponent.qml**: The actual logic to display the wallpaper
- You can preview your QML files quickly with `qmlscene <file>.qml`.
- May need to logout then login again for the updated `main.qml` to take effect. Or try removing
  all `*.qmlc` files.

### Resources

- Some good animations can be found at [Floris Kloet](https://livingstills.tumblr.com/)  (Checkout his archive)
  
## TODOs
- Customized tint gradinet

# Credits

This code was based on :

- Inspired mainly by com.nerdyweekly.animated wallpaper  that can be found [here](https://github.com/nhanb/com.nerdyweekly.animated)
- And some of com.github.zren.inactiveblur the can be found [here](https://github.com/Zren/plasma-wallpapers/tree/master/inactiveblur) was use for the image selection and kde integrestion


