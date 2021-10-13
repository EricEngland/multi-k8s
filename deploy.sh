docker build -t eengland/multi-client:latest -t eengland/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t eengland/multi-server:latest -t eengland/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t eengland/multi-worker:latest -t eengland/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push eengland/multi-client:latest
docker push eengland/multi-server:latest
docker push eengland/multi-worker:latest

docker push eengland/multi-client:$SHA
docker push eengland/multi-server:$SHA
docker push eengland/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=eengland/multi-server:$SHA
kubectl set image deployments/client-deployment client=eengland/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=eengland/multi-worker:$SHA