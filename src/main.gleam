import gleam/int
import gleam/io
import gleam/list
import lukas_core
import timing

pub fn main() {
  let n = 1_000_000
  
  let k = 4
  let workers = n/3
  
  let chunk = 600

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

}
