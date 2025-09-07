import gleam/int
import gleam/io
import gleam/list
import lukas_core
import timing

pub fn test_chunk_size(chunk: Int) -> Nil {
  let n = 10_000_000
  let k = 24
  let workers = 16

  io.println("Testing chunk size: " <> int.to_string(chunk))

  // Reset and run benchmark
  let #(_, _) = timing.get_runtime_info()
  let #(_, _) = timing.get_wall_clock_info()

  let #(results, wall_time) =
    timing.time_function(fn() { lukas_core.lukas(n, k, workers, chunk) })

  let #(_, cpu_time) = timing.get_runtime_info()
  let ratio = cpu_time / wall_time

  io.println("Results:")
  io.println("  Wall time: " <> int.to_string(wall_time) <> " ms")
  io.println("  CPU time: " <> int.to_string(cpu_time) <> " ms")
  io.println("  CPU/Wall ratio: " <> int.to_string(ratio))
  io.println("  Result count: " <> int.to_string(list.length(results)))
  io.println("")
}

pub fn main() {
  io.println("=== Quick Chunk Size Test ===")
  io.println("Testing different chunk sizes...\n")

  // Test a few key chunk sizes
  test_chunk_size(1000)
  test_chunk_size(5000)
  test_chunk_size(10_000)
  test_chunk_size(25_000)
  test_chunk_size(50_000)
  test_chunk_size(75_000)
  test_chunk_size(100_000)
  test_chunk_size(150_000)
  test_chunk_size(200_000)
}
