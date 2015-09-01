# ssh helpers

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
AWS_DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

TERRAFORM_KEY="$AWS_DIR"/terraform/ssh_keys/terraform.pem

# ssh helper, so you could do "ifssh pikachu.kipapp.co"
alias ifssh="ssh -i \"$TERRAFORM_KEY\" -l ubuntu"
alias ifscp="scp -i \"$TERRAFORM_KEY\""

# super fun aliases
alias wow="git status"
alias such="git"
alias very="git"
