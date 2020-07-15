
build: get build-canary
step-1: dry-run deploy-prod
step-2: dry-run deploy-canary

get: 
	cd cmd && go get -v

build-canary:
	go build -o ./bin/canary-demo ./cmd/main.go

deploy-prod:
	kubectl apply -f ./deploy/prod-namespace.yaml
	sleep 2
	kubectl apply -f ./deploy/prod-deployment.yaml,./deploy/prod-service.yaml,./deploy/prod-ingress.yaml  

deploy-canary: 
	kubectl apply -f ./deploy/canary-namespace.yaml
	sleep 2
	kubectl apply -f ./deploy/canary-deployment.yaml,./deploy/canary-service.yaml,./deploy/canary-ingress.yaml  

dry-run:
	kubectl apply -f ./deploy/. --dry-run

clean-up:
	kubectl delete -f ./deploy/.
