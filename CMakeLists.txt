cmake_minimum_required(VERSION 3.18)
project(PSWF LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

option(BUILD_TESTS "Build tests" ON)
option(BUILD_EXAMPLES "Build examples" OFF)

if (CMAKE_CXX_COMPILER_ID MATCHES "Intel")
  add_compile_options("-DSCTL_HAVE_SVML")
else()
  add_compile_options("-DSCTL_HAVE_LIBMVEC")
endif()

add_compile_options("-march=native")
add_compile_options("-O3")

find_package(BLAS REQUIRED)
find_package(LAPACK REQUIRED)

if(BUILD_TESTS)
    include(FetchContent)
    FetchContent_Declare(
        googletest
        URL https://github.com/google/googletest/archive/03597a01ee50ed33e9dfd640b249b4be3799d395.zip
        DOWNLOAD_EXTRACT_TIMESTAMP TRUE
    )
    # For Windows: Prevent overriding the parent project's compiler/linker settings
    set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)
    FetchContent_MakeAvailable(googletest)
endif()

set(INCLUDES
  ${PROJECT_SOURCE_DIR}/include
)

set(SRC ${PROJECT_SOURCE_DIR}/src/pswf.cpp)

add_library(OBJS OBJECT ${SRC})
set_target_properties(OBJS PROPERTIES POSITION_INDEPENDENT_CODE ON)
target_include_directories(OBJS PUBLIC ${INCLUDES})
target_link_libraries(OBJS PUBLIC BLAS::BLAS LAPACK::LAPACK)

add_library(${PROJECT_NAME} STATIC)
target_link_libraries(${PROJECT_NAME} OBJS BLAS::BLAS LAPACK::LAPACK)

add_library(${PROJECT_NAME}_shared SHARED)
set_target_properties(${PROJECT_NAME}_shared PROPERTIES OUTPUT_NAME ${PROJECT_NAME})
target_link_libraries(${PROJECT_NAME}_shared OBJS BLAS::BLAS LAPACK::LAPACK)

if(BUILD_TESTS)
    enable_testing()
    set(TEST_SRC ${PROJECT_SOURCE_DIR}/test/pswf_test.cpp)

    add_executable(
        ${PROJECT_NAME}_test
        ${TEST_SRC}
    )
    target_link_libraries(
        ${PROJECT_NAME}_test
        GTest::gtest_main
        ${PROJECT_NAME}_shared
    )

    include(GoogleTest)
    gtest_discover_tests(${PROJECT_NAME}_test)
endif()