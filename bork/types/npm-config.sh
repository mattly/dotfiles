action=$1
key=$2
value=$3
shift 3

case $action in
    status)
        needs_exec "npm" || return $STATUS_FAILED_PRECONDITION
        current=$(bake npm config get $key)
        [ "$current" = "undefined" ] && return $STATUS_MISSING
        if [ "$current" != "$value" ]; then
            echo "received value: $current"
            echo "expected value: $value"
            return $STATUS_MISMATCH_UPGRADE
        fi
        return $STATUS_OK
    ;;

    install|upgrade)
        bake npm config set "$key" "$value"
    ;;

    *) return 1 ;;
esac
