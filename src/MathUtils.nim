import nimraylib_now/[raylib, raymath]

func easeExpStep*(start, target: Vector3, deltaMove: cfloat): Vector3 =
  result = (target - start) * deltaMove 