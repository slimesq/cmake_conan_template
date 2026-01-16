add_library(mylib SHARED my_lib.cpp)

include(GenerateExportHeader)
generate_export_header(mylib)

set_target_properties(mylib PROPERTIES
    CXX_VISIBILITY_PRESET hidden # 所有 C++ 符号默认"不导出",包括: 普通类/函数,仅导出显式标记 __attribute__((visibility("default")))和使用导出宏（如 FOO_EXPORT）的函数
    VISIBILITY_INLINES_HIDDEN 1 # inline 函数、模板实例默认不导出
)

target_compile_definitions(mylib PRIVATE mylib_EXPORTS)
target_include_directories(mylib PUBLIC ${PROJECT_SOURCE_DIR}/include ${CMAKE_CURRENT_BINARY_DIR})
message("CMAKE_CURRENT_BINARY_DIR = ${CMAKE_CURRENT_BINARY_DIR}")