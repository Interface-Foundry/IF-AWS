sudo add-apt-repository -y ppa:alestic
sudo apt-get update
sudo apt-get install ec2-consistent-snapshot ec2-expire-snapshots libmongodb-perl -y
sudo apt-get install build-essential -y

sudo bash -c 'export PERL_MM_USE_DEFAULT=1;cpan install Any::Moose;cpan install MongoDB::Admin'
