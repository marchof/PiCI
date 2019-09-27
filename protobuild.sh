#!/bin/bash
set -e -o pipefail

# Absolute path of the project directory
PROJECT_DIR="$(dirname $(realpath $0))"

# Projekt name
PROJECT_NAME="$(basename ${PROJECT_DIR})"

# Shared working directory for this project
WORKSPACE_DIR="${PROJECT_DIR}/workspace"

# Build ID is the UTC timestamp
BUILDID="$(date -u "+%Y%m%d-%H%M%S")"

# Base directory for all outputs
OUTPUT_BASE_DIR="${PROJECT_DIR}/output"

# Output directory for this build
OUTPUT_DIR="${OUTPUT_BASE_DIR}/${BUILDID}"

# Log output for this build
BUILDLOG_FILE="${OUTPUT_DIR}/build.log"

# Artifacts directory for this build
ARTIFACTS_DIR="${OUTPUT_DIR}/artifacts"

# Link to the latest build
LATEST_LN="${OUTPUT_BASE_DIR}/latest"

# Link to the last successful build
LASTSUCCESSFUL_LN="${OUTPUT_BASE_DIR}/lastSuccessful"

# File unambiguously identifying the specific input of this build
INPUT_FILE="${OUTPUT_DIR}/INPUT"


# =============================================================================
# Template methods that can be re-defined in specific builds
# =============================================================================

doFetchInput() {
	echo "No input"
}

doGetInputInfo() {
	echo "None"
}

doRunBuild() {
	# This function is executed in a checked section (caused by an if statement)
	# Therefore all commands are executed regardless of failures. Only the exit
	# status of the last command determines the build status. Multiple command should
	# therefore typically concatenated with &&
	echo "Some build action" &&
	echo "Hello Build!" > "${ARTIFACTS_DIR}/artifact.txt"
}


# =============================================================================
# Utility methods to be used in specific builds
# =============================================================================

fetchGitRepo() {
	REPO_URL="$1"
	echo "Git repo ${REPO_URL}"
	if [ -d "${WORKSPACE_DIR}/.git" ]; then
		git -C ${WORKSPACE_DIR} pull
	else
		git clone ${REPO_URL} ${WORKSPACE_DIR} 2>&1
	fi
}

getGitInputInfo() {
	git -C ${WORKSPACE_DIR} log -1
}


# =============================================================================
# Build engine implementation
# =============================================================================

_prefixOutput() {
	while IFS= read -r line; do printf '%s [%s] %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "${PROJECT_NAME}" "$line"; done
}

_run() {
	echo "Start build ${BUILDID}"

	echo "Create workspace directory ${WORKSPACE_DIR}"
	mkdir -p "${WORKSPACE_DIR}"

	echo "Fetch input"
	doFetchInput
	INPUT_INFO="$(doGetInputInfo)"

	if [[ $(cat "${LATEST_LN}/INPUT" 2>/dev/null || true) != "${INPUT_INFO}" ]]; then
		echo "Create output directory ${OUTPUT_DIR}"
		mkdir -p "${OUTPUT_DIR}"
		mkdir -p "${ARTIFACTS_DIR}"
		ln -sfn "${BUILDID}" "${LATEST_LN}"
		echo "${INPUT_INFO}" > ${INPUT_FILE}

		echo "Run build"
		if doRunBuild > "${BUILDLOG_FILE}" 2>&1; then
			echo "Build successful"
			ln -sfn "${BUILDID}" "${LASTSUCCESSFUL_LN}"
		else
			echo "Build failed"
		fi
	else
		echo "Skip build due to unchanged input"
	fi
}

run() {
  _run | _prefixOutput
}