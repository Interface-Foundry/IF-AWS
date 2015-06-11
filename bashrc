# ssh helpers

AWS_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
TERRAFORM_KEY="$AWS_DIR"/terraform/ssh_keys/terraform.pem

# ssh helper, so you could do "ifssh pikachu.kipapp.co"
alias ifssh="ssh -i \"$TERRAFORM_KEY\" -l ubuntu"
alias ifscp="scp -i \"$TERRAFORM_KEY\""
