discard """
# What actions to expect completion on.
# Options:
#   "compile": expect successful compilation
#   "run": expect successful compilation and execution
#   "reject": expect failed compilation. The "reject" action can catch
#             {.error.} pragmas but not {.fatal.} pragmas because
#             {.fatal.} pragmas guarantee that compilation will be aborted.
action: "run"

# The exit code that the test is expected to return. Typically, the default
# value of 0 is fine. Note that if the test will be run by valgrind, then
# the test will exit with either a code of 0 on success or 1 on failure.
exitcode: 0

# Can be run in batch mode, or not.
batchable: true

# Can be run Joined with other tests to run all togheter, or not.
joinable: true

# On Linux 64-bit machines, whether to use Valgrind to check for bad memory
# accesses or memory leaks. On other architectures, the test will be run
# as-is, without Valgrind.
# Options:
#   true: run the test with Valgrind
#   false: run the without Valgrind
#   "leaks": run the test with Valgrind, but do not check for memory leaks
valgrind: false   # Can use Valgrind to check for memory leaks, or not (Linux 64Bit only).

# Targets to run the test into (C, C++, JavaScript, etc).
target: "c"

# Conditions that will skip this test. Use of multiple "disabled" clauses
# is permitted.
#disabled: true    # ...or can disable the test entirely

"""
proc myTest =
  assert true, "Some test"
  echo "hello world"
  assert false, "My Assertion"
  echo "hello world 2"
  assert true, "Some test 2"
myTest()