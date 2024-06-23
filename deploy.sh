docker build -t nanabappiah7/multi-client:latest -t nanabappiah7/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t nanabappiah7/multi-server:latest -t nanabappiah7/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t nanabappiah7/multi-worker:latest -t nanabappiah7/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push nanabappiah7/multi-client:latest
docker push nanabappiah7/multi-server:latest
docker push nanabappiah7/multi-worker:latest

docker push nanabappiah7/multi-client:$SHA
docker push nanabappiah7/multi-server:$SHA
docker push nanabappiah7/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=nanabappiah7/multi-server:$SHA
kubectl set image deployments/client-deployment client=nanabappiah7/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=nanabappiah7/multi-worker:$SHA