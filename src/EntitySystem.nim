import std/[hashes]
type
  Uuid* = object
    timeLow: uint32
    timeMid: uint16
    timeHiAndVersion: uint16
    clockSeqHiAndReserved: uint8
    clockSeqLow: uint8
    node: array[6, byte]

func hash*(uuid: Uuid): Hash =
  result = uuid.timeLow.hash() !& uuid.timeMid.hash() !& uuid.timeHiAndVersion.hash() !& uuid.clockSeqHiAndReserved.hash() !& uuid.clockSeqLow.hash() !& uuid.node.hash()
  result = !$result
  