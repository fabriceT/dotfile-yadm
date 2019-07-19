function toggle-monitoring
    if systemctl is-active prometheus > /dev/null
        set sys_command "stop"
        echo "Stopping prometheus"
    else
        set sys_command "start"
        echo "Starting prometheus"
    end
    
    sudo systemctl $sys_command prometheus prometheus-{node,sql,blackbox}-exporter grafana

end
