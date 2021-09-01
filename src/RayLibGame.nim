import std/[tables]
import nimraylib_now/[raylib, raymath]
import MathUtils, Enemy, Player

when isMainModule:
  type Sphere = object
    position: Vector3
    radius: cfloat
    color: Color

  const
    cameraEasingFactor: cfloat = 1.5
    cameraOffsetZ = -20

  var
    playerCam: Camera = Camera(
      position: Vector3(x: 0, y: 0, z: -20)
      , target: Vector3(x: 0, y: 0, z: 1)
      , up: Vector3(x: 0, y: 1, z: 0)
      , fovy: 90
      , projection: PERSPECTIVE.cint
    )
    player: Player
    playerSphere: Sphere = Sphere(
      position: Vector3()
      , radius: 1
      , color: Blue
    )
    deltaTime: cfloat = 0

  #let model = loadModel("assets/katana.obj")

  initWindow(800, 600, "Hello World")
  setTargetFPS(60)
  setCameraMode(playerCam, CameraMode.CUSTOM.cint)

  while not windowShouldClose():
    deltaTime = getFrameTime()

    player.movePlayer()
    playerSphere.position = player.position

    var targetPos = playerSphere.position
    targetPos.z += cameraOffsetZ
    playerCam.position += easeExpStep(playerCam.position, targetPos, cameraEasingFactor) * deltaTime
    playerCam.target = Vector3(x: playerCam.position.x, y: playerCam.position.y, z: playerCam.position.z + 1)

    beginDrawing()
    block drawing:
      clearBackground(Raywhite)
      beginMode3D(playerCam)
      block mode3d:
        #drawModel(model, playerSphere.position, 1, Raywhite)
        drawSphere(playerSphere.position, playerSphere.radius, playerSphere.color)
      endMode3D()
      drawText("Hello My Darling, Hello My Baby", 200, 200, 20, Lightgray)
    endDrawing()
  closeWindow()