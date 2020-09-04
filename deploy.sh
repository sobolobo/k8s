docker build -t jalil/multi-client:latest -t jalil/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jalil/multi-server:latest -t jalil/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jalil/multi-worker:latest -t jalil/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push jalil/multi-worker:latest
docker push jalil/multi-server:latest
docker push jalil/multi-client:latest

docker push jalil/multi-worker:$SHA
docker push jalil/multi-server:$SHA
docker push jalil/multi-client:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=jalil/multi-server:$SHA
kubectl set image deployments/server-deployment server=jalil/multi-client:$SHA
kubectl set image deployments/server-deployment server=jalil/multi-worker:$SHA
