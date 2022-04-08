sudo apt-get install -y lolcat
sudo apt install zsh
sudo apt install git-core curl fonts-powerline

mkdir /home/gitpod/.gitpod-code
echo '{}' > /home/gitpod/.gitpod-code/argv.json

gpg --verbose --batch --import <(echo $GNUPG_KEY|base64 -d)
echo 'pinentry-mode loopback' >> ~/.gnupg/gpg.conf
git config --global commit.gpgsign true # sign all commits