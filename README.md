# To run code
```sh
gleam deps download
gleam build
gleam run -m main # running program for lukas 1,000,000 4
gleam run -m quick_test #  running program to check lukas 10,000,000 4 with different chunk sizes.
gleam run -m largest_problem # running the largest program solved
```

After extensive testing with multiple chunk sizes, we determined that **chunk size 10,000** provides the best overall performance for our implementation. The testing was conducted using the `quick_test.gleam` module, which benchmarks different chunk sizes and measures both wall clock time and CPU utilization.

**Testing methodology:**
- Tested chunk sizes: 1,000, 5,000, 10,000, 25,000, 50,000, 75,000, 100,000, 150,000, and 200,000
- Each test measured wall clock time, CPU time, and CPU/Wall ratio
- Multiple runs were performed to ensure consistent results

**Key findings:**
- **Chunk size 10,000**: Optimal performance with best wall clock time
- **Chunk sizes 25,000, 50,000, and 75,000**: Delivered almost similar performance to the optimal size
- Larger chunk sizes (100,000+): Showed diminishing returns and slightly worse performance

The result of running your program for lukas 1000000 4:
n=1000000 k=24 workers=16 chunk=10000
1
9
20
25
44
76
121
197
304
353
540
856
1301
2053
3112
3597
5448
8576
12981
20425
30908
35709
54032
84996
128601
202289
306060
353585
534964
841476

=== Performance Metrics ===
Wall clock time (total execution): 30 ms
CPU runtime (process time): 156 ms
CPU time / Real time: 5

The ratio of CPU TIME to REAL TIME: 5

The largest problem solved - lukas 100,000,000 24