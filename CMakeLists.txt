# ======================================[Parameter Naming]======================================
# Arguments must be carefully passed in the caller to the defined name of the parameter.
# When used as a prefix, an underscore (_) is added after the keyword and the parameter name is written. When used alone, just write the keyword without an underscore.
#
# Keywords...
# `VAR` <- Just write the variable name in the argument
# `RET` <- It is used the same as the `VAR` keyword, and explicitly expresses that it is just a variable to receive a return value.
# `TYPE` <- For the argument, you must choose between ${CT_CONST_VARIABLE_TYPE_STRING} or ${CT_CONST_VARIABLE_TYPE_LIST} or ${CT_CONST_VARIABLE_TYPE_BOOL}. It is a keyword that means type.
#
# Non-keyword names can pass arguments as value types.

# ======================================[Cmake Constant Data]======================================
# These are data that should not be changed.

set(CMAKE_TEMPLATE_BY_TANAKADOREI "3927850208" CACHE STRING "Cmake Constant Data" FORCE)
set(CTBYTD "2439075417" CACHE STRING "Cmake Constant Data" FORCE)
set(CT "2439075417" CACHE STRING "Cmake Constant Data" FORCE)

set(CT_CONST_DOCSTRING "Cmake Constant Data" CACHE STRING "Cmake Constant Data" FORCE)

set(CT_CONST_CMAKE_VERSION "3.25" CACHE STRING ${CT_CONST_DOCSTRING} FORCE)
set(CT_CONST_ROOT_DIR_PATH ${CMAKE_CURRENT_SOURCE_DIR} CACHE STRING ${CT_CONST_DOCSTRING} FORCE)

set(CT_CONST_ERROR_TITLE "Error" CACHE STRING ${CT_CONST_DOCSTRING} FORCE)

set(CT_CONST_VARIABLE_TYPE_STRING "<:STRING:>" CACHE STRING ${CT_CONST_DOCSTRING} FORCE)
set(CT_CONST_VARIABLE_TYPE_LIST "<:LIST:>" CACHE STRING ${CT_CONST_DOCSTRING} FORCE)
set(CT_CONST_VARIABLE_TYPE_BOOL "<:BOOL:>" CACHE STRING ${CT_CONST_DOCSTRING} FORCE)

# ======================================[Options]======================================
# Command-line modification only options
set(CT_OPTION_DOCSTRING "Command-line modification-only variables" CACHE STRING "Command-line modification-only variables" FORCE)

# Maximum characters per line
set(CT_OPTION_MAX_CHARS_PER_LINE "160" CACHE STRING ${CT_OPTION_DOCSTRING} FORCE)
set(CT_OPTION_ELEMENTS_PER_LINE "5" CACHE STRING ${CT_OPTION_DOCSTRING} FORCE)

# ======================================[Cmake Header]======================================
cmake_minimum_required(VERSION ${CT_CONST_CMAKE_VERSION})

project(
	"CMAKETEMPLATE"
	VERSION
	"2023.5.11"
	DESCRIPTION
	"https://github.com/TANAKADOREI/CMakeTemplate"
)

# ======================================[Cmake Decl Functions]======================================
function(CT_GET_VARIABLE_TYPE RET VAR)
	CT_CHECK_VARIABLE(VAR)

	if("${VAR}" STREQUAL "")
		set(RET ${CT_CONST_VARIABLE_TYPE_STRING})
	elseif(NOT "${VAR}" STREQUAL "${${VAR}}")
		set(RET ${CT_CONST_VARIABLE_TYPE_LIST})
	elseif(VAR)
		set(RET ${CT_CONST_VARIABLE_TYPE_BOOL})
	else()
		CT_THROW_ERROR(${CT_CONST_ERROR_TITLE} "Variable type: UNKNOWN")
	endif()
endfunction()

function(CT_CHECK_VARIABLE_TYPE VAR TYPE)
	set(RESULT)
	CT_GET_VARIABLE_TYPE(RESULT VAR)

	if(${RESULT} STREQUAL ${TYPE})
	else()
		CT_THROW_ERROR(${CT_CONST_ERROR_TITLE} "wrong type")
	endif()
endfunction()

function(CT_LOG_WRITELINE MSG)
	message("##    ${MSG}")
endfunction()

function(CT_LOG_WRITELINE_PARTITION)
	set(temp "")

	foreach(index RANGE 1 ${CT_OPTION_MAX_CHARS_PER_LINE})
		set(temp "${temp}#")
	endforeach()

	message("${temp}")
endfunction()

function(CT_THROW_ERROR TITLE MSG)
	CT_SYSLOG_WRITELINE(${TITLE})
	CT_LOG_WRITELINE(${MSG})
	message(FATAL_ERROR)
endfunction()

function(CT_LOG_WRITELINE_LIST VAR_LIST)
	set(index 0)
	set(line "")

	list(LENGTH ${VAR_LIST} list_length)

	foreach(item IN LISTS ${VAR_LIST})
		set(truncated_item)

		set(result)
		math(EXPR result "((${CT_OPTION_MAX_CHARS_PER_LINE} - 6)/${CT_OPTION_ELEMENTS_PER_LINE}) - (${CT_OPTION_ELEMENTS_PER_LINE} * 2)")
		CT_TRUNCATE_STRING(truncated_item "${item}" ${result})

		set(line "${line}|${truncated_item}|")

		math(EXPR index "${index} + 1")

		set(result)
		math(EXPR result "${index} % ${CT_OPTION_ELEMENTS_PER_LINE}")

		if(result EQUAL 0 OR ${index} EQUAL ${list_length})
			CT_LOG_WRITELINE("${line}")
			set(line "")
		endif()
	endforeach()
endfunction()

function(CT_CHECK_VARIABLE VAR)
	if(DEFINED ${VAR})
		if(${VAR})
		# exist
		else()
			CT_THROW_ERROR(${CMAKE_CURRENT_FUNCTION} "${VAR} is empty.")
		endif()
	else()
		CT_THROW_ERROR(${CMAKE_CURRENT_FUNCTION} "${VAR} is not defined.")
	endif()
endfunction()


# ======================================[Execution Part]======================================
