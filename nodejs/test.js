(function () {
  var NUM_ACCESSES = (1 << 21);
  var MIN_ARRAY_SIZE = 1024;
  var SIZE_MAGNITUDE = 16;
  var MIN_STRIDE = 64;
  var STRIDES_MAGNITUDE = 8;

  var microtime;
  if (typeof performance !== "undefined" && typeof performance.now !== "undefined") {
    microtime = performance.now.bind(performance);
  } else {
    microtime = Date.now.bind(Date);
    NUM_ACCESSES *= 8;
  }

  function measure_inner(array, array_size, stride) {
    var rounds = Math.ceil(NUM_ACCESSES / (array_size / stride));

    var start = microtime();

    for (i = 0; i < 100; i++) {
      var i = 0, p = 0;
      while (true) {
        p = array[p];
        p = array[p];
        p = array[p];
        p = array[p];
        if (p === 0) {
          i += 1;
          if (i === rounds) {
            break;
          }
        }
      }
    }
    var end = microtime();

    var total_time = end - start;

    return total_time / (rounds * (array_size / stride));
  }

  function setup_array(array, array_size, stride) {
    var step = (((array_size / stride * 0.61803398875) | 1) * stride) | 0;

    var i, current, next;

    for (i = 0; i < array_size / 4; i += 1) {
      array[i] = 0;
    }

    current = 0;
    for (i = 0; i < array_size; i += stride) {
      next = (current + step) % array_size;
      array[current / 4] = next / 4;
      current = next;
    }

    console.assert(current === 0, "Didn't generate?");

    for (i = 0; i < array_size / 4; i += 1) {
      array[i] |= 0;
    }
  }
  function measure(measurement_array, array_size, stride) {
    var i = 0, best = 0, m;

    console.assert(array_size <= measurement_array.length * 4, "Weird size");
    console.assert((array_size / stride) % 4 === 0, "Didn't meet unroll precondition");

    setup_array(measurement_array, array_size, stride);
    for (i = 0; i < 4; i += 1) {
      m = measure_inner(measurement_array, array_size, stride);
      if (best === 0 || m < best) {
        best = m;
      }
    }
    return best;
  }

  function measure_all() {
    var measurement_array = new Int32Array((MIN_ARRAY_SIZE * (1 << SIZE_MAGNITUDE)) / 4);

    var results = new Float64Array(SIZE_MAGNITUDE * STRIDES_MAGNITUDE);
    var cache_time, stride, as, i, j;

    for (i = 0; i < SIZE_MAGNITUDE / 2; i += 1) {
      measure(measurement_array, MIN_ARRAY_SIZE * (1 << i), 8);
    }

    for (i = 0; i < SIZE_MAGNITUDE; i += 1) {
      as = MIN_ARRAY_SIZE * (1 << i);
      stride = MIN_STRIDE * (1 << j);
      if (stride * 2 < as) {
        cache_time = measure(measurement_array, as, stride);
      } else {
        cache_time = NaN;
      }
      console.log({ "time": cache_time * 1e6 * 100, "stride": stride, "size": as});
      results[i * STRIDES_MAGNITUDE + j] = cache_time;
    }

    measurement_array = null;
  }

  measure_all();
})();
