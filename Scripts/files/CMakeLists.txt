cmake_minimum_required(VERSION 3.10)
project(Name CXX)

set(CMAKE_CXX_COMPILER g++)
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON) 

set(CMAKE_CXX_FLAGS "-Wall -Wextra -Wpedantic -O3 -march=native")
set(CMAKE_CXX_FLAGS_RELEASE "-DNDEBUG")

include_directories(include)

file(GLOB SOURCES "src/*.cpp")

add_executable(name ${SOURCES})
