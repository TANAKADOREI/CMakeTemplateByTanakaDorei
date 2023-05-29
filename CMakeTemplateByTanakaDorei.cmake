# "https://github.com/TANAKADOREI/CMakeTemplate"
cmake_minimum_required(VERSION 3.25)

if(NOT EXISTS "${CMAKE_SOURCE_DIR}/CMakeTemplateByTanakaDorei.cmake" OR NOT EXISTS "${CMAKE_SOURCE_DIR}/CMakePresets.json")
	message(FATAL_ERROR "Root directory does not contain '${CMAKE_SOURCE_DIR}/CMakeTemplateByTanakaDorei.cmake' or '${CMAKE_SOURCE_DIR}/CMakePresets.json'")
endif()

# [CT_MODE]
# * SETUP : setup mode (This option is valid only with `cmake -P CMakeTemplateByTanakaDorei.cmake` option.)
# * ROOT : Options available only to the root `CMakeLists.txt`
# * LIB : Options for using functions from `CMake TemplateByTanakaDorei.cmake`
if(NOT DEFINED CT_MODE)
	if(EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/CMakeTemplateByTanakaDorei.cmake" AND EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/CMakePresets.json")
		set(CT_MODE "SETUP")
	endif()
endif()

# Must be called at the end of that file
function(CT_INNER_OPTIONS_UNSET)
	unset(CT_MODE)
endfunction()

# setup mode
if(${CT_MODE} STREQUAL "SETUP" OR ${CT_MODE} STREQUAL "ROOT")
	# only in the project root path
	file(MAKE_DIRECTORY "CMakeGlobals")
	file(MAKE_DIRECTORY "CMakeGlobals/src")
	file(MAKE_DIRECTORY "CMakeGlobals/inj")

	file(WRITE "CMakeConstants.cmake"
		"# \"https://github.com/TANAKADOREI/CMakeTemplate\"
# do not modify this file
# The file is a read-only variable that can be used in included `CMakeLists.txt`. Please don't ever edit.
# This file has the purpose of declaring constants, please do not edit it except for variables prefixed with `CT_OPTION_`.
#
cmake_minimum_required(VERSION 3.25)

set(CT_CMAKETEMPLATEBYTANAKADOREI \"3654836749\")

set(CT_CONST_CMAKE_VERSION \"3.25\")

set(CT_CONST_ROOT_DIR_PATH \"${CMAKE_CURRENT_SOURCE_DIR}\")

set(CT_CONST_ROOT_NAME_CMAKEPRESETS \"CMakePresets.cmake\")
set(CT_CONST_ROOT_NAME_CMAKECONSTANTS \"CMakeConstants.cmake\")
set(CT_CONST_ROOT_NAME_CMAKEGLOBALOPTIONS \"CMakeGlobalOptions.cmake\")
set(CT_CONST_ROOT_NAME_CMAKELISTS \"CMakeLists.txt\")
set(CT_CONST_ROOT_NAME_CMAKEPROJECTS \"CMakeProjects.cmake\")
set(CT_CONST_ROOT_NAME_CMAKETEMPLATEBYTANAKADOREI \"CMakeTemplateByTanakaDorei.cmake\")
set(CT_CONST_ROOT_NAME_CMAKEDEPENDENCIES \"CMakeDependencies.cmake\")

set(CT_CONST_SEPCDIR_NAME_CMK \"cmk\")
set(CT_CONST_SEPCDIR_NAME_SRC \"src\")
set(CT_CONST_SEPCDIR_NAME_RES \"res\")
set(CT_CONST_SEPCDIR_NAME_INJ \"inj\")
set(CT_CONST_SEPCDIR_NAME_CMAKEGLOBALS \"CMakeGlobals\")

set(CT_CONST_ROOT_PATH_CMAKEPRESETS \"\${CT_CONST_ROOT_DIR_PATH}/\${CT_CONST_ROOT_NAME_CMAKEPRESETS}\")
set(CT_CONST_ROOT_PATH_CMAKECONSTANTS \"\${CT_CONST_ROOT_DIR_PATH}/\${CT_CONST_ROOT_NAME_CMAKECONSTANTS}\")
set(CT_CONST_ROOT_PATH_CMAKEGLOBALOPTIONS \"\${CT_CONST_ROOT_DIR_PATH}/\${CT_CONST_ROOT_NAME_CMAKEGLOBALOPTIONS}\")
set(CT_CONST_ROOT_PATH_CMAKELISTS \"\${CT_CONST_ROOT_DIR_PATH}/\${CT_CONST_ROOT_NAME_CMAKELISTS}\")
set(CT_CONST_ROOT_PATH_CMAKEPROJECTS \"\${CT_CONST_ROOT_DIR_PATH}/\${CT_CONST_ROOT_NAME_CMAKEPROJECTS}\")
set(CT_CONST_ROOT_PATH_CMAKETEMPLATEBYTANAKADOREI \"\${CT_CONST_ROOT_DIR_PATH}/\${CT_CONST_ROOT_NAME_CMAKETEMPLATEBYTANAKADOREI}\")
set(CT_CONST_ROOT_PATH_CMAKEDEPENDENCIES \"\${CT_CONST_ROOT_DIR_PATH}/\${CT_CONST_ROOT_NAME_CMAKEDEPENDENCIES}\")
set(CT_CONST_ROOT_PATH_CMAKEGLOBALS \"\${CT_CONST_ROOT_DIR_PATH}/\${CT_CONST_SEPCDIR_NAME_CMAKEGLOBALS}\")
set(CT_CONST_ROOT_PATH_CMAKEGLOBALS_SOURCE \"\${CT_CONST_ROOT_PATH_CMAKEGLOBALS}/\${CT_CONST_SEPCDIR_NAME_SRC}\")
set(CT_CONST_ROOT_PATH_CMAKEGLOBALS_INJECT \"\${CT_CONST_ROOT_PATH_CMAKEGLOBALS}/\${CT_CONST_SEPCDIR_NAME_INJ}\")
set(CT_CONST_ROOT_PATH_CMAKETEMPLATEDATA \"\${CT_CONST_ROOT_DIR_PATH}/CMakeTemplateData\")
set(CT_CONST_ROOT_PATH_CMAKETEMPLATEDATA_CURRENTPRESET \"\${CT_CONST_ROOT_DIR_PATH}/CMakeTemplateData/\${CT_CONST_CURRENT_PRESET}\")
set(CT_CONST_ROOT_PATH_CMAKETEMPLATEDATA_CURRENTPRESET_OUTPUT \"\${CT_CONST_ROOT_DIR_PATH}/CMakeTemplateData/\${CT_CONST_CURRENT_PRESET}/output\")

set(CT_CONST_SEPCFILE_NAME_CMAKELISTS \"CMakeLists.txt\")

set(CT_CONST_CT_LOG_WRITELINE_CHARS \"8\")
set(CT_CONST_CT_LOG_WRITELINE_HEADER_CHARS \"6\")
set(CT_CONST_CT_LOG_WRITELINE_FOOTER_CHARS \"2\")



"
	)

	if(NOT EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/CMakeGlobalOptions.cmake")
		file(WRITE "CMakeGlobalOptions.cmake"
			"# \"https://github.com/TANAKADOREI/CMakeTemplate\"
#
# [options...]
#

# The maximum number of characters that can be displayed on a single line in the terminal environment
set(CT_OPTION_MAX_CHARS_PER_LINE \"100\")
# Did you print one item per line when printing the list?
set(CT_OPTION_ELEMENTS_PER_LINE \"4\")
"
		)
	endif()

	include("CMakeConstants.cmake")
	include("CMakeGlobalOptions.cmake")

	# [RootLogic]
	# ┌────────────────────────────────────────────────────────────────────────────────────────────────────────┐
	if(NOT DEFINED CT_CMAKETEMPLATEBYTANAKADOREI OR NOT ${CT_CMAKETEMPLATEBYTANAKADOREI} STREQUAL "3654836749")
		message(FATAL_ERROR "I thought it was the current root directory location and I used the 'include' command for 'CMakeConstants.cmake', but it doesn't seem to be loaded.")
	endif()

	# └────────────────────────────────────────────────────────────────────────────────────────────────────────┘
endif()

if(NOT ${CT_MODE} STREQUAL "SETUP")
	if(${CMAKE_SYSTEM_NAME} STREQUAL "Linux")
		set(CT_CURRENT_SYSTEM "LINUX")
	elseif(${CMAKE_SYSTEM_NAME} STREQUAL "Windows")
		set(CT_CURRENT_SYSTEM "WINDOWS")
	elseif(${CMAKE_SYSTEM_NAME} STREQUAL "Android")
		set(CT_CURRENT_SYSTEM "ANDROID")
	else()
		message(FATAL_ERROR "environment not supported : ${CMAKE_SYSTEM_NAME}")
	endif()
else()
	set(CT_CURRENT_SYSTEM "Allow unknown system")
endif()

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY "${CT_CONST_ROOT_PATH_CMAKETEMPLATEDATA_CURRENTPRESET_OUTPUT}")
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${CT_CONST_ROOT_PATH_CMAKETEMPLATEDATA_CURRENTPRESET_OUTPUT}")
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${CT_CONST_ROOT_PATH_CMAKETEMPLATEDATA_CURRENTPRESET_OUTPUT}")

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

function(CT_LOG_VERIFICATION_BEGIN RET_ID CREATE_ID MAX_COUNT)
	set(${RET_ID} "${CREATE_ID}" ${MAX_COUNT} 0 PARENT_SCOPE)
	CT_LOG_WRITELINE("Verification (total steps ${MAX_COUNT}) <${CREATE_ID}> (0/${MAX_COUNT})")
endfunction()

function(CT_LOG_VERIFICATION_UPDATE VAR_ID MSG)
	list(GET ${VAR_ID} 0 ID)
	list(GET ${VAR_ID} 1 MAX)
	list(POP_BACK ${VAR_ID} CUR)

	if(${CUR} GREATER ${MAX})
		CT_LOG_WRITELINE("Verification step out of range. <${ID}> (${CUR}/${MAX}): \"${MSG}\"")
	else()
		set(num)
		math(EXPR num "${CUR}+1")
		list(APPEND ${VAR_ID} ${num})
		set(${VAR_ID} ${${VAR_ID}} PARENT_SCOPE)
		CT_LOG_WRITELINE("Verified <${ID}> (${num}/${MAX}): \"${MSG}\"")
	endif()
endfunction()

function(CT_LOG_VERIFICATION_END VAR_ID)
	list(GET ${VAR_ID} 0 ID)
	list(GET ${VAR_ID} 1 MAX)
	list(GET ${VAR_ID} 2 CUR)

	if(${CUR} EQUAL ${MAX})
		CT_LOG_WRITELINE("Verification process completed. <${ID}> (${CUR}/${MAX})")
	else()
		CT_THROW_ERROR("Ended without going through all verification steps. <${ID}> (${CUR}/${MAX})")
	endif()

	unset(${VAR_ID})
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

#
function(CT_MODE_CHECK MODS__LIST_LITERAL_ONLY)
	if(NOT ${CT_MODE} IN_LIST MODS__LIST_LITERAL_ONLY)
		CT_THROW_ERROR("Unauthorized Access. Only the owner of '${MODS__LIST_LITERAL_ONLY}' permission can access it. current accessor `${CT_MODE}`")
	endif()
endfunction()

# └────────────────────────────────────────────────────────────────────────────────────────────────────────┘

# [Root `CMakeLists.txt` logic]
# ┌────────────────────────────────────────────────────────────────────────────────────────────────────────┐

#
function(CT_MAKE_PROJECTDIR NAME)
	CT_MODE_CHECK("ROOT")
	set(project_path "${CT_CONST_ROOT_DIR_PATH}/${NAME}")
	file(MAKE_DIRECTORY "${project_path}")
	file(MAKE_DIRECTORY "${project_path}/${CT_CONST_SEPCDIR_NAME_CMK}")
	file(MAKE_DIRECTORY "${project_path}/${CT_CONST_SEPCDIR_NAME_SRC}")
	file(MAKE_DIRECTORY "${project_path}/${CT_CONST_SEPCDIR_NAME_RES}")

	set(file_path "${project_path}/${CT_CONST_SEPCFILE_NAME_CMAKELISTS}")

	if(NOT EXISTS ${file_path})
		CT_WRITE_TEXTFILE(${file_path}
			"# \"https://github.com/TANAKADOREI/CMakeTemplate\"
# Do not remove or add the variable prefix `CT_PROJECT_`.
# The variable prefix `CT_PROJECT_CONST_` must not be written, such as removing or modifying the value.
#

#
# project name. Must be the same as the name of the directory containing the current file.
#
set(CT_PROJECT_CONST_NAME \"${NAME}\")

#
# project path. Path to the directory containing the current file.
#
set(CT_PROJECT_CONST_PATH \"\${CT_CONST_ROOT_DIR_PATH}/\${CT_PROJECT_CONST_NAME}\")

#
# project type. Whether it is an executable type or a library in the form of a library.
# `EXE`(Executable) or `STLIB`(Static Library) or `SALIB`(Shared Library)
#
set(CT_PROJECT_TYPE)

#
# https://cmake.org/cmake/help/latest/command/enable_language.html#command:enable_language
#
set(CT_PROJECT_LANGUAGE)

#
# project mode. 
# `PLUGIN` only performs actions related to running CMAKE scripts.
# `ENABLE` is the default.
# `DISABLE` will make it not included in the build.
#
set(CT_PROJECT_PROC_MODE ENABLE)

#
# Script to run before the build script block
# The directory the script will work in is by default the same as `${CT_PROJECT_CONST_PATH}`.
#
set(CT_PROJECT_PRE_CMAKESCRIPTS)

#
# custom build script files
# It works in `PLUGIN` mode, and if it is not present, it is regarded as a project that does not use (does not build) the build script.
# When writing a custom build script, you must create a target, and the name of the target must be made with `${CT_PROJECT_CONST_NAME}`
#
set(CT_PROJECT_BUILD_SCRIPTS)

#
# `find_package` command delegate
#
set(CT_PROJECT_FIND_PACKAGES)

#
# `target_precompile_headers` command delegate
#
set(CT_PRECOMPILE_HEADERS)

#
# `target_sources` command delegate
#
set(CT_PROJECT_CODEFILES)

#
# `target_compile_definitions` command delegate
#
set(CT_PROJECT_COMPILE_DEFINITIONS)

#
# `target_compile_features` command delegate
#
set(CT_PROJECT_COMPILE_FEATURES)

#
# `target_compile_options` command delegate
#
set(CT_PROJECT_COMPILE_OPTIONS)

#
# `target_include_directories` command delegate
#
set(CT_PROJECT_INCLUDE_DIRECTORIES)

#
# `target_link_directories` command delegate
#
set(CT_PROJECT_LINK_DIRECTORIES)

#
# `target_link_libraries` command delegate
#
set(CT_PROJECT_LINK_LIBRARIES)

#
# `target_link_options` command delegate
#
set(CT_PROJECT_LINK_OPTIONS)

#
# Script to run after buildscript block
# The directory the script will work in is by default the same as `${CT_PROJECT_CONST_PATH}`.
#
set(CT_PROJECT_POST_CMAKESCRIPTS)

#
# Script to run before build
# The directory the script will work in is by default the same as `${CT_PROJECT_CONST_PATH}`.
#
set(CT_PROJECT_BUILD_PRE_CMAKESCRIPTS)

#
# Script to run after build
# The directory the script will work in is by default the same as `${CT_PROJECT_CONST_PATH}`.
#
set(CT_PROJECT_BUILD_POST_CMAKESCRIPTS)

set(CT_MODE \"LIB\")
include(\${CT_CONST_ROOT_PATH_CMAKETEMPLATEBYTANAKADOREI})
CT_PROJECT_CMAKELISTS_BASIC_SCRIPT()
"
		)
	endif()
endfunction()

function(CT_PROJECT_CMAKELISTS_BASIC_SCRIPT)
	if(${CT_PROJECT_PROC_MODE} STREQUAL "DISABLE")
		CT_LOG_WRITELINE_PARTITION()
		CT_CHECK_VARIABLE(CT_PROJECT_CONST_NAME)
		CT_LOG_WRITELINE("ProjectName: ${CT_PROJECT_CONST_NAME}")
		CT_CHECK_VARIABLE(CT_PROJECT_CONST_PATH)
		CT_LOG_WRITELINE("ProjectPath: ${CT_PROJECT_CONST_PATH}")
		CT_CHECK_VARIABLE(CT_PROJECT_PROC_MODE)
		CT_LOG_WRITELINE("Mode: ${CT_PROJECT_PROC_MODE}")
		CT_LOG_WRITELINE_PARTITION()
		return()
	else()
		CT_MODE_CHECK("LIB")
		CT_LOG_WRITELINE_NEWLINE()
		CT_LOG_WRITELINE_PARTITION()
		CT_CHECK_VARIABLE(CT_PROJECT_CONST_NAME)
		CT_LOG_WRITELINE("ProjectName: ${CT_PROJECT_CONST_NAME}")
		CT_CHECK_VARIABLE(CT_PROJECT_CONST_PATH)
		CT_LOG_WRITELINE("ProjectPath: ${CT_PROJECT_CONST_PATH}")
		CT_LOG_WRITELINE("Project Type: ${CT_PROJECT_TYPE}")
		CT_CHECK_VARIABLE(CT_PROJECT_LANGUAGE)
		CT_LOG_WRITELINE("Language: ${CT_PROJECT_LANGUAGE}")
		CT_CHECK_VARIABLE(CT_PROJECT_PROC_MODE)
		CT_LOG_WRITELINE("Mode: ${CT_PROJECT_PROC_MODE}")
		CT_LOG_WRITELINE_PARTITION()
	endif()

	if(${CT_PROJECT_PROC_MODE} STREQUAL "PLUGIN" OR ${CT_PROJECT_PROC_MODE} STREQUAL "ENABLE")
		enable_language(${CT_PROJECT_LANGUAGE})

		if(CT_PROJECT_PRE_CMAKESCRIPTS)
			CT_LOG_WRITELINE_PARTITION()
			CT_LOG_WRITELINE("Script file to run before the build script block")
			CT_LOG_WRITELINE_THIN_PARTITION()
			CT_LOG_WRITELINE_LIST(CT_PROJECT_PRE_CMAKESCRIPTS FALSE)
			CT_LOG_WRITELINE_PARTITION()

			foreach(sc ${CT_PROJECT_PRE_CMAKESCRIPTS})
				if(EXISTS "${CT_CONST_ROOT_PATH_CMAKEGLOBALS_SOURCE}/${sc}")
					include("${CT_CONST_ROOT_PATH_CMAKEGLOBALS_SOURCE}/${sc}")
				else()
					include("${CT_CONST_SEPCDIR_NAME_CMK}/${sc}")
				endif()
			endforeach()
		endif()

		if(${CT_PROJECT_PROC_MODE} STREQUAL "ENABLE")
			if(CT_PROJECT_FIND_PACKAGES)
				CT_LOG_WRITELINE_PARTITION()
				CT_LOG_WRITELINE("find packages")
				CT_LOG_WRITELINE_THIN_PARTITION()
				CT_LOG_WRITELINE_LIST(CT_PROJECT_FIND_PACKAGES FALSE)
				CT_LOG_WRITELINE_PARTITION()
				find_package(${CT_PROJECT_FIND_PACKAGES} REQUIRED)
			endif()

			CT_CHECK_VARIABLE(CT_PROJECT_CODEFILES)
			set(_TEMP_)

			foreach(item ${CT_PROJECT_CODEFILES})
				list(APPEND _TEMP_ "${CT_CONST_SEPCDIR_NAME_SRC}/${item}")
			endforeach()

			set(CT_PROJECT_CODEFILES ${_TEMP_})
			set(_TEMP_)

			if(CT_PROJECT_CODEFILES)
				CT_LOG_WRITELINE_PARTITION()
				CT_LOG_WRITELINE("sources")
				CT_LOG_WRITELINE_THIN_PARTITION()
				CT_LOG_WRITELINE_LIST(CT_PROJECT_CODEFILES FALSE)
				CT_LOG_WRITELINE_PARTITION()
			endif()

			list(POP_FRONT CT_PROJECT_CODEFILES _TEMP_)

			if(${CT_PROJECT_TYPE} STREQUAL "EXE")
				add_executable(${CT_PROJECT_CONST_NAME} ${_TEMP_})
			elseif(${CT_PROJECT_TYPE} STREQUAL "STLIB")
				add_library(${CT_PROJECT_CONST_NAME} STATIC ${_TEMP_})
			elseif(${CT_PROJECT_TYPE} STREQUAL "SALIB")
				add_library(${CT_PROJECT_CONST_NAME} SHARED ${_TEMP_})
			else()
				CT_THROW_ERROR("unknown project type")
			endif()

			if(CT_PROJECT_CODEFILES)
				target_sources(${CT_PROJECT_CONST_NAME} PRIVATE ${CT_PROJECT_CODEFILES})
			endif()

			unset(_TEMP_)

			if(CT_PROJECT_COMPILE_DEFINITIONS)
				CT_LOG_WRITELINE_PARTITION()
				CT_LOG_WRITELINE("compile definitions")
				CT_LOG_WRITELINE_THIN_PARTITION()
				CT_LOG_WRITELINE_LIST(CT_PROJECT_COMPILE_DEFINITIONS FALSE)
				CT_LOG_WRITELINE_PARTITION()
				target_compile_definitions(${CT_PROJECT_CONST_NAME} PRIVATE ${CT_PROJECT_COMPILE_DEFINITIONS})
			endif()

			if(CT_PROJECT_COMPILE_FEATURES)
				CT_LOG_WRITELINE_PARTITION()
				CT_LOG_WRITELINE("compile features")
				CT_LOG_WRITELINE_THIN_PARTITION()
				CT_LOG_WRITELINE_LIST(CT_PROJECT_COMPILE_FEATURES FALSE)
				CT_LOG_WRITELINE_PARTITION()
				target_compile_features(${CT_PROJECT_CONST_NAME} PRIVATE ${CT_PROJECT_COMPILE_FEATURES})
			endif()

			if(CT_PROJECT_COMPILE_OPTIONS)
				CT_LOG_WRITELINE_PARTITION()
				CT_LOG_WRITELINE("compile options")
				CT_LOG_WRITELINE_THIN_PARTITION()
				CT_LOG_WRITELINE_LIST(CT_PROJECT_COMPILE_OPTIONS FALSE)
				CT_LOG_WRITELINE_PARTITION()
				target_compile_options(${CT_PROJECT_CONST_NAME} PRIVATE ${CT_PROJECT_COMPILE_OPTIONS})
			endif()

			if(CT_PROJECT_INCLUDE_DIRECTORIES)
				CT_LOG_WRITELINE_PARTITION()
				CT_LOG_WRITELINE("include directories")
				CT_LOG_WRITELINE_THIN_PARTITION()
				CT_LOG_WRITELINE_LIST(CT_PROJECT_INCLUDE_DIRECTORIES TRUE)
				CT_LOG_WRITELINE_PARTITION()
				target_include_directories(${CT_PROJECT_CONST_NAME} PRIVATE ${CT_PROJECT_INCLUDE_DIRECTORIES})
			endif()

			if(CT_PROJECT_LINK_DIRECTORIES)
				CT_LOG_WRITELINE_PARTITION()
				CT_LOG_WRITELINE("Directories with linked libraries")
				CT_LOG_WRITELINE_THIN_PARTITION()
				CT_LOG_WRITELINE_LIST(CT_PROJECT_LINK_DIRECTORIES TRUE)
				CT_LOG_WRITELINE_PARTITION()
				target_link_directories(${CT_PROJECT_CONST_NAME} PRIVATE ${CT_PROJECT_LINK_DIRECTORIES})
			endif()

			if(CT_PROJECT_LINK_LIBRARIES)
				CT_LOG_WRITELINE_PARTITION()
				CT_LOG_WRITELINE("link libraries")
				CT_LOG_WRITELINE_THIN_PARTITION()
				CT_LOG_WRITELINE_LIST(CT_PROJECT_LINK_LIBRARIES FALSE)
				CT_LOG_WRITELINE_PARTITION()
				target_link_libraries(${CT_PROJECT_CONST_NAME} PRIVATE ${CT_PROJECT_LINK_LIBRARIES})
			endif()

			if(CT_PROJECT_LINK_OPTIONS)
				CT_LOG_WRITELINE_PARTITION()
				CT_LOG_WRITELINE("link options")
				CT_LOG_WRITELINE_THIN_PARTITION()
				CT_LOG_WRITELINE_LIST(CT_PROJECT_LINK_OPTIONS FALSE)
				CT_LOG_WRITELINE_PARTITION()
				target_link_options(${CT_PROJECT_CONST_NAME} PRIVATE ${CT_PROJECT_LINK_OPTIONS})
			endif()

			if(CT_PRECOMPILE_HEADERS)
				CT_LOG_WRITELINE_PARTITION()
				CT_LOG_WRITELINE("precompilation headers")
				CT_LOG_WRITELINE_THIN_PARTITION()
				CT_LOG_WRITELINE_LIST(CT_PRECOMPILE_HEADERS FALSE)
				CT_LOG_WRITELINE_PARTITION()
				target_precompile_headers(${CT_PROJECT_CONST_NAME} PRIVATE ${CT_PRECOMPILE_HEADERS})
			endif()
		else()
			foreach(sc ${CT_PROJECT_BUILD_SCRIPTS})
				if(EXISTS "${CT_CONST_ROOT_PATH_CMAKEGLOBALS_SOURCE}/${sc}")
					include("${CT_CONST_ROOT_PATH_CMAKEGLOBALS_SOURCE}/${sc}")
				else()
					include("${CT_CONST_SEPCDIR_NAME_CMK}/${sc}")
				endif()
			endforeach()

			if(NOT TARGET ${CT_PROJECT_CONST_NAME})
				add_custom_target(${CT_PROJECT_CONST_NAME})
			endif()
		endif()

		CT_LOG_WRITELINE_PARTITION()
		CT_LOG_WRITELINE("dependencies. before building the project. What to do and which projects to build first")
		CT_LOG_WRITELINE_THIN_PARTITION()
		CT_LOG_WRITELINE_LIST(CT_PROJECT_BUILD_PRE_CMAKESCRIPTS TRUE)
		CT_LOG_WRITELINE_LIST(CT_PROJECT_BUILD_POST_CMAKESCRIPTS TRUE)
		CT_LOG_WRITELINE_PARTITION()

		foreach(sc ${CT_PROJECT_BUILD_PRE_CMAKESCRIPTS})
			set(path "")

			if(EXISTS "${CT_CONST_ROOT_PATH_CMAKEGLOBALS_SOURCE}/${sc}")
				set(path "${CT_CONST_ROOT_PATH_CMAKEGLOBALS_SOURCE}/${sc}")
			else()
				set(path "${CT_PROJECT_CONST_PATH}/${CT_CONST_SEPCDIR_NAME_CMK}/${sc}")
			endif()

			add_custom_target(pre_build_target
				COMMENT "Pre-build target"
				PRE_BUILD
				COMMAND ${CMAKE_COMMAND} -P ${path}
				WORKING_DIRECTORY ${CT_PROJECT_CONST_PATH}
			)
			add_dependencies(${CT_PROJECT_CONST_NAME} pre_build_target)
		endforeach()

		foreach(sc ${CT_PROJECT_BUILD_POST_CMAKESCRIPTS})
			set(path "")

			if(EXISTS "${CT_CONST_ROOT_PATH_CMAKEGLOBALS_SOURCE}/${sc}")
				set(path "${CT_CONST_ROOT_PATH_CMAKEGLOBALS_SOURCE}/${sc}")
			else()
				set(path "${CT_PROJECT_CONST_PATH}/${CT_CONST_SEPCDIR_NAME_CMK}/${sc}")
			endif()

			add_custom_target(post_build_target
				COMMENT "Post-build target"
				POST_BUILD
				COMMAND ${CMAKE_COMMAND} -P ${path}
				WORKING_DIRECTORY ${CT_PROJECT_CONST_PATH}
			)
			add_dependencies(${CT_PROJECT_CONST_NAME} post_build_target)
		endforeach()

		CT_LOG_WRITELINE_PARTITION()
		CT_LOG_WRITELINE("Script files to be executed after the build script block")
		CT_LOG_WRITELINE_THIN_PARTITION()
		CT_LOG_WRITELINE_LIST(CT_PROJECT_POST_CMAKESCRIPTS FALSE)
		CT_LOG_WRITELINE_PARTITION()

		foreach(sc ${CT_PROJECT_POST_CMAKESCRIPTS})
			if(EXISTS "${CT_CONST_ROOT_PATH_CMAKEGLOBALS_SOURCE}/${sc}")
				include("${CT_CONST_ROOT_PATH_CMAKEGLOBALS_SOURCE}/${sc}")
			else()
				include("${CT_CONST_SEPCDIR_NAME_CMK}/${sc}")
			endif()
		endforeach()

		CT_LOG_WRITELINE_NEWLINE()
	endif()
endfunction()

function(CT_MAKE_CMAKEPRESETS)
	CT_MODE_CHECK("ROOT;SETUP")

	if(NOT EXISTS ${CT_CONST_ROOT_PATH_CMAKEPRESETS})
		CT_WRITE_TEXTFILE(${CT_CONST_ROOT_PATH_CMAKEPRESETS}
			"# \"https://github.com/TANAKADOREI/CMakeTemplate\"
# Files executed before the `project()` command in the root `cmakelists` file
"
		)
	endif()
endfunction()

#
function(CT_MAKE_ROOTCMAKELISTS)
	CT_MODE_CHECK("ROOT;SETUP")
	CT_WRITE_TEXTFILE(${CT_CONST_ROOT_PATH_CMAKELISTS}
		"# \"https://github.com/TANAKADOREI/CMakeTemplate\"
# Only edit the `project` command, don't edit the rest
#
cmake_minimum_required(VERSION ${CT_CONST_CMAKE_VERSION})

include(\"${CT_CONST_ROOT_PATH_CMAKEPRESETS}\")

project(
	\"CMAKETEMPLATEBYTANAKADOREI\"
	VERSION
	\"2023.5.11\"
	DESCRIPTION
	\"https://github.com/TANAKADOREI/CMakeTemplate\"
)
message(\"[${CT_CONST_ROOT_NAME_CMAKELISTS}]:\")
set(CT_MODE \"ROOT\")
include(\"${CT_CONST_ROOT_NAME_CMAKETEMPLATEBYTANAKADOREI}\")
message(\":[${CT_CONST_ROOT_NAME_CMAKELISTS}]\")
"
	)
endfunction()

function(CT_MAKE_CMAKEPROJECTS)
	CT_MODE_CHECK("ROOT;SETUP")

	if(NOT EXISTS ${CT_CONST_ROOT_PATH_CMAKEPROJECTS})
		CT_WRITE_TEXTFILE(${CT_CONST_ROOT_PATH_CMAKEPROJECTS}
			"# \"https://github.com/TANAKADOREI/CMakeTemplate\"
# Add your project name to `CT_PROJECTS`(list) variable
#

set(CT_PROJECTS

)
"
		)
	endif()
endfunction()

function(CT_MAKE_CMAKEDEPENDENCIES)
	CT_MODE_CHECK("ROOT;SETUP")

	if(NOT EXISTS ${CT_CONST_ROOT_PATH_CMAKEDEPENDENCIES})
		CT_WRITE_TEXTFILE(${CT_CONST_ROOT_PATH_CMAKEDEPENDENCIES}
			"# \"https://github.com/TANAKADOREI/CMakeTemplate\"
# This is a file that sets up project dependencies.
#

# add_dependencies()
"
		)
	endif()
endfunction()

if(${CT_MODE} STREQUAL "ROOT" OR ${CT_MODE} STREQUAL "SETUP")
	CT_LOG_WRITELINE_PARTITION()
	CT_LOG_WRITELINE("The current target system is `${CT_CURRENT_SYSTEM}`")
	CT_LOG_WRITELINE_PARTITION()
	CT_LOG_VERIFICATION_BEGIN(BUILD_ENV "Environment Configuration Validation" 4)
	CT_MAKE_CMAKEPRESETS()
	CT_LOG_VERIFICATION_UPDATE(BUILD_ENV "")
	CT_MAKE_CMAKEPROJECTS()
	CT_LOG_VERIFICATION_UPDATE(BUILD_ENV "")
	CT_MAKE_ROOTCMAKELISTS()
	CT_LOG_VERIFICATION_UPDATE(BUILD_ENV "")
	CT_MAKE_CMAKEDEPENDENCIES()
	CT_LOG_VERIFICATION_UPDATE(BUILD_ENV "")
	CT_LOG_VERIFICATION_END(BUILD_ENV)
	CT_LOG_WRITELINE_PARTITION()
endif()

if(${CT_MODE} STREQUAL "ROOT")
	file(GLOB_RECURSE sc "${CT_CONST_ROOT_PATH_CMAKEGLOBALS_INJECT}/*.cmake")

	foreach(s ${sc})
		include(${s})
	endforeach()

	include(${CT_CONST_ROOT_PATH_CMAKEPROJECTS})

	set(CT_PROJECT_LIST)
	set(CT_PROJECT_PATH_LIST)

	foreach(project_name ${CT_PROJECTS})
		CT_CHECK_NAME(${project_name})
		list(APPEND CT_PROJECT_LIST ${project_name})
		list(APPEND CT_PROJECT_PATH_LIST "${CT_CONST_ROOT_DIR_PATH}/${project_name}")
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
	CT_LOG_WRITELINE_PARTITION()
	CT_LOG_WRITELINE_NEWLINE()

	CT_LOG_WRITELINE_PARTITION()
	CT_LOG_WRITELINE("projects")
	CT_LOG_WRITELINE_THIN_PARTITION()

	foreach(project_path ${CT_PROJECT_PATH_LIST})
		list(FIND CT_PROJECT_PATH_LIST "${project_path}" INDEX)
		list(GET CT_PROJECT_LIST ${INDEX} project_name)

		if(${INDEX} EQUAL -1)
			CT_LOG_WRITELINE("[Create] ${project_path}")
		else()
			CT_LOG_WRITELINE("[Pass] ${project_path}")
		endif()

		CT_MAKE_PROJECTDIR("${project_name}")
	endforeach()

	CT_LOG_WRITELINE_PARTITION()

	foreach(project_path ${CT_PROJECT_PATH_LIST})
		add_subdirectory(${project_path})
	endforeach()

	include(${CT_CONST_ROOT_PATH_CMAKEDEPENDENCIES})
endif()

# └────────────────────────────────────────────────────────────────────────────────────────────────────────┘
CT_INNER_OPTIONS_UNSET()
