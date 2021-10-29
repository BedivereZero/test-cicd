# Build container image for specified binary
# Outputs:
#   STDOUT  - container image id
function cicd::buildah::build_image {
  local base binary tag

  base="alpine:3.14.2"
  binary="test-cicd"
  tag="${CICD_VERSION/+/_}"

  container="$(buildah from --name="${binary}-$(date -u +%Y-%m-%d-%H-%M-%S)" "${base}")"
  buildah copy    --contextdir="${PWD}" --quiet     "${container}" "/bin/${binary}" "/usr/local/bin/${binary}"
  buildah config  --author="BedivereZero@gmail.com" "${container}"
  buildah config  --cmd="/usr/local/bin/${binary}"  "${container}"
  buildah commit  --quiet --rm                      "${container}" "oci-archive:bin/${binary}.tar"
  echo "${tag}" > "bin/${binary}.tag"
}
