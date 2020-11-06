# out "install NRI plugin"
# NRI_BIN="$NRI_BIN_DIR/blockio-nri"
# [ -f "$NRI_BIN" ] ||
#     error "blockio-nri binary ($NRI_BIN) missing, run make"
# vm-put-file "$NRI_BIN" "/opt/nri/bin/$(basename "$NRI_BIN")"
vm-put-file "$E2E_DIR/nri-plugin-wrapper" "/opt/nri/bin/nri-plugin-wrapper"
vm-command "ln -s /opt/nri/bin/nri-plugin-wrapper /opt/nri/bin/record-blockio-nri"

out "configure NRI plugin"
cat <<EOF | vm-pipe-to-file "/etc/nri/conf.json"
{
    "version": "0.1",
    "plugins": [
        {
            "type": "record-blockio-nri",
            "conf": {
                "myconf": "helloworld"
            }
        }
    ]
}
