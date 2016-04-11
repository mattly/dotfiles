action=$1
shell=$2
shift 2

case $action in
    status)
        bake cat /etc/shells | grep "$shell"
        [ "$?" -gt 0 ] && return $STATUS_MISSING
        return $STATUS_OK
    ;;

    install|upgrade)
        sudo echo "$shell" >> /etc/shells
    ;;

    *) return 1 ;;
esac
