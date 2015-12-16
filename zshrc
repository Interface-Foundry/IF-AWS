# ssh helpers

AWS_DIR=${0:A:h}
TERRAFORM_KEY="$AWS_DIR"/terraform/ssh_keys/terraform.pem

# ssh helper, so you could do "ifssh pikachu.kipapp.co"
ifssh() { ssh -i "$TERRAFORM_KEY" -l ubuntu "${1}.kipapp.co" }
alias ifscp="scp -i \"$TERRAFORM_KEY\""

export IF=/data/if/root
alias chat='cd $IF/componenets/cinna-slack/chat'
