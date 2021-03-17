CMD=$1

if [[ $CMD == "restart" ]]; then
  # TODO probably can just remove this?
  kubectl delete -f k8s/validator.yml && \
  kubectl apply -f k8s/validator.yml
else
  kubectl apply -f k8s/validator.yml

  # Delete all the validator pods. StatefulSet will automatically recreate them
  validator_count=$(kubectl get pods | grep -c "helium-validator")
  for ((i = 0 ; i <= $validator_count ; i++)); do
    kubectl delete pod helium-validator-$i &
  done  
fi