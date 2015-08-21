#!/bin/bash

Add_LNMP_Startup()
{
    echo "Add Startup and Starting LNMP ..."
    \cp ${cur_dir}/conf/lnmp /bin/lnmp
    chmod +x /bin/lnmp
    if [[ "${DBSelect}" = "4" || "${DBSelect}" = "5" ]]; then
        StartUp mariadb
        /etc/init.d/mariadb start
        sed -i 's#/etc/init.d/mysql#/etc/init.d/mariadb#' /bin/lnmp
    else
        StartUp mysql
        /etc/init.d/mysql start
    fi
    StartUp php-fpm
    /etc/init.d/php-fpm start
    if [ "${PHPSelect}" = "1" ]; then
        sed -i 's#/usr/local/php/var/run/php-fpm.pid#/usr/local/php/logs/php-fpm.pid#' /bin/lnmp
    fi
    StartUp nginx
    /etc/init.d/nginx start    
}

Add_LAMP_Startup()
{
    echo "Add Startup and Starting LAMP ..."
    \cp ${cur_dir}/conf/lamp /bin/lnmp
    chmod +x /bin/lnmp
    if [[ "${DBSelect}" = "4" || "${DBSelect}" = "5" ]]; then
        StartUp mariadb
        /etc/init.d/mariadb start
        sed -i 's#/etc/init.d/mysql#/etc/init.d/mariadb#' /bin/lnmp
    else
        StartUp mysql
        /etc/init.d/mysql start
    fi
    StartUp httpd
    /etc/init.d/httpd start    
}

Add_LNAMP_Startup()
{
    echo "Add Startup and Starting LNAMP ..."
    \cp ${cur_dir}/conf/lnamp /bin/lnmp
    chmod +x /bin/lnmp
    if [[ "${DBSelect}" = "4" || "${DBSelect}" = "5" ]]; then
        StartUp mariadb
        /etc/init.d/mariadb start
        sed -i 's#/etc/init.d/mysql#/etc/init.d/mariadb#' /bin/lnmp
    else
        StartUp mysql
        /etc/init.d/mysql start
    fi
    StartUp nginx
    /etc/init.d/nginx start    
    StartUp httpd
    /etc/init.d/httpd start
}

Check_Nginx_Files()
{
    isNginx=""
    echo "============================== Check install =============================="
    echo "Checking ..."
    if [[ -s /usr/local/nginx/conf/nginx.conf && -s /usr/local/nginx/sbin/nginx ]]; then
        Echo_Green "Nginx: OK"
        isNginx="ok"
    else
        Echo_Red "Error: Nginx install failed."
    fi
}

Check_DB_Files()
{
    isDB=""
    if [[ "${DBSelect}" = "4" || "${DBSelect}" = "5" ]]; then
        if [[ -s /usr/local/mariadb/bin/mysql && -s /usr/local/mariadb/bin/mysqld_safe && -s /etc/my.cnf ]]; then
            Echo_Green "MariaDB: OK"
            isDB="ok"
        else
            Echo_Red "Error: MariaDB install failed."
        fi
    else
        if [[ -s /usr/local/mysql/bin/mysql && -s /usr/local/mysql/bin/mysqld_safe && -s /etc/my.cnf ]]; then
            Echo_Green "MySQL: OK"
            isDB="ok"
        else
            Echo_Red "Error: MySQL install failed."
        fi
    fi
}

Check_PHP_Files()
{
    isPHP=""
    if [ "${Stack}" = "lnmp" ]; then
        if [[ -s /usr/local/php/sbin/php-fpm && -s /usr/local/php/etc/php.ini && -s /usr/local/php/bin/php ]]; then
            Echo_Green "PHP: OK"
            Echo_Green "PHP-FPM: OK"
            isPHP="ok"
        else
            Echo_Red "Error: PHP install failed."
        fi
    else
        if [[ -s /usr/local/php/bin/php && -s /usr/local/php/etc/php.ini ]]; then
            Echo_Green "PHP: OK"
            isPHP="ok"
        else
            Echo_Red "Error: PHP install failed."
        fi
    fi
}

Check_Apache_Files()
{
    isApache=""
    if [[ -s /usr/local/apache/bin/httpd && -s /usr/local/apache/modules/libphp5.so && -s /usr/local/apache/conf/httpd.conf ]]; then
        Echo_Green "Apache: OK"
        isApache="ok"
    else
        Echo_Red "Error: Apache install failed."
    fi
}

Print_Success_Info()
{
    echo "+------------------------------------------------------------------------+"
    echo "|             LNMP Shell Ver ${LNMP_Ver} for ${DISTRO} Linux Server                 |"
    echo "|                           Written by Licess                            |"
    echo "|                         Modified by shines77                           |"
    echo "+------------------------------------------------------------------------+"
    echo "|     For more information please visit http://lnmp.cloudbuses.com       |"
    echo "+------------------------------------------------------------------------+"
    echo "|    lnmp status manage: lnmp {start|stop|reload|restart|kill|status}    |"
    echo "+------------------------------------------------------------------------+"
    echo "|  phpMyAdmin: http://YourIP/phpmyadmin/                                 |"
    echo "|  phpinfo:    http://YourIP/phpinfo.php                                 |"
    echo "|  Prober:     http://YourIP/p.php                                       |"
    echo "+------------------------------------------------------------------------+"
    echo "|  Add VirtualHost: lnmp vhost add                                       |"
    echo "+------------------------------------------------------------------------+"
    echo "|  Default directory: /home/wwwroot/default                              |"
    echo "+------------------------------------------------------------------------+"
    echo "|  MySQL/MariaDB root password: ${MysqlRootPWD}                          |"
    echo "+------------------------------------------------------------------------+"
    lnmp status
    netstat -ntl
    Echo_Green "Install lnmp_shell Ver ${LNMP_Ver} completed! enjoy it."
}

Print_Failed_Info()
{
    Echo_Red "Sorry, Failed to install ${Stack} shell!"
    Echo_Red "Please visit http://bbs.vpser.net/forum-25-1.html feedback errors and logs."
    Echo_Red "You can download /root/lnmp-install.log from your server, and upload lnmp-install.log to LNMP-Shell Forum."
}

Check_LNMP_Install()
{
    Check_DB_Files
    Check_PHP_Files
    Check_Nginx_Files    
    if [[ "$isNginx" = "ok" && "$isDB" = "ok" && "$isPHP" = "ok" ]]; then
        Print_Success_Info
    else
        Print_Failed_Info
    fi
}

Check_LAMP_Install()
{
    Check_DB_Files
    Check_PHP_Files
    Check_Apache_Files
    if [[ "$isApache" = "ok" && "$isDB" = "ok" && "$isPHP" = "ok" ]]; then
        Print_Success_Info
    else
        Print_Failed_Info
    fi
}

Check_LNAMP_Install()
{
    Check_DB_Files
    Check_PHP_Files
    Check_Nginx_Files
    Check_Apache_Files
    if [[ "$isNginx" = "ok" && "$isDB" = "ok" && "$isPHP" = "ok"  &&"$isApache" = "ok" ]]; then
        Print_Success_Info
    else
        Print_Failed_Info
    fi
}
