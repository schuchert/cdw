bash 'install gitblit' do
  code <<-EOF
    APP=gitblit
    VER=1.8.0
    GITBLIT=$APP-$VER
    SSH_PORT=29677 
    HTTP_PORT=7765
    DEST=/opt/$APP
    yes "" | adduser $APP &> /dev/null
    if [ ! -f /tmp/$GITBLIT.tar.gz ]; then
        wget -P /tmp http://dl.bintray.com/gitblit/releases/$GITBLIT.tar.gz
    fi
    
    if [ ! -f $DEST ]; then
        mkdir -p $DEST
        tar xf /tmp/$GITBLIT.tar.gz --strip-components=1 -C $DEST
        echo "server.httpPort=$HTTP_PORT" >> $DEST/data/gitblit.properties
        echo "git.sshPort=$SSH_PORT" >> $DEST/data/gitblit.properties
        cd $DEST
        sh install-service-ubuntu.sh
    fi
    
    chown -R $APP:$APP $DEST
    /etc/init.d/$APP start
  EOF
end
