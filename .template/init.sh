#!/bin/bash

print_help() {
  if [[ $# != 0 ]]; then
    echo "ERROR with: $@"
    echo
  fi

cat << END_OF_HELP
Usage -- initalize a subtree directory with predefined code
END_OF_HELP

}

CUR_DIR=`pwd`
SUB_DIR=${1//./\/}

if [[ "${SUB_DIR}" == "" ]]; then
  print_help
  exit 0
fi

if [[ -e ${SUB_DIR} ]]; then
  echo "Sub directory:${SUB_DIR} has been created"
  exit
fi

mkdir -p ${SUB_DIR}

cd ${SUB_DIR}

cat > main.cpp << END_OF_DEFINE
#include "solution.h"

using namespace std;

// int main(int argc, char** argv) {
int main() {
  File f("./input.txt");

  return 0;
} 
END_OF_DEFINE

cat > solution.h << END_OF_DEFINE
#ifndef SOLUTION_H
#define SOLUTION_H

#include <ioutils.h>
#include <leetcode.h>
#include <times.h>
#include <common_header.h>

#endif // SOLUTION_H
END_OF_DEFINE

TAB=$'\t'
cat > Makefile << END_OF_DEFINE
.PHONY: all compile run prepare clean

BUILD := build
INCLUDE := ${CUR_DIR}/include
BIN := bin
SRCS := \$(wildcard *.cpp)

all: compile run

compile: \${SRCS} prepare
${TAB}@echo "Compile into \${BUILD}/\${BIN}..."
${TAB}g++ -o \${BUILD}/\${BIN} $< -std=c++11 -I\${INCLUDE} -g

run: compile
${TAB}@echo "Run with \${BUILD}/\${BIN}..."
${TAB}@\${BUILD}/\${BIN}

prepare:
${TAB}@mkdir -p \${BUILD}

clean:
${TAB}rm -rf \${BUILD}/\${BIN}
END_OF_DEFINE

cat > input.txt << END_OF_INPUT
# paste your test input at belows
END_OF_INPUT

cat > output.txt << END_OF_OUTPUT
# paste your test output at belows
END_OF_OUTPUT
