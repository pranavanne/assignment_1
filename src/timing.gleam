// External functions to access Erlang's timing capabilities
@external(erlang, "erlang", "monotonic_time")
fn erlang_monotonic_time(unit: TimeUnit) -> Int

@external(erlang, "erlang", "system_time")
fn erlang_system_time(unit: TimeUnit) -> Int

@external(erlang, "erlang", "statistics")
fn erlang_statistics(item: StatisticsItem) -> #(Int, Int)

// Time units supported by Erlang
pub type TimeUnit {
  Microsecond
  Millisecond
  Nanosecond
  Second
}

// Statistics items
pub type StatisticsItem {
  Runtime
  WallClock
}

/// Get the current monotonic time (useful for measuring elapsed time)
pub fn monotonic_time(unit: TimeUnit) -> Int {
  erlang_monotonic_time(unit)
}

/// Get the current system time
pub fn system_time(unit: TimeUnit) -> Int {
  erlang_system_time(unit)
}

/// Get runtime statistics - returns {Total_Runtime, Runtime_Since_Last_Call}
pub fn runtime_statistics() -> #(Int, Int) {
  erlang_statistics(Runtime)
}

/// Get wall clock statistics - returns {Total_Wall_Clock, Wall_Clock_Since_Last_Call}  
pub fn wall_clock_statistics() -> #(Int, Int) {
  erlang_statistics(WallClock)
}

/// Measure the execution time of a function in milliseconds
/// Returns #(result, elapsed_time_ms)
pub fn time_function(func: fn() -> a) -> #(a, Int) {
  let start = monotonic_time(Millisecond)
  let result = func()
  let end = monotonic_time(Millisecond)
  #(result, end - start)
}

/// Measure the execution time of a function in microseconds
/// Returns #(result, elapsed_time_us)
pub fn time_function_microseconds(func: fn() -> a) -> #(a, Int) {
  let start = monotonic_time(Microsecond)
  let result = func()
  let end = monotonic_time(Microsecond)
  #(result, end - start)
}

/// Get CPU runtime information
/// Returns the total runtime and runtime since last call in milliseconds
pub fn get_runtime_info() -> #(Int, Int) {
  runtime_statistics()
}

/// Get wall clock information  
/// Returns the total wall clock time and time since last call in milliseconds
pub fn get_wall_clock_info() -> #(Int, Int) {
  wall_clock_statistics()
}
