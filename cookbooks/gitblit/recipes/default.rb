bash 'install gitblit' do
  code <<-EOF
    APP=gitblit
    VER=1.8.0
    GITBLIT=$APP-$VER
    SSH_PORT=29677 
    HTTP_PORT=7765
    DEST=/opt/$APP
    PROP=$DEST/data/gitblit.properties
    yes "" | adduser $APP &> /dev/null
    if [ ! -f /tmp/$GITBLIT.tar.gz ]; then
        wget -P /tmp http://dl.bintray.com/gitblit/releases/$GITBLIT.tar.gz
    fi
    
    if [ ! -f $DEST ]; then
        mkdir -p $DEST
        tar xf /tmp/$GITBLIT.tar.gz --strip-components=1 -C $DEST
        echo "server.httpPort=$HTTP_PORT" >> $PROP
        echo "git.sshPort=$SSH_PORT" >> $PROP
        cd $DEST
        sh install-service-ubuntu.sh
    else
        sed -i "/^server.httpPort=[0-9]\+$/d" $PROP
        sed -i "/^git.sshPort=[0-9]\+$/d" $PROP
        echo "server.httpPort=$HTTP_PORT" >> $PROP
        echo "git.sshPort=$SSH_PORT" >> $PROP
        service gitblit restart
    fi


    chown -R $APP:$APP $DEST
    /etc/init.d/$APP start
  EOF
end
