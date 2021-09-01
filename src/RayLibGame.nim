import nimraylib_now/[raylib, raymath]
import MathUtils
import Player

when isMainModule:
  type Sphere = object
    position: Vector3
    radius: cfloat
    color: Color

  const
    cameraEasingFactor: cfloat = 1.5
    cameraOffsetZ = -20
    left = Vector3(x: 1, y: 0, z: 0)
    up = Vector3(x: 0, y: 1, z: 0)
    forward = Vector3(x: 0, y: 0, z: 1)

  var
    playerCam: Camera = Camera(
      position: Vector3(x: 0, y: 0, z: -20)
      , target: Vector3(x: 0, y: 0, z: 1)
      , up: Vector3(x: 0, y: 1, z: 0)
      , fovy: 90
      , projection: cint PERSPECTIVE
    )
    player: Player
    playerSphere: Sphere = Sphere(
      position: Vector3()
      , radius: 1
      , color: Blue
    )
    deltaTime: cfloat = 0

  initWindow(800, 600, "Hello World")
  setTargetFPS(60)
  setCameraMode(playerCam, cint CameraMode.CUSTOM)

  var model = loadModel("assets/katana.obj")

  while not windowShouldClose():
    deltaTime = getFrameTime()

    player.updatePlayer()
    playerSphere.position = player.position
    
    var targetPos = playerSphere.position
    targetPos += forward * cameraOffsetZ #(Vector3(x: 0, y: 0, z: 1).rotateByQuaternion(player.getRotation())) * cameraOffsetZ
    playerCam.position += easeExpStep(playerCam.position, targetPos, cameraEasingFactor) * deltaTime
    playerCam.target = Vector3(x: playerCam.position.x, y: playerCam.position.y, z: playerCam.position.z + 1)

    beginDrawing()
    block drawing:
      clearBackground(Raywhite)
      beginMode3D(playerCam)
      block mode3d:
        drawModel(model, vector3Zero(), cfloat 0.01, White)
        drawCubeWires(left, 1, 1, 1, Red)
        drawCubeWires(up, 1, 1, 1, Green)
        drawCubeWires(forward, 1, 1, 1, Blue)
        drawLine3D(playerSphere.position, playerSphere.position + left.rotateByQuaternion(player.getRotation()) * 5, Red)
        drawLine3D(playerSphere.position, playerSphere.position + up.rotateByQuaternion(player.getRotation()) * 5, Green)
        drawLine3D(playerSphere.position, playerSphere.position + forward.rotateByQuaternion(player.getRotation()) * 5, Blue)
        drawSphere(playerSphere.position, playerSphere.radius, playerSphere.color)
      endMode3D()
      drawText("Hello world", 200, 200, 20, Lightgray)
    endDrawing()
  closeWindow()