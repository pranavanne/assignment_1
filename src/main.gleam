import gleam/int
import gleam/io
import gleam/list
import lukas_core
import timing

pub fn main() {
  let n = 1_000_000
  // big enough to show scaling
  let k = 24
  let workers = 16
  // try 8, 12, 16; keep best
  let chunk = 10_000

  io.println(
    "n="
    <> int.to_string(n)
    <> " k="
    <> int.to_string(k)
    <> " workers="
    <> int.to_string(workers)
    <> " chunk="
    <> int.to_string(chunk),
  )

  // Get initial runtime statistics
  let #(_, _) = timing.get_runtime_info()
  let #(_, _) = timing.get_wall_clock_info()

  // Time the main computation
  let #(results, elapsed_time_ms) =
    timing.time_function(fn() { lukas_core.lukas(n, k, workers, chunk) })

  // Get final runtime statistics  
  let #(final_runtime, runtime_diff) = timing.get_runtime_info()
  let #(final_wall_clock, wall_clock_diff) = timing.get_wall_clock_info()

  // Print results
  list.each(results, fn(a) { io.println(int.to_string(a)) })

  // Print timing information
  io.println("\n=== Performance Metrics ===")
  io.println(
    "Wall clock time (total execution): "
    <> int.to_string(elapsed_time_ms)
    <> " ms",
  )
  io.println(
    "CPU runtime (process time): " <> int.to_string(runtime_diff) <> " ms",
  )
  io.println(
    "CPU time / Real time: " <> int.to_string(runtime_diff / elapsed_time_ms),
  )
}
