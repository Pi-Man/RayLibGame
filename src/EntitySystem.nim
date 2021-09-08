type
  Uuid = object
    timeLow: uint32
    timeMid: uint16
    timeHiAndVersion: uint16
    clockSeqHiAndReserved: uint8
    clockSeqLow: uint8
    node: array[6, byte]