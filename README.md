# Logging app with promtail and Loki

## Handover

We will send fastapi app logs to loki using promtail agent.
All stack will be deployed in kubernetes.
In the following, we describe steps to :
- Test application in local
- Using Docker
- Deploy stack :  Loki, Grafana to store and visualise log
- Deploy fastapi application in kubernetes with sidecar promtail container to send log in Loki Instance

If you don't want to test in Local, you can go ahead on part II)

### I) Test Applicatin in Local

#### Prerequisites

- Python >= 3.10

#### Procedures 

1) *Create and activate virtual env*

```
python -m venv my_env
source my_env/bin/activate
```

2) *Download necessary packages*

```
pip install -r requirements.txt
```

3) *Launch application*
```
uvicorn src.main:app --reload --log-config logging_config.yaml
```

`logging_config.yaml`: 

4) Test api

```
curl localhost:8000
```


### II) Using Docker

#### Prerequisites

- docker >= 27.2.0

#### Steps 

1) *Build docker image of the application*

```
docker build -t fastapi-logger:v2 .
```

2) *Launch container*
```
docker run --name api-log --rm -d -p 8000:8000 fastapi-logger:v2
```

3) *Test api*

```
curl localhost:8000
```

4) *Push docker image on docker hub*

```
docker tag fastapi-logger:v2 <docker-username>/fastapi-logger:v2
docker push <docker-username>/fastapi-logger:v2
```

### Deploy stack on kubernetes: Loki, Grafana

#### Prerequisites

- kubernetes 
- helm
- kubectl

#### [Deploy Loki](https://grafana.com/docs/loki/latest/setup/install/helm/install-monolithic/)

We will deploy Loki with helm chart

1) *Add grafana chart repository to the cluster and deploy Loki*
```
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update
helm repo list
helm search repo loki
cd stack/loki
helm install --values values-loki.yaml loki grafana/loki > loki-instructions.txt
```

2) *Test loki deployment*

- Read loki-instructions.txt


#### [Deploy Grafana]()

1) *Add grafana chart repository to the cluster and deploy Grafana*
```
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update
helm search repo grafana
cd stack/grafana
helm install grafana grafana/grafana --namespace grafana --create-namespace > grafana-instructions.txt
```

2) *Test Grafana*

- Read loki-instructions.txt
```
username: admin
```
3) *Connect Grafana to Loki*

- Follow documentation [configure-loki-data-source](https://grafana.com/docs/grafana/latest/datasources/loki/configure-loki-data-source/)


### Deploy fastapi application with promtail

1) Deploy app
```
cd stack/apps
k apply -f fast-api-deployment.yaml
```

2) Visualize log on grafana



## Links

https://akyriako.medium.com/kubernetes-logging-with-grafana-loki-promtail-in-under-10-minutes-d2847d526f9e
https://grafana.com/docs/loki/latest/setup/install/helm/install-monolithic/

