import std/[tables]
import nimraylib_now/[raylib, raymath]

type ModelRef* = ref Model

func draw*(transformTable: Table[uint64, Transform], modelTable: Table[uint64, ModelRef]) =
  for key, val in transformTable:
    var
      axis: Vector3
      angle: cfloat
    val.rotation.toAxisAngle(addr axis, addr angle)
    drawModelEx(modelTable[key][], val.translation, axis, angle, val.scale, White)