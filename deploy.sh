docker build -t harshakalva/multi-client:latest -t harshakalva/multi-client:$GIT_SHA -f ./client/Dockerfile ./client 
docker build -t harshakalva/multi-server:latest -t harshakalva/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t harshakalva/multi-worker:latest -t harshakalva/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker

docker push harshakalva/multi-client:latest
docker push harshakalva/multi-server:latest
docker push harshakalva/multi-worker:latest

docker push harshakalva/multi-client:$GIT_SHA
docker push harshakalva/multi-server:$GIT_SHA
docker push harshakalva/multi-worker:$GIT_SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=harshakalva/multi-server:$GIT_SHA
kubectl set image deployments/client-deployment client=harshakalva/multi-client:$GIT_SHA
kubectl set image deployments/worker-deployment worker=harshakalva/multi-worker:$GIT_SHA

