file(GLOB_RECURSE PRE_SOURCES
        "${CMAKE_SOURCE_DIR}/test/utils/*.cpp")

find_package(GTest REQUIRED)

add_executable(test_mylib ${PRE_SOURCES} test_mylib.cpp)

target_link_libraries(test_mylib PRIVATE
        mylib
        GTest::gtest
        GTest::Main
)

target_include_directories(test_mylib PRIVATE ${CMAKE_SOURCE_DIR}/test/utils)

get_target_property(GTEST_INCLUDE_DIRS GTest::gtest_main INTERFACE_INCLUDE_DIRECTORIES)
message(STATUS "GTest include dirs: ${GTEST_INCLUDE_DIRS}")

enable_testing()