out "install NRI plugin"
NRI_BIN="$NRI_BIN_DIR/blockio-nri"
[ -f "$NRI_BIN" ] ||
    error "blockio-nri binary ($NRI_BIN) missing, run make"
vm-put-file "$NRI_BIN" "/opt/nri/bin/$(basename "$NRI_BIN")"
vm-put-file "$E2E_DIR/dlv-attach-NRIPLUGIN" "/opt/nri/bin/dlv-attach-NRIPLUGIN"

out "configure NRI plugin"
cat <<EOF | vm-pipe-to-file "/etc/nri/conf.json"
{
    "version": "0.1",
    "plugins": [
        {
            "type": "blockio-nri",
            "conf": {
                "myconf": "helloworld"
            }
        }
    ]
}
