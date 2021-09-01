import nimraylib_now/[raylib, raymath]

const movementSpeed: cfloat = 1.0
const mouseSensitivity: cfloat = 1.0

type Player* = object
  position*: Vector3
  yaw*, pitch*: cfloat
  velocity*: Vector3
  slowMovement*: bool

var
  prevMousePoint, mousePoint: Vector2

proc movePlayer*(player: var Player) =

  mousePoint = getMousePosition()
  let deltaMouse = mousePoint - prevMousePoint
  prevMousePoint = mousePoint

  player.yaw += deltaMouse.x * mouseSensitivity
  player.pitch += deltaMouse.y * mouseSensitivity

  player.velocity = Vector3()
  if (isKeyDown(W.cint)):
    player.velocity.z += movementSpeed
  if (isKeyDown(S.cint)):
    player.velocity.z -= movementSpeed
  if (isKeyDown(D.cint)):
    player.velocity.x += movementSpeed
  if (isKeyDown(A.cint)):
    player.velocity.x -= movementSpeed
  if (isKeyDown(SPACE.cint)):
    player.velocity.y += movementSpeed
  if (isKeyDown(LEFT_ALT.cint)):
    player.velocity.y -= movementSpeed
  
  player.slowMovement = isKeyDown(LEFT_SHIFT.cint);

  if (player.slowMovement):
    player.velocity *= 0.5

  let yawQuat = fromAxisAngle(Vector3(x: 0, y: 1, z: 0), player.yaw)
  let pitchQuat = fromAxisAngle(Vector3(x: 0, y: 0, z: 1), player.pitch)

  player.position += player.velocity.rotateByQuaternion(pitchQuat * yawQuat)
