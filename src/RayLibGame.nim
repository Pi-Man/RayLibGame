import nimraylib_now/[raylib]

when isMainModule:
  type Sphere = object
    position: Vector3
    radius: cfloat
    color: Color

  var
    playerCam: Camera = Camera(
      position: Vector3(x: 0, y: 0, z: -20)
      , target: Vector3(x: 0, y: 0, z: 0)
      , up: Vector3(x: 0, y: 1, z: 0)
      , fovy: 90
      , `type`: PERSPECTIVE
    )
    playerSphere: Sphere = Sphere(
      position: Vector3()
      , radius: 1
      , color: Blue
    )

  initWindow(800, 600, "Hello World")
  setTargetFPS(60)
  setCameraMode(playerCam, CameraMode.CUSTOM)

  while not windowShouldClose():
    beginDrawing()
    block drawing:
      clearBackground(Raywhite)
      beginMode3D(playerCam)
      block mode3d:
        # drawCube(
        #   Vector3(x: 0, y: 0, z: 0)
        #   , 10, 10, 10
        #   , Red
        # )
        drawSphere(playerSphere.position, playerSphere.radius, playerSphere.color)
      endMode3D()
      drawText("Hello world", 200, 200, 20, Lightgray)
    endDrawing()
  closeWindow()