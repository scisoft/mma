# Author:
#     Radovan Bast <lastname at kth dot se>

# The module defines the following variables:
#     RST2PDF_COMMAND - path to rst2pdf
#     RST2PDF_FOUND   - true if rst2pdf found

# Example usage:
#     find_package(RST2PDF)
#     if(RST2PDF_FOUND)
#         message("rst2pdf found: ${RST2PDF_COMMAND}")
#     else()
#         message(FATAL_ERROR "rst2pdf not found")
#     endif()

find_program(
    RST2PDF_COMMAND
    NAMES rst2pdf
    DOC "rst2pdf"
    )

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(RST2PDF DEFAULT_MSG RST2PDF_COMMAND)
