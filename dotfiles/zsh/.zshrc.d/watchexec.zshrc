# Adds a convenience function to execute watchexec.
we() {
  # Appends sleep because _sometimes_ changes _during_ an execution aren't observed until _after_ execution completes.
  # Example: Running mvn compile causes spotless to generate formatting changes. watchexec sees the changes _after_ compile, which causes watchexec to run again. The small sleep + do-nothing prevents a 2nd run.
  watchexec --on-busy-update=do-nothing "${@} && sleep 0.05"
}
