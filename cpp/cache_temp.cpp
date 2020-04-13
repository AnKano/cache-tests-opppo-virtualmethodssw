#include <benchmark/benchmark.h>
#include <stdalign.h>
#include <string.h>
#include <atomic>

static void BM_AllocateToCache(benchmark::State &state)
{
    // Get from benchmark args length of allocating memory 
    const uint64_t length = state.range(0);
    // Set step size constant (64 bytes)
    const uint64_t step = 64;

    // Allocate array and init it 
    uint8_t *array = new uint8_t[length]();
    // Set all bytes to 0x00
    memset(array, 0, length);

    // 4 byte temporary variable for reading add attaching data from cpu cache
    uint32_t temp = 0;
    for (auto _ : state)
        // Make 10k times for more accurate result
        for (uint16_t rep = 0; rep < 10000; rep++)
            // Each time add to offset 256 bytes (+ line)
            for (uint64_t i = 0; i < length; i += (step * 4))
            {
                // Read whole cache line
                benchmark::DoNotOptimize(temp = array[i]);
                benchmark::DoNotOptimize(temp = array[i + step]);
                benchmark::DoNotOptimize(temp = array[i + step * 2]);
                benchmark::DoNotOptimize(temp = array[i + step * 3]);
            }

    state.SetBytesProcessed(int64_t(state.iterations()) * int64_t(length) * int64_t(10000));
    delete[] array;
}
BENCHMARK(BM_AllocateToCache)->RangeMultiplier(2)->Range(1 << 8, 1 << 24);
BENCHMARK(BM_AllocateToCache)->RangeMultiplier(2)->Range(1 << 8, 1 << 24)->Threads(4);

static void BM_AllocateChainCache(benchmark::State &state)
{
    // We must read only 1mb from RAM
    const uint64_t bytes_to_read = 1024 * 1024;
    // Load padding from args  
    const uint64_t step = state.range(0);

    // Create 32mb array and init it 
    uint8_t* array = new uint8_t[32 * bytes_to_read]();
    // Set all bytes to 0x00
    memset(array, 0, 32 * bytes_to_read);
    
    // Temporary variable for assigning
    uint32_t temp = 0;
    for (auto _ : state)
        for (auto rep = 0; rep < 10000; rep++)
        {
            uint64_t bytes_read = 0;
            for (uint8_t* ptr = array; bytes_read < bytes_to_read; ptr += (4 * step))
            {
                // Read whole entire cache line
                benchmark::DoNotOptimize(temp = *ptr);
                benchmark::DoNotOptimize(temp = *(ptr + step));
                benchmark::DoNotOptimize(temp = *(ptr + 2 * step));
                benchmark::DoNotOptimize(temp = *(ptr + 3 * step));
                // Add to readed bytes whole cache line size
                bytes_read += 4 * 64;
            }
        }

    state.SetBytesProcessed(int64_t(state.iterations()) * int64_t(bytes_to_read) * int64_t(10000));
}
BENCHMARK(BM_AllocateChainCache)->DenseRange(64, 1024, 64);

struct Mixed {
    uint8_t warmData;
    uint8_t coldData[63];
};

struct SplitWarm {
    uint8_t warmData;
};

struct SplitCold {
    uint8_t coldData;
};

static void BM_AllocateNonAlignedData(benchmark::State &state)
{
    const uint64_t length = state.range(0);

    Mixed *array = new Mixed[length]();
    memset(array, 0, sizeof(Mixed) * length);

    uint8_t temp;
    for (auto _ : state)
        for (uint16_t rep = 0; rep < 10000; rep++)
            for (uint64_t i = 0; i < length; i++)
            {
                benchmark::DoNotOptimize(temp = array[i].warmData);
            }

    state.SetBytesProcessed(int64_t(state.iterations()) * int64_t(sizeof(Mixed) * length) * int64_t(10000));
    delete[] array;
}
BENCHMARK(BM_AllocateNonAlignedData)->Arg(1 << 16);

static void BM_AllocateAlignedData(benchmark::State &state)
{
    const uint64_t length = state.range(0);

    SplitCold *array = new SplitCold[length]();
    SplitWarm *array2 = new SplitWarm[length]();
    memset(array, 0, sizeof(SplitCold) * length);
    memset(array2, 0, sizeof(SplitWarm) * length);

    uint8_t temp;
    for (auto _ : state)
        for (uint16_t rep = 0; rep < 10000; rep++)
            for (uint64_t i = 0; i < length; i++)
            {
                benchmark::DoNotOptimize(temp = array2[i].warmData);
            }

    state.SetBytesProcessed(int64_t(state.iterations()) * int64_t(sizeof(SplitWarm) * length) * int64_t(10000));
    delete[] array;
}
BENCHMARK(BM_AllocateAlignedData)->Arg(1 << 16);

BENCHMARK_MAIN();
