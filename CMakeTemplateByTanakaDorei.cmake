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
set(CT_CONST_ROOT_CMAKELISTS "CMakeLists.txt" CACHE STRING ${CT_CONST_DOCSTRING} FORCE)
set(CT_CONST_ROOT_CMAKETEMPLATEBYTANAKADOREI "CMakeTemplateByTanakaDorei.cmake" CACHE STRING ${CT_CONST_DOCSTRING} FORCE)
set(CT_CONST_ROOT_CMAKELISTS_EXE "CMakeListsExecutor.cmake" CACHE STRING ${CT_CONST_DOCSTRING} FORCE)
set(CT_CONST_ROOT_CMAKE_ENV_INFO "CMakeENVInfo.cmake" CACHE STRING ${CT_CONST_DOCSTRING} FORCE)
set(CT_CONST_ROOT_CMAKEPROJECTLISTS "CMakeProjectLists.cmake" CACHE STRING ${CT_CONST_DOCSTRING} FORCE)
set(CT_CONST_SUBPROJECT_SPEC_DIR_SRC "src" CACHE STRING ${CT_CONST_DOCSTRING} FORCE)
set(CT_CONST_SUBPROJECT_SPEC_DIR_RES "res" CACHE STRING ${CT_CONST_DOCSTRING} FORCE)
set(CT_CONST_SUBPROJECT_SPEC_DIR_INFO "inf" CACHE STRING ${CT_CONST_DOCSTRING} FORCE)
set(CT_CONST_PROJECT_DIR_PREFIX "CTP_" CACHE STRING ${CT_CONST_DOCSTRING} FORCE)

set(CT_CONST_CUR_SCRIPT_PATH ${CMAKE_CURRENT_SOURCE_DIR} CACHE STRING ${CT_CONST_DOCSTRING} FORCE)
set(CT_CONST_ROOT_CMAKELISTS_PATH "${CT_CONST_CUR_SCRIPT_PATH}/${CT_CONST_ROOT_CMAKELISTS}" CACHE STRING ${CT_CONST_DOCSTRING} FORCE)
set(CT_CONST_ROOT_CMAKETEMPLATEBYTANAKADOREI_PATH "${CT_CONST_CUR_SCRIPT_PATH}/${CT_CONST_ROOT_CMAKETEMPLATEBYTANAKADOREI}" CACHE STRING ${CT_CONST_DOCSTRING} FORCE)
set(CT_CONST_ROOT_CMAKELISTS_EXE_PATH "${CT_CONST_CUR_SCRIPT_PATH}/${CT_CONST_ROOT_CMAKELISTS_EXE}" CACHE STRING ${CT_CONST_DOCSTRING} FORCE)
set(CT_CONST_ROOT_CMAKE_ENV_INFO_PATH "${CT_CONST_CUR_SCRIPT_PATH}/${CT_CONST_ROOT_CMAKE_ENV_INFO}" CACHE STRING ${CT_CONST_DOCSTRING} FORCE)
set(CT_CONST_ROOT_CMAKEPROJECTLISTS_PATH "${CT_CONST_CUR_SCRIPT_PATH}/${CT_CONST_ROOT_CMAKEPROJECTLISTS}" CACHE STRING ${CT_CONST_DOCSTRING} FORCE)

set(CT_CONST_VARIABLE_TYPE_STRING "<:STRING:>" CACHE STRING ${CT_CONST_DOCSTRING} FORCE)
set(CT_CONST_VARIABLE_TYPE_LIST "<:LIST:>" CACHE STRING ${CT_CONST_DOCSTRING} FORCE)
set(CT_CONST_VARIABLE_TYPE_BOOL "<:BOOL:>" CACHE STRING ${CT_CONST_DOCSTRING} FORCE)

set(CT_CONST_IDE_VSCODE "VSCODE" CACHE STRING ${CT_CONST_DOCSTRING} FORCE)

set(CT_CONST_CT_LOG_WRITELINE_CHARS "8" CACHE STRING ${CT_CONST_DOCSTRING} FORCE)
set(CT_CONST_CT_LOG_WRITELINE_HEADER_CHARS "6" CACHE STRING ${CT_CONST_DOCSTRING} FORCE)
set(CT_CONST_CT_LOG_WRITELINE_FOOTER_CHARS "2" CACHE STRING ${CT_CONST_DOCSTRING} FORCE)

# [Options]
# Command-line modification only options
set(CT_OPTION_DOCSTRING "Command-line modification-only variables" CACHE STRING "Command-line modification-only variables" FORCE)

# Maximum characters per line
set(CT_OPTION_MAX_CHARS_PER_LINE "100" CACHE STRING ${CT_OPTION_DOCSTRING} FORCE)
set(CT_OPTION_ELEMENTS_PER_LINE "4" CACHE STRING ${CT_OPTION_DOCSTRING} FORCE)
set(CT_OPTION_INNER_TESTER_SET_ENABLE FALSE CACHE BOOL ${CT_OPTION_DOCSTRING} FORCE)

# [Inner Options]
# Options used internally. Modified within the script. Restrict user access
set(CT_INNER_OPTION_MAKE_CMAKELISTS TRUE)
set(CT_INNER_OPTION_LIBRARY_MODE FALSE)

# [Cmake Header]
cmake_minimum_required(VERSION ${CT_CONST_CMAKE_VERSION})
if(NOT CT_INNER_OPTION_MAKE_CMAKELISTS)
	project(
		"CMAKETEMPLATE"
		VERSION
		"2023.5.11"
		DESCRIPTION
		"https://github.com/TANAKADOREI/CMakeTemplate"
	)
endif()

# [Cmake Decl Functions]

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

#
function(CT_WRITELINE_MSG_AUTO_PADDING RET STRING)
	math(EXPR MAX_LENGTH "${CT_OPTION_MAX_CHARS_PER_LINE} - ${CT_CONST_CT_LOG_WRITELINE_CHARS}")
	CT_STRING_BACK_PADDING(ret ${STRING} ${MAX_LENGTH})
	set(${RET} ${ret} PARENT_SCOPE)
endfunction()

#
function(CT_LOG_WRITELINE MSG)
	CT_WRITELINE_MSG_AUTO_PADDING(MSG ${MSG})
	message("##[C]:${MSG}##")
endfunction()

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

function(CT_CHECK_NAME STRING)
	if(STRING MATCHES "^[a-zA-Z0-9_]*$")
	else()
		CT_THROW_ERROR(\"${STRING} -> Characters other than English, numbers, and underscores cannot be used.\")
	endif()
endfunction()

#
function(CT_MAKE_PROJECT NAME)
	file(MAKE_DIRECTORY "${CT_CONST_CUR_SCRIPT_PATH}/${NAME}")
	file(MAKE_DIRECTORY "${CT_CONST_CUR_SCRIPT_PATH}/${NAME}/${CT_CONST_SUBPROJECT_SPEC_DIR_SRC}")
	file(MAKE_DIRECTORY "${CT_CONST_CUR_SCRIPT_PATH}/${NAME}/${CT_CONST_SUBPROJECT_SPEC_DIR_RES}")
	file(MAKE_DIRECTORY "${CT_CONST_CUR_SCRIPT_PATH}/${NAME}/${CT_CONST_SUBPROJECT_SPEC_DIR_INF}")
	CT_WRITE_TEXTFILE("${CT_CONST_CUR_SCRIPT_PATH}/${NAME}/CMakeLists.txt"
		"#
# auto-generated constant
#
set(CT_CONST_PROJECT_${NAME} \"${NAME}\")

set(CT_PROJECT_${NAME}_CODEFILES)
set(CT_PROJECT_${NAME}_COMPILE_DEFINITIONS)
set(CT_PROJECT_${NAME}_COMPILE_FEATURES)
set(CT_PROJECT_${NAME}_COMPILE_OPTIONS)
set(CT_PROJECT_${NAME}_INCLUDE_DIRECTORIES)
set(CT_PROJECT_${NAME}_LINK_DIRECTORIES)
set(CT_PROJECT_${NAME}_LINK_LIBRARIES)
set(CT_PROJECT_${NAME}_LINK_OPTIONS)
set(CT_PROJECT_${NAME}_BUILD_POST_CMAKESCRIPTS)
set(CT_PROJECT_${NAME}_BUILD_PRE_CMAKESCRIPTS)
set(CT_PROJECT_${NAME}_POST_CMAKESCRIPTS)
set(CT_PROJECT_${NAME}_PRE_CMAKESCRIPTS)
set(CT_PROJECT_${NAME}_FIND_PACKAGES)

include(\"${CT_CONST_ROOT_CMAKEPROJECTBASESCRIPT_PATH}\")
"
	)
endfunction()

function(CT_MAKE_CMAKEPROJECTBASESCRIPT)
	if(NOT EXISTS ${CT_CONST_ROOT_CMAKEPROJECTBASESCRIPT_PATH})
		CT_WRITE_TEXTFILE(${CT_CONST_ROOT_CMAKEPROJECTBASESCRIPT_PATH}
			"#
#
find_package()
target_sources()
target_compile_definitions()
target_compile_features()
target_compile_options()
target_include_directories()
target_link_directories()
target_link_libraries()
target_link_options()
target_precompile_headers()
#
#
"
		)
	endif()
endfunction()

function(MAKE_CMAKEGLOBALSCRIPT)
	if(NOT EXISTS ${CT_CONST_ROOT_CMAKEPROJECTBASESCRIPT_PATH})
		CT_WRITE_TEXTFILE(${CT_CONST_ROOT_CMAKEPROJECTBASESCRIPT_PATH}
			"

"
		)
	endif()
endfunction()

function(CT_MAKE_BASEFILES)
	if(NOT EXISTS ${CT_CONST_ROOT_CMAKELISTS_PATH})
		CT_WRITE_TEXTFILE(${CT_CONST_ROOT_CMAKELISTS_PATH}
			"#
# do not modify this file
#
cmake_minimum_required(VERSION ${CT_CONST_CMAKE_VERSION})
set(CT_INNER_OPTION_MAKE_CMAKELISTS FALSE)
message(\"[${CT_CONST_ROOT_CMAKELISTS}]:\")
include(\"\${CMAKE_CURRENT_SOURCE_DIR}/${CT_CONST_ROOT_CMAKETEMPLATEBYTANAKADOREI}\")
message(\":[${CT_CONST_ROOT_CMAKELISTS}]\")
"
		)
	endif()

	if(NOT EXISTS ${CT_CONST_ROOT_CMAKELISTS_EXE_PATH})
		CT_WRITE_TEXTFILE(${CT_CONST_ROOT_CMAKELISTS_EXE_PATH}
			"#
# do not modify this file
#
cmake_minimum_required(VERSION ${CT_CONST_CMAKE_VERSION})

message(\"[${CT_CONST_ROOT_CMAKELISTS_EXE}]:\")
set(output)

if(NOT DEPENDS CT_CUR_IDE)

execute_process(
	COMMAND \${CMAKE_COMMAND} \${CMAKE_CURRENT_LIST_DIR} -B \${CMAKE_CURRENT_LIST_DIR}/CTBUILD -Wno-dev
	OUTPUT_VARIABLE output
)
message(\${output})

else()

message(\"Once you've decided on an IDE, you won't be able to use the features of that file. Do not command with `-P` option, follow your IDE's capabilities\")

endif()
message(\":[${CT_CONST_ROOT_CMAKELISTS_EXE}]\")
"
		)
	endif()

	if(NOT EXISTS ${CT_CONST_ROOT_CMAKE_ENV_INFO_PATH})
	CT_WRITE_TEXTFILE(${CT_CONST_ROOT_CMAKE_ENV_INFO_PATH}
		"#
# Select the appropriate IDE from the list below and uncomment it. Only one.
#

#set(CT_CUR_IDE \"${CT_CONST_IDE_VSCODE}\")
"
	)
endif()
endfunction()

function(CT_MAKE_CMAKEPROJECTLISTS)
	if(NOT EXISTS ${CT_CONST_ROOT_CMAKEPROJECTLISTS_PATH})
		CT_WRITE_TEXTFILE(${CT_CONST_ROOT_CMAKEPROJECTLISTS_PATH}
			"#
# Add your project name to `CT_PROJECTS`(list) variable
# Names in `CT_PROJECTS` are compared with the project directory, and names not in `CT_PROJECTS` are removed. (Warning)
# Project directories are prefixed with `${CT_CONST_PROJECT_DIR_PREFIX}`. Be careful when creating new directories
#

set(CT_PROJECTS

)
"
		)
	endif()

	include(${CT_CONST_ROOT_CMAKEPROJECTLISTS_PATH})
endfunction()

function(CT_READ_CMAKEPROJECTLISTS RET_PROJECT_LIST RET_PROJECT_PATH_LIST)
	CT_MAKE_CMAKEPROJECTLISTS()

	file(GLOB CTP_DIR_NAMES RELATIVE ${CT_CONST_CUR_SCRIPT_PATH} "${CT_CONST_PROJECT_DIR_PREFIX}*")

	CT_LOG_WRITELINE_PARTITION()
	CT_LOG_WRITELINE("List of directories that once exist")
	CT_LOG_WRITELINE_THIN_PARTITION()
	CT_LOG_WRITELINE_LIST(CTP_DIR_NAMES)
	CT_LOG_WRITELINE_PARTITION()

	set(CT_DIR_PATH_LIST)

	foreach(item ${CTP_DIR_NAMES})
		list(APPEND CT_DIR_PATH_LIST "${CT_CONST_CUR_SCRIPT_PATH}/${item}")
	endforeach()

	set(CT_PROJECT_LIST)
	set(CT_PROJECT_PATH_LIST)

	foreach(project_name ${CT_PROJECTS})
		CT_CHECK_NAME(${project_name})
		list(APPEND CT_PROJECT_LIST ${project_name})
		list(APPEND CT_PROJECT_PATH_LIST "${CT_CONST_CUR_SCRIPT_PATH}/${CT_CONST_PROJECT_DIR_PREFIX}${project_name}")
	endforeach()

	CT_LOG_WRITELINE_PARTITION()
	CT_LOG_WRITELINE("List of confirmed projects")
	CT_LOG_WRITELINE_THIN_PARTITION()
	CT_LOG_WRITELINE_LIST(CT_PROJECT_LIST)
	CT_LOG_WRITELINE_THIN_PARTITION()
	CT_LOG_WRITELINE_LIST_SIMPLE(CT_PROJECT_PATH_LIST)
	CT_LOG_WRITELINE_THIN_PARTITION()
	CT_LOG_WRITELINE_LIST_SIMPLE(CT_DIR_PATH_LIST)
	CT_LOG_WRITELINE_PARTITION()

	# opt
	foreach(project_path ${CT_PROJECT_PATH_LIST})
		list(FIND CT_DIR_PATH_LIST "${project_path}" INDEX)

		if(${INDEX} EQUAL -1)
			CT_LOG_WRITELINE("[Create] ${project_path}")
			file(MAKE_DIRECTORY ${project_path})
		else()
			CT_LOG_WRITELINE("[Pass] ${project_path}")
		endif()
	endforeach()

	foreach(dir_path ${CT_DIR_PATH_LIST})
		list(FIND CT_PROJECT_PATH_LIST "${dir_path}" INDEX)

		if(${INDEX} EQUAL -1)
			CT_LOG_WRITELINE("[Delete] ${dir_path}")
			file(REMOVE_RECURSE ${dir_path})
		else()
			CT_LOG_WRITELINE("[Pass] ${dir_path}")
		endif()
	endforeach()
endfunction()

# [Execution Part]
if(CT_INNER_OPTION_MAKE_CMAKELISTS)
	# Event when creating root `CMakeLists.txt`
	CT_LOG_WRITELINE_PARTITION()
	CT_LOG_WRITELINE("Event when creating root `CMakeLists.txt`")
	CT_LOG_WRITELINE_PARTITION()
	CT_MAKE_BASEFILES()
else()
	if(NOT CT_INNER_OPTION_LIBRARY_MODE)
		# Root `CMakeLists.txt` logic
		CT_LOG_WRITELINE_PARTITION()
		CT_LOG_WRITELINE("Root `CMakeLists.txt` logic")
		CT_LOG_WRITELINE_PARTITION()
		CT_READ_CMAKEPROJECTLISTS(A B)
	else()
		# When sub `CMakeLists.txt` is being accessed in library mode
		CT_LOG_WRITELINE_PARTITION()
		CT_LOG_WRITELINE("When sub `CMakeLists.txt` is being accessed in library mode")
		CT_LOG_WRITELINE_PARTITION()
	endif()
endif()
