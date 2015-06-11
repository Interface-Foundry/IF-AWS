#This terraform template spins up the mongodb analytics server

## Security Groups

TBD

## Instances

TBD

## Backups

Two scripts exist on the instances to perform EBS snapshots:

/usr/bin/mongodb-snapshot

/usr/bin/mongodb-expire-snapshot

They should be edited with correct paramters.

See https://github.com/alestic/ec2-consistent-snapshot and https://github.com/alestic/ec2-expire-snapshots
