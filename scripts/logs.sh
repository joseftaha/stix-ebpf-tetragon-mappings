kubectl logs -n kube-system -l app.kubernetes.io/name=tetragon --tail=-1 > "tetragon-logs-$(date +%Y%m%d-%H%M%S).log"
