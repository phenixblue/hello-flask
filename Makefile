APP_NAME ?= "hello.py"
CONFIG_NAME ?= "config.py"
REPO_ROOT := $(CURDIR)
KUBERNETES_ROOT := "$(REPO_ROOT)/kubernetes"
DOCKER := docker
KUBECTL := kubectl
K8s_NS := "flask-test-searcy"

###############################################################################
# Python Targets ##############################################################
###############################################################################

# Lint and update python code
.Phony: lint
lint:

	black $(APP_NAME)
	black $(CONFIG_NAME)

###############################################################################
# Kubernetes Targets ##########################################################
###############################################################################

# Deploy to Kubernetes
.PHONY: deploy-ns
deploy-ns:

	$(KUBECTL) create ns $(K8s_NS)

# Deploy to Kubernetes
.PHONY: deploy-resources
deploy-resources:

	$(KUBECTL) -n $(K8s_NS) apply -f "$(KUBERNETES_ROOT)/hello-deployment.yaml"
	$(KUBECTL) -n $(K8s_NS) apply -f "$(KUBERNETES_ROOT)/hello-svc.yaml"
	$(KUBECTL) -n $(K8s_NS) apply -f "$(KUBERNETES_ROOT)/hello-ingress.yaml"
	$(KUBECTL) -n $(K8s_NS) apply -f "$(KUBERNETES_ROOT)/hello-pdb.yaml"
	$(KUBECTL) -n $(K8s_NS) apply -f "$(KUBERNETES_ROOT)/hello-hpa.yaml"

.PHONY: deploy
deploy: deploy-ns deploy-resources

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