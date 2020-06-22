CRYSTAL_VERSION := $(shell sed -ne 's/crystal: //p' shard.yml)
DOCKER_IMAGE    := mgiken/crystal:$(CRYSTAL_VERSION)

all: dev

clean:
	$(call RUN, rm -rf bin docs)

env:
	$(call RUN, crystal version)
	$(call RUN, crystal env)

test:
	$(call RUN, shards install)
	$(call RUN, crystal spec --error-on-warnings)
	$(call RUN, crystal tool format --check)
	$(call RUN, ameba --all)

watch:
	@watchexec -cnr -w src -w spec -w shard.yml -- make --no-print-directory test

dev:
	@docker run --rm -it -v $(PWD):/hack:cached -w /hack $(DOCKER_IMAGE) make watch

sh:
	@docker run --rm -it -v $(PWD):/hack:cached -w /hack $(DOCKER_IMAGE)

.PHONY: all clean env test watch dev sh

define RUN
	@printf "\033[34m%s\033[m " "==>"
	$1
endef
