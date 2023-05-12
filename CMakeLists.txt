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
set(CT_CONST_CMAKE_DATAFILE "CMakeLists.data.txt" CACHE STRING ${CT_CONST_DOCSTRING} FORCE)

set(CT_CONST_PROJECT_DIR_PATH ${CMAKE_CURRENT_SOURCE_DIR} CACHE STRING ${CT_CONST_DOCSTRING} FORCE)
set(CT_CONST_PROJECT_SPEC_DIR_PROJECTS "projects" CACHE STRING ${CT_CONST_DOCSTRING} FORCE)
set(CT_CONST_SUBPROJECT_SPEC_DIR_SRC "src" CACHE STRING ${CT_CONST_DOCSTRING} FORCE)
set(CT_CONST_SUBPROJECT_SPEC_DIR_RES "res" CACHE STRING ${CT_CONST_DOCSTRING} FORCE)
set(CT_CONST_SUBPROJECT_SPEC_DIR_INFO "inf" CACHE STRING ${CT_CONST_DOCSTRING} FORCE)

set(CT_CONST_ERROR_TITLE "Error" CACHE STRING ${CT_CONST_DOCSTRING} FORCE)

set(CT_CONST_VARIABLE_TYPE_STRING "<:STRING:>" CACHE STRING ${CT_CONST_DOCSTRING} FORCE)
set(CT_CONST_VARIABLE_TYPE_LIST "<:LIST:>" CACHE STRING ${CT_CONST_DOCSTRING} FORCE)
set(CT_CONST_VARIABLE_TYPE_BOOL "<:BOOL:>" CACHE STRING ${CT_CONST_DOCSTRING} FORCE)

set(CT_CONST_CT_LOG_WRITELINE_CHARS "8" CACHE STRING ${CT_CONST_DOCSTRING} FORCE)
set(CT_CONST_CT_LOG_WRITELINE_HEADER_CHARS "6" CACHE STRING ${CT_CONST_DOCSTRING} FORCE)
set(CT_CONST_CT_LOG_WRITELINE_FOOTER_CHARS "2" CACHE STRING ${CT_CONST_DOCSTRING} FORCE)

# ======================================[Options]======================================
# Command-line modification only options
set(CT_OPTION_DOCSTRING "Command-line modification-only variables" CACHE STRING "Command-line modification-only variables" FORCE)

# Maximum characters per line
set(CT_OPTION_MAX_CHARS_PER_LINE "20" CACHE STRING ${CT_OPTION_DOCSTRING} FORCE)
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

function(CT_THROW_ERROR MSG)
	message(">>>!SYS!<<< --> ${MSG}")
	message(FATAL_ERROR ">>>!SYS!<<<")
endfunction()

function(CT_CHECK_VARIABLE VAR)
	if(DEFINED ${VAR})
		if(${VAR})
		# exist
		else()
			CT_THROW_ERROR(${CMAKE_CURRENT_FUNCTION} "${VAR} is empty.")
		endif()
	else()
		CT_THROW_ERROR("${VAR} is not defined.")
	endif()
endfunction()

function(CT_GET_VARIABLE_TYPE RET VAR)
	CT_CHECK_VARIABLE(${VAR})
	if("${VAR}" MATCHES ";")
	set(${RET} ${CT_CONST_VARIABLE_TYPE_LIST} PARENT_SCOPE)
	elseif("${VAR}" STREQUAL "ON" OR "${VAR}" STREQUAL "OFF" OR
		"${VAR}" STREQUAL "TRUE" OR "${VAR}" STREQUAL "FALSE")
		set(${RET} ${CT_CONST_VARIABLE_TYPE_BOOL} PARENT_SCOPE)
	else()
	set(${RET} ${CT_CONST_VARIABLE_TYPE_STRING} PARENT_SCOPE)
	endif()
endfunction()

list(APPEND temp "A" "B")
set(res)
CT_GET_VARIABLE_TYPE(res temp)
message(${temp})

function(CT_CHECK_VARIABLE_TYPE VAR TYPE)
	set(RESULT)
	CT_GET_VARIABLE_TYPE(RESULT ${VAR})

	if(${RESULT} STREQUAL ${TYPE})
	else()
		CT_THROW_ERROR(${CT_CONST_ERROR_TITLE} "wrong type")
	endif()
endfunction()



function(CT_TRUNCATE_STRING RET STRING MAX_LENGTH)
	CT_CHECK_VARIABLE_TYPE(STRING ${CT_CONST_VARIABLE_TYPE_STRING})
	set(temp)
	math(EXPR temp "${CT_OPTION_MAX_CHARS_PER_LINE} - ${CT_CONST_CT_LOG_WRITELINE_CHARS}")
	set(truncated_string "${STRING}" ${temp})

	if(NOT "${truncated_string}" STREQUAL "" AND NOT "${truncated_string}" STREQUAL "..." AND NOT ${MAX_LENGTH} LESS 3)
		if(NOT ${MAX_LENGTH} LESS "${truncated_string}")
			set(truncated_string "${STRING}")
		else()
			math(EXPR truncate_length "${MAX_LENGTH} - 3")
			string(SUBSTRING "${STRING}" 0 ${truncate_length} truncated_string)
			set(truncated_string "${truncated_string}...")
		endif()
	endif()

	set(${RET} "${truncated_string}" PARENT_SCOPE)
	CT_CHECK_VARIABLE_TYPE(RET ${CT_CONST_VARIABLE_TYPE_STRING})
endfunction()

function(CT_PRINT_BUFFER_PADDING RET STRING)
	CT_CHECK_VARIABLE_TYPE(STRING ${CT_CONST_VARIABLE_TYPE_STRING})
	CT_TRUNCATE_STRING(RET STRING "${CT_OPTION_MAX_CHARS_PER_LINE} - ${CT_CONST_CT_LOG_WRITELINE_CHARS}")
	string(LENGTH ${RET} string_length)
	math(EXPR padding_length "${CT_OPTION_MAX_CHARS_PER_LINE} - ${string_length}")
	string(REPEAT " " ${padding_length} padding)
	set(${RET} "${RET}${padding}" PARENT_SCOPE)
	CT_CHECK_VARIABLE_TYPE(RET ${CT_CONST_VARIABLE_TYPE_STRING})
endfunction()

function(CT_LOG_WRITELINE MSG)
	CT_CHECK_VARIABLE_TYPE(MSG ${CT_CONST_VARIABLE_TYPE_STRING})
	CT_PRINT_BUFFER_PADDING(MSG ${MSG})
	message("##    ${MSG}##")
endfunction()

function(CT_LOG_WRITELINE_PARTITION)
	set(temp "")

	foreach(index RANGE 1 ${CT_OPTION_MAX_CHARS_PER_LINE})
		set(temp "${temp}#")
	endforeach()

	message("${temp}")
endfunction()

function(CT_LOG_WRITELINE_LIST VAR_LIST)
	set(index 0)
	set(line "")

	list(LENGTH ${VAR_LIST} list_length)

	foreach(item IN LISTS ${VAR_LIST})
		set(truncated_item)

		set(result)
		math(EXPR result "((${CT_OPTION_MAX_CHARS_PER_LINE} - ${CT_CONST_CT_LOG_WRITELINE_CHARS})/${CT_OPTION_ELEMENTS_PER_LINE}) - (${CT_OPTION_ELEMENTS_PER_LINE} * 2)")
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

function(CT_EXTRACT_MATCHING_STRINGS RET SOURCE_STRING PATTERN)
	string(REGEX MATCHALL ${PATTERN} matched_strings ${SOURCE_STRING})

	if(NOT matched_strings)
		CT_THROW_ERROR("No contents matching the pattern were found.")
	else()
		set(${RET} ${matched_strings} PARENT_SCOPE)
	endif()
endfunction()

function(CT_READ_TEXTFILE RET FILE_PATH)
	file(READ ${FILE_PATH} file_content)
	set(${RET} "${file_content}" PARENT_SCOPE)
	CT_LOG_WRITELINE("The content of ${FILE_PATH} has been read.")
endfunction()

function(CT_WRITE_TEXTFILE FILE_PATH CONTENTS)
	file(WRITE ${FILE_PATH} ${CONTENTS})
	CT_LOG_WRITELINE("The file ${FILE_PATH} has been created.")
endfunction()

function(CT_EXISTS_DIR RET DIR_PATH)
	if(EXISTS "${DIR_PATH}")
		set(${RET} TRUE PARENT_SCOPE)
	else()
		set(${RET} FALSE PARENT_SCOPE)
	endif()
endfunction()

function(CT_IF_EXISTS_DIR_THROW DIR_PATH)
	set(ret)
	CT_EXISTS_DIR(ret ${DIR_PATH})

	if(${RET})
		CT_THROW_ERROR(${CT_CONST_ERROR_TITLE} "Directory `${DIR_PATH}` already exists")
	endif()
endfunction()

function(CT_NIF_EXISTS_DIR_THROW DIR_PATH)
	set(ret)
	CT_EXISTS_DIR(ret ${DIR_PATH})

	if(NOT ${RET})
		CT_THROW_ERROR(${CT_CONST_ERROR_TITLE} "Directory `${DIR_PATH}` already exists")
	endif()
endfunction()

function(CT_CREATE_PROJECT NAME)
	set(path "${CT_CONST_PROJECT_DIR_PATH}/${NAME}")
	CT_IF_EXISTS_DIR_THROW(${path})
	file(MAKE_DIRECTORY ${path})
	file(MAKE_DIRECTORY "${path}/${CT_CONST_PROJECT_SPEC_DIR_PROJECTS}")
	CT_WRITE_TEXTFILE("${CT_CONST_PROJECT_DIR_PATH}/${CT_CONST_CMAKE_DATAFILE}" "${NAME}")
endfunction()

function(CT_GET_PROJECT_NAME RET)
	CT_READ_TEXTFILE(${RET} "${CT_CONST_PROJECT_DIR_PATH}/${CT_CONST_CMAKE_DATAFILE}")
endfunction()

function(CT_CREATE_SUBPROJECT NAME)
	set(project_name)
	CT_GET_PROJECT_NAME(project_name)
	set(path "${project_name}/${NAME}")
	CT_IF_EXISTS_DIR_THROW(${path})
	file(MAKE_DIRECTORY "${path}")
	file(MAKE_DIRECTORY "${path}/${CT_CONST_SUBPROJECT_SPEC_DIR_SRC}")
	file(MAKE_DIRECTORY "${path}/${CT_CONST_SUBPROJECT_SPEC_DIR_RES}")
	file(MAKE_DIRECTORY "${path}/${CT_CONST_SUBPROJECT_SPEC_DIR_INF}")
endfunction()

function(CT_FIND_TEXTFILES output_list)
	set(search_dir "${CMAKE_CURRENT_SOURCE_DIR}/Projects")
	set(glob_expression "${search_dir}/**/*.txt")

	file(GLOB_RECURSE text_files ${glob_expression})

	if(NOT text_files)
		CT_LOG_WRITELINE("No text files were found in ${search_dir} or its subdirectories.")
	else()
		list(APPEND ${output_list} ${text_files})
		CT_LOG_WRITELINE("The following text files were found:")

		foreach(file ${text_files})
			CT_LOG_WRITELINE("  ${file}")
		endforeach()
	endif()
endfunction()

# ======================================[Execution Part]======================================
# CT_CREATE_PROJECT("MyProject")
function(PASS2 VAR_2)
	message(${VAR_2})
endfunction()

function(PASS1 VAR_1)
	PASS2(${VAR_1})
endfunction()

set(VAR_0 "VAR DATA")
PASS1(VAR_0)
