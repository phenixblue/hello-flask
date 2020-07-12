APP_NAME ?= "hello-flask"
APP_FILE_NAME ?= "hello.py"
APP_CONFIG_FILE_NAME ?= "config.py"
REPO_ROOT := $(CURDIR)
KUBERNETES_ROOT := "$(REPO_ROOT)/kubernetes"
DOCKER := docker
KUBECTL := kubectl
K8S_NS := "hello-flask"

###############################################################################
# Python Targets ##############################################################
###############################################################################

# Lint and update python code
.Phony: lint
lint:

	black $(APP_FILE_NAME)
	black $(APP_CONFIG_FILE_NAME)

###############################################################################
# Kubernetes Targets ##########################################################
###############################################################################

# Deploy to Kubernetes
.PHONY: deploy-ns
deploy-ns:

	$(KUBECTL) create ns $(K8S_NS)

# Deploy to Kubernetes
.PHONY: deploy-resources
deploy-resources:

	$(KUBECTL) -n $(K8S_NS) apply -f "$(KUBERNETES_ROOT)/hello-deployment.yaml"
	$(KUBECTL) -n $(K8S_NS) apply -f "$(KUBERNETES_ROOT)/hello-svc.yaml"
	$(KUBECTL) -n $(K8S_NS) apply -f "$(KUBERNETES_ROOT)/hello-ingress.yaml"
	$(KUBECTL) -n $(K8S_NS) apply -f "$(KUBERNETES_ROOT)/hello-pdb.yaml"
	$(KUBECTL) -n $(K8S_NS) apply -f "$(KUBERNETES_ROOT)/hello-hpa.yaml"

.PHONY: deploy
deploy: deploy-ns deploy-resources

.PHONY: restart
restart:

	$(KUBECTL) -n $(K8S_NS) rollout restart deploy $(APP_NAME)

###############################################################################
# Container Image Targets #####################################################
###############################################################################

# Build MagTape container image
.PHONY: build
build:

	$(DOCKER) build -t jmsearcy/hello-flask:latest .

# Push MagTape container image to DockerHub
.PHONY: push
push:

	$(DOCKER) push jmsearcy/hello-flask:latest

###############################################################################
# Generic Dev Targets #########################################################
###############################################################################

# Build MagTape container image
.PHONY: updates
updates: build push deploy-resources restart

	$(KUBECTL) -n $(K8S_NS) get pods
