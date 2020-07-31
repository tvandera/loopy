# Install and build the Loopy system
# Please customize settings in the section immediately below. 

# =========================== Customize =========================== 

# Loopy root directory
ROOT_DIR=$(shell pwd)

# Number of processors to run make on 
PAR_BUILD=8


# =========================== Derived =========================== 
# LLVM root directory
LLVM_DIR=${ROOT_DIR}/llvm-project
LLVM_BUILD_DIR=${ROOT_DIR}/build

# Tests directory
TESTS_DIR=${ROOT_DIR}/tests

# =========================== Build rules =========================== 
.PHONY: all setup get_llvm get_clang get_loopy build test

all: setup get_llvm get_loopy get_clang build 

setup: 
	mkdir -p ${LLVM_BUILD_DIR}
	git submodule update --init

# build LLVM + loopy
build: setup
	(   cd ${LLVM_BUILD_DIR} && \
	    cmake -G 'Unix Makefiles' ../llvm-project/llvm \
	      -DLLVM_EXTERNAL_CLANG_SOURCE_DIR=../llvm-project/clang \
	      -DLLVM_EXTERNAL_POLLY_SOURCE_DIR=../llvm-project/polly && \
	    make -j ${PAR_BUILD} \
	)


# =========================== Test =========================== 
# run Loopy tests
test: 
	cd ${TESTS_DIR}; \
	sh clean-up.sh; \
	sh run-all-tests.sh ${LLVM_BUILD_DIR}

