# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.16

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/ash/cache_proj/cpp

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/ash/cache_proj/cpp/build

# Include any dependencies generated for this target.
include CMakeFiles/cache_proj.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/cache_proj.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/cache_proj.dir/flags.make

CMakeFiles/cache_proj.dir/cache_temp.cpp.o: CMakeFiles/cache_proj.dir/flags.make
CMakeFiles/cache_proj.dir/cache_temp.cpp.o: ../cache_temp.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/ash/cache_proj/cpp/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/cache_proj.dir/cache_temp.cpp.o"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/cache_proj.dir/cache_temp.cpp.o -c /home/ash/cache_proj/cpp/cache_temp.cpp

CMakeFiles/cache_proj.dir/cache_temp.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/cache_proj.dir/cache_temp.cpp.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/ash/cache_proj/cpp/cache_temp.cpp > CMakeFiles/cache_proj.dir/cache_temp.cpp.i

CMakeFiles/cache_proj.dir/cache_temp.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/cache_proj.dir/cache_temp.cpp.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/ash/cache_proj/cpp/cache_temp.cpp -o CMakeFiles/cache_proj.dir/cache_temp.cpp.s

# Object files for target cache_proj
cache_proj_OBJECTS = \
"CMakeFiles/cache_proj.dir/cache_temp.cpp.o"

# External object files for target cache_proj
cache_proj_EXTERNAL_OBJECTS =

cache_proj: CMakeFiles/cache_proj.dir/cache_temp.cpp.o
cache_proj: CMakeFiles/cache_proj.dir/build.make
cache_proj: /usr/local/lib/libbenchmark.a
cache_proj: /usr/lib/x86_64-linux-gnu/librt.so
cache_proj: CMakeFiles/cache_proj.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/ash/cache_proj/cpp/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable cache_proj"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/cache_proj.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/cache_proj.dir/build: cache_proj

.PHONY : CMakeFiles/cache_proj.dir/build

CMakeFiles/cache_proj.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/cache_proj.dir/cmake_clean.cmake
.PHONY : CMakeFiles/cache_proj.dir/clean

CMakeFiles/cache_proj.dir/depend:
	cd /home/ash/cache_proj/cpp/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/ash/cache_proj/cpp /home/ash/cache_proj/cpp /home/ash/cache_proj/cpp/build /home/ash/cache_proj/cpp/build /home/ash/cache_proj/cpp/build/CMakeFiles/cache_proj.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/cache_proj.dir/depend

