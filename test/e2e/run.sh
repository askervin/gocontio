#!/bin/bash

E2E_DIR="$(realpath "$(dirname "$0")")"
NRI_BIN_DIR="$(realpath "$E2E_DIR/../../bin")"

CRI_RESMGR_E2E_RUN=${CRI_RESMGR_E2E_RUN:-"$(realpath "$E2E_DIR/../../../../intel/cri-resource-manager/test/e2e")/run.sh"}

error() {
    msg="$1"
    echo "error: $msg" >&2
    exit 1
}

echo E2E_DIR=$E2E_DIR
echo CRI_RESMGR_E2E_RUN=$CRI_RESMGR_E2E_RUN

[ -f "$CRI_RESMGR_E2E_RUN" ] ||
    error "cannot find $CRI_RESMGR_E2E_RUN, go get -d github.com/intel/cri-resource-manager"

export NRI_BIN_DIR E2E_DIR
outdir=${outdir:-$E2E_DIR/output} cri=containerd on_vm_online=${on_vm_online:-'crisrc=distro vm-install-cri; vm-command "systemctl stop containerd"; crisrc=local vm-install-cri; vm-command "systemctl start containerd"'} exec "$CRI_RESMGR_E2E_RUN" "$@"
