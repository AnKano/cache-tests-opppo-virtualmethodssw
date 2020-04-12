cmake_minimum_required(VERSION 3.0)

project(cache_proj)
set (SOURCE cache_temp.cpp)
add_executable(${PROJECT_NAME} ${SOURCE})

find_package(GTest REQUIRED)
include_directories(${GTEST_INCLUDE_DIRS})

find_package(benchmark REQUIRED)
target_link_libraries(${PROJECT_NAME} PRIVATE benchmark::benchmark)
