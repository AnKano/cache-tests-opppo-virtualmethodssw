# Some CPU Cache Benchmarks

##### Node.JS
 - Only CPU cache size benchmark (just see the maximal margin between two values)
##### C++
 - CPU cache size benchmark
 - CPU cache associative cache benchmark

### How to use it
Node.JS benchmark requires [Node.js](https://nodejs.org/) to run. It was tested on v10.19.0.

```sh
$ cd nodejs
$ node test.js
```


C++ benchmarks requires [Google/Benchmark](https://github.com/google/benchmark) that requested on cmake build. Build the google-benchmark libs on release mode for reducing noises.

```sh
$ cd cpp
$ sudo cpupower frequency-set --governor performance # set cpu performance mode for more accurate results
$ cmake -DCMAKE_BUILD_TYPE=Release # build it locally on release mode
$ make && ./cache_proj # make bin and run it
```

