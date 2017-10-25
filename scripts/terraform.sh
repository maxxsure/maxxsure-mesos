
length=$(terraform env list | grep -c ${TF_STATE_ENV})

if [ "$length" -lt "1" ]
then
  terraform env new ${TF_STATE_ENV}
fi
