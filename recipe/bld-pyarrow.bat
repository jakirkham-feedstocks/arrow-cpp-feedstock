pushd "%SRC_DIR%"\python

SET ARROW_HOME=%LIBRARY_PREFIX%
SET SETUPTOOLS_SCM_PRETEND_VERSION=%PKG_VERSION%
SET PYARROW_BUILD_TYPE=release
SET PYARROW_WITH_DATASET=1
SET PYARROW_WITH_FLIGHT=1
SET PYARROW_WITH_GANDIVA=1
SET PYARROW_WITH_GCS=1
SET PYARROW_WITH_HDFS=1
SET PYARROW_WITH_PARQUET=1
SET PYARROW_WITH_PARQUET_ENCRYPTION=1
SET PYARROW_WITH_S3=1
SET PYARROW_WITH_SUBSTRAIT=1
SET PYARROW_CMAKE_GENERATOR=Ninja

:: Enable CUDA support
if "%cuda_compiler_version%"=="None" (
    set "PYARROW_WITH_CUDA=0"
) else (
    set "PYARROW_WITH_CUDA=1"
)

%PYTHON%   setup.py ^
           build_ext ^
           install --single-version-externally-managed ^
                   --record=record.txt
if errorlevel 1 exit 1
popd

if [%PKG_NAME%] == [pyarrow] (
    rd /s /q %SP_DIR%\pyarrow\tests
)
