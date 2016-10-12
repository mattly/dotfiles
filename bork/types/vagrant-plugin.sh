action=$1
plugin=$2

case $action in
    status)
        needs_exec "vagrant" || return $STATUS_FAILED_PRECONDITION
        o=$(bake vagrant plugin list | grep $plugin)
        [ "$?" -gt 0 ] && return $STATUS_MISSING
        return $STATUS_OK
        ;;
    install)
        vagrant plugin install $plugin
        ;;
    *) return 1 ;;
esac
