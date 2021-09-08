import std/[tables]
import nimraylib_now/[raylib]
import Rendering

type
  ProjectileDataObj = object
    damage: float
    pattern: uint64
    modelRef: ModelRef
    speed: float #should prop specify units
  ProjectileDataRef = ref ProjectileDataObj
  PatternObj = object

  PatternRef = ref PatternObj

func shootStraightAtPos(
  projectileData: ProjectileDataRef
  , startTransform: Transform
  , projectiles: var Table[uint64, ProjectileDataRef]
  , transforms: var Table[uint64, Transform]
  , elapsedTime: var Table[uint64, float]): uint64 =
  