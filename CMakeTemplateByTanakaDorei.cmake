# ======================================[Parameter Naming]======================================
# Arguments must be carefully passed in the caller to the defined name of the parameter.
# When used as a prefix, an underscore (_) is added after the keyword and the parameter name is written. When used alone, just write the keyword without an underscore.
#
# Keywords...
# `VAR` <- Just write the variable name in the argument
# `RET` <- It is used the same as the `VAR` keyword, and explicitly expresses that it is just a variable to receive a return value.
#
# Non-keyword names can pass arguments as value types.
#
cmake_minimum_required(VERSION 3.25)

if(EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/CMakeTemplateByTanakaDorei.cmake")
	if(NOT EXISTS "CMakeRoot.cmake")
		file(WRITE "CMakeRoot.cmake"
			"#
# do not modify this file
#
cmake_minimum_required(VERSION 3.25)

set(CT_CMAKETEMPLATEBYTANAKADOREI \"3654836749\")

set(CT_CONST_CMAKE_VERSION \"3.25\")

set(CT_CONST_ROOT_DIR_PATH \"${CMAKE_CURRENT_SOURCE_DIR}\")
set(CT_CONST_ROOT_NAME_CMAKEROOT \"CMakeRoot.cmake\")
set(CT_CONST_ROOT_NAME_CMAKEENVSETTINGS \"CMakeENVSettings.cmake\")
set(CT_CONST_ROOT_NAME_CMAKELISTS \"CMakeLists.txt\")
set(CT_CONST_ROOT_NAME_CMAKEROOTLISTSEXECUTOR \"CMakeRootListsExecutor.cmake\")
set(CT_CONST_ROOT_NAME_CMAKEPROJECTS \"CMakeProjects.cmake\")
set(CT_CONST_ROOT_NAME_CMAKETEMPLATEBYTANAKADOREI \"CMakeTemplateByTanakaDorei.cmake\")

set(CT_CONST_ROOT_PATH_CMAKEROOT \"\${CT_CONST_ROOT_DIR_PATH}/\${CT_CONST_ROOT_NAME_CMAKEROOT}\")
set(CT_CONST_ROOT_PATH_CMAKEENVSETTINGS \"\${CT_CONST_ROOT_DIR_PATH}/\${CT_CONST_ROOT_NAME_CMAKEENVSETTINGS}\")
set(CT_CONST_ROOT_PATH_CMAKELISTS \"\${CT_CONST_ROOT_DIR_PATH}/\${CT_CONST_ROOT_NAME_CMAKELISTS}\")
set(CT_CONST_ROOT_PATH_CMAKEROOTLISTSEXECUTOR \"\${CT_CONST_ROOT_DIR_PATH}/\${CT_CONST_ROOT_NAME_CMAKEROOTLISTSEXECUTOR}\")
set(CT_CONST_ROOT_PATH_CMAKEPROJECTS \"\${CT_CONST_ROOT_DIR_PATH}/\${CT_CONST_ROOT_NAME_CMAKEPROJECTS}\")
set(CT_CONST_ROOT_PATH_CMAKETEMPLATEBYTANAKADOREI \"\${CT_CONST_ROOT_DIR_PATH}/\${CT_CONST_ROOT_NAME_CMAKETEMPLATEBYTANAKADOREI}\")

set(CT_CONST_SEPCFILE_NAME_CMAKELISTS \"CMakeLists.txt\")

set(CT_CONST_PROJECT_DIR_PREFIX \"CTP_\")

set(CT_CONST_SEPCDIR_NAME_CMK \"cmk\")
set(CT_CONST_SEPCDIR_NAME_SRC \"src\")
set(CT_CONST_SEPCDIR_NAME_RES \"res\")

set(CT_CONST_CT_LOG_WRITELINE_CHARS \"8\")
set(CT_CONST_CT_LOG_WRITELINE_HEADER_CHARS \"6\")
set(CT_CONST_CT_LOG_WRITELINE_FOOTER_CHARS \"2\")
set(CT_OPTION_MAX_CHARS_PER_LINE \"100\")
set(CT_OPTION_ELEMENTS_PER_LINE \"4\")

"
		)
	endif()

	include("CMakeRoot.cmake")

	# [RootLogic]
	# ┌────────────────────────────────────────────────────────────────────────────────────────────────────────┐
	if(NOT DEFINED CT_CMAKETEMPLATEBYTANAKADOREI OR NOT ${CT_CMAKETEMPLATEBYTANAKADOREI} STREQUAL "3654836749")
		message(FATAL_ERROR "I thought it was the current root directory location and I used the 'include' command for 'CMakeRoot.cmake', but it doesn't seem to be loaded.")
	endif()

	set(CT_THIS_SCRIPTFILE_IS_ROOTDIR TRUE)

	# └────────────────────────────────────────────────────────────────────────────────────────────────────────┘
endif()

# [Inner Options]
# ┌────────────────────────────────────────────────────────────────────────────────────────────────────────┐
# Options used internally. Modified within the script. Restrict user access
if(NOT DEFINED CT_INNER_OPTION_LIBRARY_MODE)
	set(CT_INNER_OPTION_LIBRARY_MODE FALSE)
endif()

# Must be called at the end of that file
function(CT_INNER_OPTIONS_UNSET)
	unset(CT_INNER_OPTION_LIBRARY_MODE)
endfunction()

# └────────────────────────────────────────────────────────────────────────────────────────────────────────┘

# [Cmake Decl Functions]
# ┌────────────────────────────────────────────────────────────────────────────────────────────────────────┐

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
			CT_THROW_ERROR("${VAR} is empty.")
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
function(CT_LOG_WRITELINE_INNER_NEWLINE)
	set(temp "##")

	foreach(index RANGE 5 ${CT_OPTION_MAX_CHARS_PER_LINE})
		set(temp "${temp} ")
	endforeach()

	message("${temp}##")
endfunction()

#
function(CT_LOG_WRITELINE_NEWLINE)
	foreach(index RANGE 1 ${CT_OPTION_MAX_CHARS_PER_LINE})
		set(temp "${temp} ")
	endforeach()

	message("${temp}")
endfunction()

#
function(CT_LOG_WRITELINE_LIST VAR_LIST BOOL_LINEAR_SHOW)
	if(DEFINED ${VAR_LIST})
		set(index 0)
		set(line "")

		list(LENGTH ${VAR_LIST} list_length)

		if(0 LESS ${list_length})
			if(NOT BOOL_LINEAR_SHOW)
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
			else()
				foreach(item ${${VAR_LIST}})
					CT_LOG_WRITELINE("* ${item}")
				endforeach()
			endif()
		else()
			CT_LOG_WRITELINE("List is Null")
		endif()
	else()
		CT_LOG_WRITELINE("List is Null")
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

#
function(CT_CHECK_NAME STRING)
	if(STRING MATCHES "^[a-zA-Z0-9_]*$")
	else()
		CT_THROW_ERROR(\"${STRING} -> Characters other than English, numbers, and underscores cannot be used.\")
	endif()
endfunction()

# └────────────────────────────────────────────────────────────────────────────────────────────────────────┘

#
function(CT_MAKE_PROJECTDIR NAME)
	file(MAKE_DIRECTORY "${CT_CONST_ROOT_DIR_PATH}/${NAME}")
	file(MAKE_DIRECTORY "${CT_CONST_ROOT_DIR_PATH}/${NAME}/${CT_CONST_SEPCDIR_NAME_CMK}")
	file(MAKE_DIRECTORY "${CT_CONST_ROOT_DIR_PATH}/${NAME}/${CT_CONST_SEPCDIR_NAME_SRC}")
	file(MAKE_DIRECTORY "${CT_CONST_ROOT_DIR_PATH}/${NAME}/${CT_CONST_SEPCDIR_NAME_RES}")

	set(file_path "${CT_CONST_ROOT_DIR_PATH}/${NAME}/${CT_CONST_SEPCFILE_NAME_CMAKELISTS}")

	if(NOT EXISTS ${file_path})
		CT_WRITE_TEXTFILE(${file_path}
			"#
set(CT_PROJECT_NAME \"${NAME}\")
set(CT_PROJECT_PRE_CMAKESCRIPTS)
set(CT_PROJECT_FIND_PACKAGES)
set(CT_PRECOMPILE_HEADERS)
set(CT_PROJECT_CODEFILES)
set(CT_PROJECT_COMPILE_DEFINITIONS)
set(CT_PROJECT_COMPILE_FEATURES)
set(CT_PROJECT_COMPILE_OPTIONS)
set(CT_PROJECT_INCLUDE_DIRECTORIES)
set(CT_PROJECT_LINK_DIRECTORIES)
set(CT_PROJECT_LINK_LIBRARIES)
set(CT_PROJECT_LINK_OPTIONS)
set(CT_PROJECT_POST_CMAKESCRIPTS)
set(CT_PROJECT_BUILD_POST_CMAKESCRIPTS)
set(CT_PROJECT_BUILD_PRE_CMAKESCRIPTS)

set(CT_INNER_OPTION_LIBRARY_MODE TRUE)
include(\${CT_CONST_ROOT_PATH_CMAKETEMPLATEBYTANAKADOREI})
CT_PROJECTDIR_SCRIPT()
"
		)
	endif()
endfunction()

function(CT_PROJECTDIR_SCRIPT)
	foreach(packages ${CT_PROJECT_PRE_CMAKESCRIPTS})
		include("${CT_CONST_SEPCDIR_NAME_CMK}/${packages}")
	endforeach()

	find_package(${CT_PROJECT_FIND_PACKAGES} REQUIRED)
	target_sources(${CT_PROJECT_NAME} PRIVATE ${CT_PROJECT_CODEFILES})
	target_compile_definitions(${CT_PROJECT_NAME} PRIVATE ${CT_PROJECT_COMPILE_DEFINITIONS})
	target_compile_features(${CT_PROJECT_NAME} PRIVATE ${CT_PROJECT_COMPILE_FEATURES})
	target_compile_options(${CT_PROJECT_NAME} PRIVATE ${CT_PROJECT_COMPILE_OPTIONS})
	target_include_directories(${CT_PROJECT_NAME} PRIVATE ${CT_PROJECT_INCLUDE_DIRECTORIES})
	target_link_directories(${CT_PROJECT_NAME} PRIVATE ${CT_PROJECT_LINK_DIRECTORIES})
	target_link_libraries(${CT_PROJECT_NAME} PRIVATE ${CT_PROJECT_LINK_LIBRARIES})
	target_link_options(${CT_PROJECT_NAME} PRIVATE ${CT_PROJECT_LINK_OPTIONS})
	target_precompile_headers(${CT_PROJECT_NAME} PRIVATE ${CT_PRECOMPILE_HEADERS})
endfunction()

function(CT_MAKE_CMAKEENVSETTINGS)
	if(NOT EXISTS ${CT_CONST_ROOT_PATH_CMAKEENVSETTINGS})
		CT_WRITE_TEXTFILE(${CT_CONST_ROOT_PATH_CMAKEENVSETTINGS}
			"#
# If your IDE supports Cmake
set(CT_IDE_MODE TRUE)
"
		)
	endif()
endfunction()

# Root CMakeLists.txt fileをつくる
function(CT_MAKE_ROOTCMAKELISTS)
	if(NOT EXISTS ${CT_CONST_ROOT_PATH_CMAKELISTS})
		CT_WRITE_TEXTFILE(${CT_CONST_ROOT_PATH_CMAKELISTS}
			"#
# Only edit the `project` command, don't edit the rest
#
cmake_minimum_required(VERSION ${CT_CONST_CMAKE_VERSION})
project(
	\"CMAKETEMPLATEBYTANAKADOREI\"
	VERSION
	\"2023.5.11\"
	DESCRIPTION
	\"https://github.com/TANAKADOREI/CMakeTemplate\"
)
message(\"[${CT_CONST_ROOT_NAME_CMAKELISTS}]:\")
include(\"${CT_CONST_ROOT_NAME_CMAKETEMPLATEBYTANAKADOREI}\")
message(\":[${CT_CONST_ROOT_NAME_CMAKELISTS}]\")
"
		)
	endif()
endfunction()

# IDE_MODEがFALSEとき使用できるScript
function(CT_MAKE_CMAKEROOTLISTSEXECUTOR)
	if(NOT EXISTS ${CT_CONST_ROOT_PATH_CMAKEROOTLISTSEXECUTOR})
		CT_WRITE_TEXTFILE(${CT_CONST_ROOT_PATH_CMAKEROOTLISTSEXECUTOR}
			"#
# Only the command line part of the `execute_process` part can be modified.
#
cmake_minimum_required(VERSION ${CT_CONST_CMAKE_VERSION})

message(\"[${CT_CONST_ROOT_NAME_CMAKEROOTLISTSEXECUTOR}]:\")

include(\"${CT_CONST_ROOT_NAME_CMAKEROOT}\")
include(\"${CT_CONST_ROOT_NAME_CMAKEENVSETTINGS}\")

set(output)

if(NOT CT_IDE_MODE)

execute_process(
COMMAND
# [editable part]
# ┌──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
\${CMAKE_COMMAND} \${CT_CONST_ROOT_DIR_PATH} -B \${CT_CONST_ROOT_DIR_PATH}/CMakeTemplateOutput -Wno-dev
# └──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
OUTPUT_VARIABLE output
)
message(\${output})

else()

message(\"This script file cannot be used when `CT_IDE_MODE` of `CMakeENVSettings.cmake` is true.\")

endif()
message(\":[${CT_CONST_ROOT_NAME_CMAKEROOTLISTSEXECUTOR}]\")
"
		)
	endif()
endfunction()

function(CT_MAKE_CMAKEPROJECTS)
	if(NOT EXISTS ${CT_CONST_ROOT_PATH_CMAKEPROJECTS})
		CT_WRITE_TEXTFILE(${CT_CONST_ROOT_PATH_CMAKEPROJECTS}
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
endfunction()

# [Root `CMakeLists.txt` logic]
# ┌────────────────────────────────────────────────────────────────────────────────────────────────────────┐
if(DEFINED CT_THIS_SCRIPTFILE_IS_ROOTDIR)
	unset(CT_THIS_SCRIPTFILE_IS_ROOTDIR)

	CT_MAKE_CMAKEPROJECTS()
	CT_MAKE_ROOTCMAKELISTS()
	CT_MAKE_CMAKEENVSETTINGS()
	CT_MAKE_CMAKEROOTLISTSEXECUTOR()

	include(${CT_CONST_ROOT_PATH_CMAKEPROJECTS})

	file(GLOB CTP_DIR_NAMES RELATIVE ${CT_CONST_ROOT_DIR_PATH} "${CT_CONST_PROJECT_DIR_PREFIX}*")

	set(CT_DIR_PATH_LIST)

	foreach(item ${CTP_DIR_NAMES})
		list(APPEND CT_DIR_PATH_LIST "${CT_CONST_ROOT_DIR_PATH}/${item}")
	endforeach()

	set(CT_PROJECT_LIST)
	set(CT_PROJECT_PATH_LIST)

	foreach(project_name ${CT_PROJECTS})
		CT_CHECK_NAME(${project_name})
		list(APPEND CT_PROJECT_LIST ${project_name})
		list(APPEND CT_PROJECT_PATH_LIST "${CT_CONST_ROOT_DIR_PATH}/${CT_CONST_PROJECT_DIR_PREFIX}${project_name}")
	endforeach()

	CT_LOG_WRITELINE_NEWLINE()
	CT_LOG_WRITELINE_PARTITION()
	CT_LOG_WRITELINE("Checked project logs")
	CT_LOG_WRITELINE_THIN_PARTITION()
	CT_LOG_WRITELINE("List of registered project names")
	CT_LOG_WRITELINE_LIST(CT_PROJECT_LIST FALSE)
	CT_LOG_WRITELINE_THIN_PARTITION()
	CT_LOG_WRITELINE("path for each project")
	CT_LOG_WRITELINE_LIST(CT_PROJECT_PATH_LIST TRUE)
	CT_LOG_WRITELINE_THIN_PARTITION()
	CT_LOG_WRITELINE("Project path found on the physical file system")
	CT_LOG_WRITELINE_LIST(CT_DIR_PATH_LIST TRUE)
	CT_LOG_WRITELINE_PARTITION()
	CT_LOG_WRITELINE_NEWLINE()

	CT_LOG_WRITELINE_PARTITION()
	CT_LOG_WRITELINE("project cleanup")
	CT_LOG_WRITELINE_THIN_PARTITION()

	foreach(project_path ${CT_PROJECT_PATH_LIST})
		list(FIND CT_DIR_PATH_LIST "${project_path}" INDEX)

		if(${INDEX} EQUAL -1)
			CT_LOG_WRITELINE("[Create] ${project_path}")
			list(FIND CT_PROJECT_PATH_LIST "${project_path}" INDEX)
			list(GET CT_PROJECT_LIST ${INDEX} project_name)
			CT_MAKE_PROJECTDIR("${CT_CONST_PROJECT_DIR_PREFIX}${project_name}")
		else()
			CT_LOG_WRITELINE("[Pass] ${project_path}")
		endif()
	endforeach()

	CT_LOG_WRITELINE_THIN_PARTITION()

	foreach(dir_path ${CT_DIR_PATH_LIST})
		list(FIND CT_PROJECT_PATH_LIST "${dir_path}" INDEX)

		if(${INDEX} EQUAL -1)
			CT_LOG_WRITELINE("[Delete] ${dir_path}")

			file(REMOVE_RECURSE ${dir_path})
		else()
			CT_LOG_WRITELINE("[Pass] ${dir_path}")
		endif()
	endforeach()

	CT_LOG_WRITELINE_PARTITION()

	foreach(project_path ${CT_PROJECT_PATH_LIST})
		add_subdirectory(${project_path})
	endforeach()
endif()

# └────────────────────────────────────────────────────────────────────────────────────────────────────────┘
CT_INNER_OPTIONS_UNSET()
