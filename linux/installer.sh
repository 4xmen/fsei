if [ ! -d '/opt/sdk/cmdline-tools/latest/bin' ]; then
    echo '- START install flutter';
    # install jdk snapcraft & etc...
    sudo apt-get install snapd openjdk-11-jdk unzip git zsh wget  -y
    # install flutter
    sudo snap install flutter --classic
    # add env var to all source
    echo 'source /etc/environment'  | sudo tee -a /etc/profile
    echo 'source /etc/environment'  | tee -a /home/$USER/.bashrc
    echo 'source /etc/environment'  | tee -a /home/$USER/.zshrc
    # make folder to install
    sudo mkdir /opt/sdk
    sudo chmod 777 /opt/sdk
    cd /opt/sdk
    # install andriod studio
    wget https://redirector.gvt1.com/edgedl/android/studio/ide-zips/2020.3.1.23/android-studio-2020.3.1.23-linux.tar.gz
    tar -xvzf android-studio-2020.3.1.23-linux.tar.gz
    # install sdk command line
    wget https://dl.google.com/android/repository/commandlinetools-linux-7583922_latest.zip
    unzip commandlinetools-linux-7583922_latest.zip
    # rem files
    rm android-studio-2020.3.1.23-linux.tar.gz
    rm commandlinetools-linux-7583922_latest.zip
    # add env to /etc/environment
    echo 'export JAVA_HOME="/usr/lib/jvm/java-11-openjdk-amd64"'  | sudo tee -a /etc/environment
    echo 'export ANDROID_HOME="/opt/sdk"'  | sudo tee -a /etc/environment
    echo 'export PATH="$PATH:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/sdk/android-studio/bin:/opt/sdk/cmdline-tools/latest/bin:$ANDROID_HOME/emulator:$ANDROID_HOME/tools/bin:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:/snap/bin:/opt/sdk/engine"'  | sudo tee -a /etc/environment
    # fix cmd lines tools
    cd /opt/sdk/cmdline-tools
    mkdir latest
    mv bin latest 
    mv lib latest
    sudo chmod 777 -R /opt/sdk 
    # reboot
    sudo reboot
else
    #install sdk tools
    echo '- START install sdk';
    sdkmanager --install "platforms;android-30"
    sdkmanager --install "build-tools;30.0.3"
    echo '- START install accept licenses';
    flutter doctor --android-licenses
    flutter doctor
fi