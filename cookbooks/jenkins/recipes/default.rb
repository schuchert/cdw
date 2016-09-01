bash 'install jenkins' do
  code <<-EOF
    wget -q -O - http://pkg.jenkins-ci.org/debian-stable/jenkins-ci.org.key | sudo apt-key add -
    sudo sh -c 'echo deb http://pkg.jenkins-ci.org/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
    sudo apt-get update
    sudo apt-get install -y jenkins
    sed -i "s/HTTP_PORT=8080/HTTP_PORT=9983/g" /etc/default/jenkins
    service jenkins restart
  EOF
end
