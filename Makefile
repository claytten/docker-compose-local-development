DOCKER_COMPOSE := docker-compose
DOCKER_COMPOSE_FILES := $(wildcard docker-compose-*.yml)

define run_docker_compose
	@if [ -e $(1) ]; then \
		echo "\nRunning: $(1)"; \
		$(DOCKER_COMPOSE) -p $$(echo $(1) | sed 's/.*-\(.*\)\.yml/\1/') -f $(1) $(2) $(filter-out $@,$(MAKECMDGOALS)); \
	else \
		echo "Target not found: $(1)"; \
	fi
endef

define prompt_and_execute
	@read -p "Target is not set. Do you want to $(1) all services in each docker-compose file [y/N]? [y]: " choice; \
		choice=$${choice:-y}; \
		if [ "$$choice" = "y" ] || [ "$$choice" = "Y" ]; then \
			echo "Proceeding..."; \
			for file in $(2); do \
				if [ -e $$file ]; then \
					echo "\nRunning: $$file"; \
					$(DOCKER_COMPOSE) -p $$(echo $$file | sed 's/.*-\(.*\)\.yml/\1/') -f $$file $(3) $(filter-out $@,$(MAKECMDGOALS)); \
				else \
					echo "Target not found: $$file"; \
				fi; \
			done; \
			echo "Done"; \
		else \
			echo "Aborted."; \
		fi
endef

up:
ifdef target
	$(call run_docker_compose, docker-compose-$(target).yml, up -d)
else
	$(call prompt_and_execute, "up", $(DOCKER_COMPOSE_FILES), up -d)
endif

down:
ifdef target
	$(call run_docker_compose, docker-compose-$(target).yml, down)
else
	$(call prompt_and_execute, "down", $(DOCKER_COMPOSE_FILES), down)
endif

ps:
ifdef target
	$(call run_docker_compose, docker-compose-$(target).yml, ps)
else
	$(call prompt_and_execute, "saw", $(DOCKER_COMPOSE_FILES), ps)
endif

clean:
ifdef target
	$(call run_docker_compose, docker-compose-$(target).yml, down --volumes --remove-orphans)
else
	$(call prompt_and_execute, "clean", $(DOCKER_COMPOSE_FILES), down --volumes --remove-orphans)
endif

.DEFAULT_GOAL := help

help:
	@echo "Available targets:"
	@echo "  up:          Bring up services"
	@echo "  down:        Bring down services"
	@echo "  ps:          List container status (requires 'target' parameter)"
	@echo "  clean:       Clean up resources and volumes (requires 'target' parameter)"
	@echo "  help:        Show this help message"

.PHONY: up down ps clean help
