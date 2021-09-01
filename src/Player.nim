import nimraylib_now/[raylib, raymath]

const 
  movementSpeed: cfloat = 1.0
  mouseSensitivity: cfloat = 1.0
  pi: cfloat = 3.141592653589793238462643383279502

type Player* = object
  position*: Vector3
  yaw*, pitch*: cfloat
  velocity*: Vector3
  slowMovement*: bool

var
  prevMousePoint, mousePoint: Vector2

func getRotation*(player: Player): Quaternion =
  let yawQuat = fromAxisAngle(Vector3(x: 0, y: 1, z: 0), player.yaw)
  let pitchQuat = fromAxisAngle(Vector3(x: 1, y: 0, z: 0), player.pitch)
  result = yawQuat * pitchQuat

proc updatePlayer*(player: var Player) =

  mousePoint = getMousePosition()
  let deltaMouse = mousePoint - prevMousePoint
  prevMousePoint = mousePoint

  player.yaw += -deltaMouse.x * mouseSensitivity / 100
  player.pitch += deltaMouse.y * mouseSensitivity / 100

  if (player.pitch > pi/2):
    player.pitch = pi/2
  elif (player.pitch < -pi/2):
    player.pitch = -pi/2

  player.velocity = Vector3()
  if (isKeyDown(cint W)):
    player.velocity.z += movementSpeed
  if (isKeyDown(cint S)):
    player.velocity.z -= movementSpeed
  if (isKeyDown(cint A)):
    player.velocity.x += movementSpeed
  if (isKeyDown(cint D)):
    player.velocity.x -= movementSpeed
  if (isKeyDown(cint SPACE)):
    player.velocity.y += movementSpeed
  if (isKeyDown(cint LEFT_ALT)):
    player.velocity.y -= movementSpeed
  
  player.slowMovement = isKeyDown(cint LEFT_SHIFT);

  if (player.slowMovement):
    player.velocity *= 0.5

  player.position += player.velocity.rotateByQuaternion(player.getRotation())
