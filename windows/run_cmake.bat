@echo off

setlocal EnableExtensions EnableDelayedExpansion

set HUNTER_BASE=C:\.hunter\_Base\10738b5\5b6b14d\000d2c7
set VCPKG_DEFAULT_HOST_TRIPLET=x64-windows
set CMAKE_ARGS=

rem Clean up previous runs
if exist old.9 rd /s /q old.9
if exist old.8 move old.8 old.9
if exist old.7 move old.7 old.8
if exist old.6 move old.6 old.7
if exist old.5 move old.5 old.6
if exist old.4 move old.4 old.5
if exist old.3 move old.3 old.4
if exist old.2 move old.2 old.3
if exist old.1 move old.1 old.2
if exist old move old old.1
mkdir old
move INSTALL old 2>NUL
move *.out old 2>NUL
move *.log old 2>NUL
move *.txt old 2>NUL
if "%~1" == "clean" (
	shift
	echo Cleaning subdirectories
	move CMakeFiles old 2>NUL
	move _3rdparty old 2>NUL
	move _deps old 2>NUL
	move lib old 2>NUL
	move third_party old 2>NUL
)

set OLD_LIB=%LIB%
set OLD_LIBPATH=%LIBPATH%
set OLD_INCLUDE=%INCLUDE%
set OLD_PATH=%PATH%

rem echo *** Before
rem echo LIB %LIB% >> before.txt
rem echo LIBPATH %LIBPATH% >> before.txt
rem echo INCLUDE %INCLUDE% >> before.txt
rem echo PATH %PATH% >> before.txt
rem type before.txt

if exist "C:\vcpkg\downloads\tools\perl\5.32.1.1\perl\bin" set PERL_DIR=C:\vcpkg\downloads\tools\perl\5.32.1.1\perl\bin
if exist "C:\perl64\perl\bin" set PERL_DIR=C:\perl64\perl\bin
perl --version 2>NUL
if %errorlevel% neq 0 set PATH=%PERL_DIR%;%PATH%
if %errorlevel% neq 0 perl --version 2>NUL
if %errorlevel% neq 0 (
	echo ERROR: Missing perl error %ERRORLEVEL%
	goto :EOF
)

if "%VCPKG_DEFAULT_TRIPLET%" == "" (
  echo Setting VCPKG_DEFAULT_TRIPLET to x64-windows
  set VCPKG_DEFAULT_TRIPLET=x64-windows
)
echo VCPKG_DEFAULT_TRIPLET="%VCPKG_DEFAULT_TRIPLET%"

if not exist "%VCPKG_ROOT%" (
  echo VCPKG_ROOT is not set
  set VCPKG_ROOT=c:\vcpkg
)
echo VCPKG_ROOT="%VCPKG_ROOT%"

set CMAKE_ARGS=-Wno-dev -DCMAKE_BUILD_TYPE=Release
set CMAKE_ARGS=%CMAKE_ARGS% -DCMAKE_VERBOSE_MAKEFILE=ON -DDEBUG=ON -DHUNTER_STATUS_DEBUG=ON -DHUNTER_TLS_VERIFY=OFF
set CMAKE_ARGS=%CMAKE_ARGS% -DBUILD_SHARED_LIBS=OFF -DHUNTER_BUILD_SHARED_LIBS=OFF
set CMAKE_ARGS=%CMAKE_ARGS% -DSILKPRE_TESTING=OFF

if "%~1" == "clang" (
	shift
	set CMAKE_ARGS=-DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang+ -DCMAKE_TOOLCHAIN_FILE=../cmake/clang-libcxx20-fpic.cmake %CMAKE_ARGS%
) else (
	set CMAKE_ARGS=%CMAKE_ARGS% -DCMAKE_CXX_STANDARD_COMPUTED_DEFAULT=MSVC -DCMAKE_CXX_EXTENSIONS_COMPUTED_DEFAULT=MSVC
	rem set CMAKE_ARGS=%CMAKE_ARGS% -DCMAKE_TOOLCHAIN_FILE=C:/vcpkg/scripts/buildsystems/vcpkg.cmake
	rem set CMAKE_ARGS=%CMAKE_ARGS% -DVCPKG_PREFER_SYSTEM_LIBS=ON
	rem set CMAKE_ARGS=%CMAKE_ARGS% -DX_VCPKG_APPLOCAL_DEPS_INSTALL=ON
)
set CMAKE_ARGS=%CMAKE_ARGS% -DCMAKE_C_FLAGS="-D_WIN32_WINDOWS=0x0A00 -D_WIN32_WINDOWS=0x0A00 -DWIN32 -D_WIN32 -DWIN64 -D_WIN64 -DWINDOWS -D_WINDOWS -D_CRT_SECURE_NO_WARNINGS"

set GMP_LIBRARY=C:\vcpkg\packages\mpir_x64-windows-static\lib\mpir.lib
set GMP_INCLUDE_DIR=C:\vcpkg\packages\mpir_x64-windows-static\include
set INCLUDE=%GMP_INCLUDE_DIR%;%INCLUDE%
set LIB=%GMP_LIBRARY%;%LIB%

set LIBPATH=%LIB%

rem echo *** After
rem echo LIB %LIB% >> after.txt
rem echo LIBPATH %LIBPATH% >> after.txt
rem echo INCLUDE %INCLUDE% >> after.txt
rem echo PATH %PATH% >> after.txt
rem type after.txt

echo *** Running: cmake %CMAKE_ARGS% -S .. -B .
cmake %CMAKE_ARGS%  -S .. -B .
echo cmake returned %ERRORLEVEL%

:finished
set EXITVALUE=%ERRORLEVEL%
set LIB=%OLD_LIB%
set LIBPATH=%OLD_LIBPATH%
set INCLUDE=%OLD_INCLUDE%
set PATH=%OLD_PATH%

rem echo *** Finished exit value %EXITVALUE%
rem echo LIB %OLD_LIB% >> finished.txt
rem echo LIBPATH %OLD_LIBPATH% >> finished.txt
rem echo INCLUDE %OLD_INCLUDE% >> finished.txt
rem echo PATH %OLD_PATH% >> finished.txt
rem type finished.txt

exit /b %EXITVALUE%
