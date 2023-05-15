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
set(CT_CONST_CMAKE_DATAFILE "CMakeLists.datatext" CACHE STRING ${CT_CONST_DOCSTRING} FORCE)

set(CT_CONST_CUR_SCRIPT_PATH ${CMAKE_CURRENT_SOURCE_DIR} CACHE STRING ${CT_CONST_DOCSTRING} FORCE)
set(CT_CONST_SUBPROJECT_SPEC_DIR_SRC "src" CACHE STRING ${CT_CONST_DOCSTRING} FORCE)
set(CT_CONST_SUBPROJECT_SPEC_DIR_RES "res" CACHE STRING ${CT_CONST_DOCSTRING} FORCE)
set(CT_CONST_SUBPROJECT_SPEC_DIR_INFO "inf" CACHE STRING ${CT_CONST_DOCSTRING} FORCE)

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
set(CT_OPTION_MAX_CHARS_PER_LINE "100" CACHE STRING ${CT_OPTION_DOCSTRING} FORCE)
set(CT_OPTION_ELEMENTS_PER_LINE "4" CACHE STRING ${CT_OPTION_DOCSTRING} FORCE)
set(CT_OPTION_INNER_TESTER_SET_ENABLE FALSE CACHE BOOL ${CT_OPTION_DOCSTRING} FORCE)

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

#
function(CT_THROW_ERROR MSG)
	message(">>>!SYS!<<< --> ${MSG}")
	message(FATAL_ERROR ">>>!SYS!<<<")
endfunction()

#
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

# testertestertestertestertestertestertestertestertestertester
# ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
if(${CT_OPTION_INNER_TESTER_SET_ENABLE})
	set(ct_function_tester_parameter0 "123456789012345678901234567890")
	CT_CHECK_VARIABLE(ct_function_tester_parameter0)
	message("[TESTER] : CT_CHECK_VARIABLE(ct_function_tester_parameter0)")
endif()

# ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
# testertestertestertestertestertestertestertestertestertester

#
function(CT_TRUNCATE_STRING RET STRING MAX_LENGTH)
	string(LENGTH ${STRING} string_length)
	math(EXPR remain_length "${MAX_LENGTH} - ${string_length}")
	set(truncated_string)

	if(0 GREATER ${remain_length}) # 0 >
		math(EXPR truncate_length "${string_length} + ${remain_length} - 3")
		string(SUBSTRING "${STRING}" "0" ${truncate_length} truncated_string)
		set(truncated_string "${truncated_string}...")
	else() # 0 >=
		set(truncated_string ${STRING})
	endif()

	set(${RET} "${truncated_string}" PARENT_SCOPE)
endfunction()

# testertestertestertestertestertestertestertestertestertester
# ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
if(${CT_OPTION_INNER_TESTER_SET_ENABLE})
	set(ct_function_tester_parameter0 "123456789012345678901234567890")
	set(ct_function_tester_return_value)
	CT_TRUNCATE_STRING(ct_function_tester_return_value ${ct_function_tester_parameter0} "10")

	message("[TESTER] : ${ct_function_tester_return_value} = CT_TRUNCATE_STRING(ct_function_tester_return_value ${ct_function_tester_parameter0} \"10\")")
endif()

if(${CT_OPTION_INNER_TESTER_SET_ENABLE})
	set(ct_function_tester_parameter0 "123")
	set(ct_function_tester_return_value)
	CT_TRUNCATE_STRING(ct_function_tester_return_value ${ct_function_tester_parameter0} "10")

	message("[TESTER] : ${ct_function_tester_return_value} = CT_TRUNCATE_STRING(ct_function_tester_return_value ${ct_function_tester_parameter0} \"10\")")
endif()

# ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
# testertestertestertestertestertestertestertestertestertester

#
function(CT_STRING_BACK_PADDING RET STRING MAX_LENGTH)
	CT_TRUNCATE_STRING(truncated_string ${STRING} ${MAX_LENGTH})
	string(LENGTH ${truncated_string} string_length)

	set(padding_size)
	math(EXPR padding_size "${MAX_LENGTH} - ${string_length}")

	if(${padding_size} GREATER "0")
		math(EXPR padding_size "${padding_size}-1")

		foreach(_ RANGE 0 ${padding_size})
			set(truncated_string "${truncated_string} ")
		endforeach()
	endif()

	set(${RET} ${truncated_string} PARENT_SCOPE)
endfunction()

# testertestertestertestertestertestertestertestertestertester
# ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
if(${CT_OPTION_INNER_TESTER_SET_ENABLE})
	set(ct_function_tester_parameter0 "1234")
	set(ct_function_tester_return_value)
	CT_STRING_BACK_PADDING(ct_function_tester_return_value ${ct_function_tester_parameter0} "10")

	message("[TESTER] : ${ct_function_tester_return_value} = CT_STRING_BACK_PADDING(ct_function_tester_return_value ${ct_function_tester_parameter0} \"10\")")
endif()

# ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
# testertestertestertestertestertestertestertestertestertester

#
function(CT_WRITELINE_MSG_AUTO_PADDING RET STRING)
	math(EXPR MAX_LENGTH "${CT_OPTION_MAX_CHARS_PER_LINE} - ${CT_CONST_CT_LOG_WRITELINE_CHARS}")
	CT_STRING_BACK_PADDING(ret ${STRING} ${MAX_LENGTH})
	set(${RET} ${ret} PARENT_SCOPE)
endfunction()

# testertestertestertestertestertestertestertestertestertester
# ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
if(${CT_OPTION_INNER_TESTER_SET_ENABLE})
	set(ct_function_tester_parameter0 "1234")
	set(ct_function_tester_return_value)
	CT_WRITELINE_MSG_AUTO_PADDING(ct_function_tester_return_value ${ct_function_tester_parameter0})

	message("[TESTER] : ${ct_function_tester_return_value} = CT_WRITELINE_MSG_AUTO_PADDING(ct_function_tester_return_value ${ct_function_tester_parameter0})")
endif()

# ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
# testertestertestertestertestertestertestertestertestertester

#
function(CT_LOG_WRITELINE MSG)
	CT_WRITELINE_MSG_AUTO_PADDING(MSG ${MSG})
	message("##[C]:${MSG}##")
endfunction()

# testertestertestertestertestertestertestertestertestertester
# ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
if(${CT_OPTION_INNER_TESTER_SET_ENABLE})
	set(ct_function_tester_parameter0 "1234")
	CT_LOG_WRITELINE(${ct_function_tester_parameter0})

	message("[TESTER] : CT_LOG_WRITELINE(${ct_function_tester_parameter0})")
endif()

# ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
# testertestertestertestertestertestertestertestertestertester

#
function(CT_LOG_WRITELINE_PARTITION)
	set(temp "")

	foreach(index RANGE 1 ${CT_OPTION_MAX_CHARS_PER_LINE})
		set(temp "${temp}#")
	endforeach()

	message("${temp}")
endfunction()

#
function(CT_LOG_WRITELINE_THIN_PARTITION)
	set(temp "##")

	foreach(index RANGE 5 ${CT_OPTION_MAX_CHARS_PER_LINE})
		set(temp "${temp}-")
	endforeach()

	message("${temp}##")
endfunction()

# testertestertestertestertestertestertestertestertestertester
# ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
if(${CT_OPTION_INNER_TESTER_SET_ENABLE})
	set(ct_function_tester_parameter0 "1234")
	CT_LOG_WRITELINE_PARTITION()
	CT_LOG_WRITELINE(${ct_function_tester_parameter0})
	CT_LOG_WRITELINE_PARTITION()

	message("[TESTER] : CT_LOG_WRITELINE_PARTITION()
	CT_LOG_WRITELINE(${ct_function_tester_parameter0})
	CT_LOG_WRITELINE_PARTITION()")
endif()

# ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
# testertestertestertestertestertestertestertestertestertester

#
function(CT_LOG_WRITELINE_LIST VAR_LIST)
	set(index 0)
	set(line "")

	list(LENGTH ${VAR_LIST} list_length)
	math(EXPR list_length "${list_length}-1")

	math(EXPR max_chars_per_item_space "((${CT_OPTION_MAX_CHARS_PER_LINE} - ${CT_CONST_CT_LOG_WRITELINE_CHARS})/${CT_OPTION_ELEMENTS_PER_LINE})-2")
	set(temp_list)

	foreach(index RANGE "0" "${list_length}")
		set(list_item)
		list(GET ${VAR_LIST} ${index} list_item)

		CT_STRING_BACK_PADDING(list_item ${list_item} ${max_chars_per_item_space})
		set(temp_list "${temp_list}|${list_item}|")

		math(EXPR mod4 "${index} % ${CT_OPTION_ELEMENTS_PER_LINE}")
		math(EXPR mod4_time "${CT_OPTION_ELEMENTS_PER_LINE}-1")

		if(NOT "${index}" STREQUAL "0" AND ${mod4} EQUAL ${mod4_time})
			CT_LOG_WRITELINE(${temp_list})
			set(temp_list)
		endif()
	endforeach()

	list(LENGTH temp_list list_length)

	if(${list_length} GREATER "0")
		CT_LOG_WRITELINE(${temp_list})
	endif()
endfunction()

# testertestertestertestertestertestertestertestertestertester
# ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
if(${CT_OPTION_INNER_TESTER_SET_ENABLE})
	set(ct_function_tester_parameter0 "11234" "212341234" "3123412341234" "41234123412341234" "512341234123412341234" "6123412341234123412341234" "71234123412341234123412341234" "11234" "212341234" "3123412341234" "41234123412341234" "512341234123412341234" "6123412341234123412341234" "71234123412341234123412341234")
	CT_LOG_WRITELINE_PARTITION()
	CT_LOG_WRITELINE_LIST(ct_function_tester_parameter0)
	CT_LOG_WRITELINE_PARTITION()

	message("[TESTER] : CT_LOG_WRITELINE_LIST(ct_function_tester_parameter0)")
endif()

# ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
# testertestertestertestertestertestertestertestertestertester

#
function(CT_READ_TEXTFILE RET FILE_PATH)
	file(READ ${FILE_PATH} file_content)
	set(${RET} "${file_content}" PARENT_SCOPE)
endfunction()

#
function(CT_WRITE_TEXTFILE FILE_PATH CONTENTS)
	file(WRITE ${FILE_PATH} ${CONTENTS})
endfunction()

#
function(CT_EXISTS RET PATH)
	if(EXISTS "${PATH}")
		set(${RET} TRUE PARENT_SCOPE)
	else()
		set(${RET} FALSE PARENT_SCOPE)
	endif()
endfunction()

#
function(CT_IF_EXISTS_DIR_THROW PATH)
	set(ret)
	CT_EXISTS(ret ${PATH})

	if(${RET})
		CT_THROW_ERROR(${CT_CONST_ERROR_TITLE} "Directory `${PATH}` already exists")
	endif()
endfunction()

#
function(CT_NIF_EXISTS_DIR_THROW PATH)
	set(ret)
	CT_EXISTS(ret ${PATH})

	if(NOT ${RET})
		CT_THROW_ERROR(${CT_CONST_ERROR_TITLE} "Directory `${PATH}` already exists")
	endif()
endfunction()

#
function(CT_MAKE_PROJECT NAME)
	file(MAKE_DIRECTORY "${CT_CONST_CUR_SCRIPT_PATH}/${NAME}")
	file(MAKE_DIRECTORY "${CT_CONST_CUR_SCRIPT_PATH}/${NAME}/${CT_CONST_SUBPROJECT_SPEC_DIR_SRC}")
	file(MAKE_DIRECTORY "${CT_CONST_CUR_SCRIPT_PATH}/${NAME}/${CT_CONST_SUBPROJECT_SPEC_DIR_RES}")
	file(MAKE_DIRECTORY "${CT_CONST_CUR_SCRIPT_PATH}/${NAME}/${CT_CONST_SUBPROJECT_SPEC_DIR_INF}")
endfunction()

function(CT_READ_CMAKEPROJECTLISTS RET_PROJECTS)
	set(file_path "${CT_CONST_CUR_SCRIPT_PATH}/CMakeProjectLists.cmake")
	set(project_dir_prefix "CTP_")
	CT_EXISTS(project_list_file ${file_path})

	if(NOT project_list_file)
		CT_WRITE_TEXTFILE(${file_path}
			"#
# Add your project name to `CT_PROJECTS`(list) variable
# Names in `CT_PROJECTS` are compared with the project directory, and names not in `CT_PROJECTS` are removed. (Warning)
# Project directories are prefixed with `${project_dir_prefix}`. Be careful when creating new directories
#

set(CT_PROJECTS

)
"
		)
	endif()

	file(GLOB CTP_DIRS RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} "CTP_*")

	CT_LOG_WRITELINE_PARTITION()
	CT_LOG_WRITELINE("List of directories that once exist")
	CT_LOG_WRITELINE_THIN_PARTITION()
	CT_LOG_WRITELINE_LIST(CTP_DIRS)
	CT_LOG_WRITELINE_PARTITION()

	include(${file_path})

	CT_LOG_WRITELINE_PARTITION()
	CT_LOG_WRITELINE("List of confirmed projects")
	CT_LOG_WRITELINE_THIN_PARTITION()
	CT_LOG_WRITELINE_LIST(CT_PROJECTS)
	CT_LOG_WRITELINE_PARTITION()

	# foreach(project ${CT_PROJECTS})
	# list(FIND ${CTP_DIRS} ${project} INDEX)

	# if(${INDEX} EQUAL -1)
	# CT_LOG_WRITELINE("Delete project -> `C://`")
	# else()
	# set(${RESULT_VAR} TRUE PARENT_SCOPE)
	# endif()
	# endforeach()

	# foreach(dir ${CTP_DIRS})
	# list(FIND ${CT_PROJECTS} ${dir} INDEX)

	# if(${INDEX} EQUAL -1)
	# CT_MAKE_PROJECT()
	# endif()
	# endforeach()
endfunction()

# ======================================[Execution Part]======================================
CT_READ_CMAKEPROJECTLISTS(A)
