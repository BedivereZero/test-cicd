cicd::version::get_version_vars() {
  CICD_VERSION=$(git describe --tags)

  if CICD_VERSION=$(git describe --tags --match='v*' 2>/dev/null); then
    # remove prefix "v"
    CICD_VERSION="${CICD_VERSION/v/}"
    DASH_IN_VERSION=$(echo "${CICD_VERSION}" | sed 's/[^-]//g')
    if [[ "${DASH_IN_VERSION}" == "---" ]]; then
      # v0.1.0-alpha.0-4-g09078d4
      CICD_VERSION=$(echo "${CICD_VERSION}" | sed 's/-\([0-9]\{1,\}\)-g\([0-9a-f]\{7\}\)$/.\1+\2/')
    elif [[ "${DASH_IN_VERSION}" == "--" ]]; then
      # v0.1.0-3-g8645975
      CICD_VERSION=$(echo "${CICD_VESRION}" | sed 's/-g\([0-9a-f]\{7\}\)$/+\1/')
    fi
  fi

  CICD_BUILD_DATE=$(date -u +%Y-%m-%dT%H:%M:%SZ)

  CICD_GIT_COMMIT=$(git rev-parse HEAD)

  if git_status=$(git stats --porcelain 2>/dev/null) && [[ -z "${git_status}" ]]; then
    CICD_GIT_TREE_STATE="clean"
  else
    CICD_GIT_TREE_STATE="dirty"
    CICD_VERSION+="-dirty"
  fi
}

cicd::version::ldflags() {
  cicd::version::get_version_vars

  local -a ldflags
  function add_ldflag() {
    local key=$1
    local val=$2
    ldflags+=(
      "-X 'github.com/BedivereZero/test-cicd/version.${key}=${val}'"
    )
  }

  add_ldflag "version"      "${CICD_VERSION}"
  add_ldflag "buildDate"    "${CICD_BUILD_DATE}"
  add_ldflag "gitCommit"    "${CICD_GIT_COMMIT}"
  add_ldflag "gitTreeState" "${CICD_GIT_TREE_STATE}"

  echo "${ldflags[*]}"
}
