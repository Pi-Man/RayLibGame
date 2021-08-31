# Package

version       = "0.1.0"
author        = "Pi Man, No Name Fits"
description   = "Game made with raylib"
license       = "All Rights Reserved"
srcDir        = "src"
bin           = @["RayLibGame"]
binDir        = "bin"


before build:
  cpDir("assets", binDir & "/assets")

# Dependencies

requires "nim >= 1.5.1"
requires "nimraylib_now"