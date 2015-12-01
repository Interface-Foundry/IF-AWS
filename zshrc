# ssh helpers

AWS_DIR=${0:A:h}
TERRAFORM_KEY="$AWS_DIR"/terraform/ssh_keys/terraform.pem

# ssh helper, so you could do "ifssh pikachu.kipapp.co"
alias ifssh="ssh -i \"$TERRAFORM_KEY\" -l ubuntu"
alias ifscp="scp -i \"$TERRAFORM_KEY\""
