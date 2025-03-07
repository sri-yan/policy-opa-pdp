#!/bin/bash
#  ============LICENSE_START=======================================================
#   Copyright (C) 2024 Deutsche Telekom Intellectual Property. All rights reserved.
#  ================================================================================
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.
#
#  SPDX-License-Identifier: Apache-2.0
#  ============LICENSE_END=========================================================

#===MAIN===#
if [ -z "${WORKSPACE}" ]; then
    export WORKSPACE=$(git rev-parse --show-toplevel)
fi

export TESTDIR=${WORKSPACE}/testsuites
export OPA_PERF_TEST_FILE=$TESTDIR/performance/src/main/resources/testplans/perf.jmx
export OPA_STAB_TEST_FILE=$TESTDIR/stability/src/main/resources/testplans/stability.jmx

if [ $1 == "run" ]
then

  mkdir automate-s3p-test;cd automate-s3p-test;
  git clone "https://gerrit.onap.org/r/policy/docker"
  cd docker/csit

  if [ $2 == "performance" ]
  then
    bash start-s3p-tests.sh run $OPA_PERF_TEST_FILE opa-pdp;
  elif [ $2 == "stability" ]
  then
    bash start-s3p-tests.sh run $OPA_STAB_TEST_FILE opa-pdp;
  else
    echo "echo Invalid arguments provided. Usage: $0 [option..] {performance | stability}"
  fi

else
  echo "Invalid arguments provided. Usage: $0 [option..] {run | uninstall}"
fi

