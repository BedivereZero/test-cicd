CICD_GO_PACKAGE="github.com/BedivereZero/test-cicd"
CICD_GOBIN="${PWD}/bin"

cicd::golang::build_binary() {
  # Create a sub-shell so that we don't pollute the outer environment
  (
    goldflags="${GOLDFLAGS=-s -w} $(cicd::version::ldflags)"

    local -a build_args
    build_args=(
      -installsuffix static
      -ldflags "${goldflags}"
    )

    # build for linux/amd64
    # build static binary
    GOBIN="${CICD_GOBIN}" CGO_ENABLED=0 go install "${build_args[@]}" "${CICD_GO_PACKAGE}"
  )
}
