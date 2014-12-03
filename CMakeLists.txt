cmake_minimum_required(VERSION 2.8 FATAL_ERROR)

project(CMake-tutorials NONE)

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${PROJECT_SOURCE_DIR}/rst2pdf)

find_package(RST2PDF REQUIRED)

foreach(talk
    mma
    )
    add_custom_command(
        OUTPUT ${PROJECT_BINARY_DIR}/${talk}.pdf
        COMMAND ${RST2PDF_COMMAND}
        ARGS -b 1 -s ${PROJECT_SOURCE_DIR}/rst2pdf/slides --fit-background-mode='scale' ${PROJECT_SOURCE_DIR}/${talk}.rst -o ${PROJECT_BINARY_DIR}/${talk}.pdf
        WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}
        DEPENDS ${PROJECT_SOURCE_DIR}/${talk}.rst
        )

    add_custom_target(
        generate_${talk} ALL
        DEPENDS ${PROJECT_BINARY_DIR}/${talk}.pdf
        )
endforeach()
