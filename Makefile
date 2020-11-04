# Build non-optimized version for debugging on make DEBUG=1.
DEBUG ?= 0
ifeq ($(DEBUG),1)
    GCFLAGS=-gcflags "all=-N -l"
else
    LDFLAGS=-ldflags "-s -w"
endif

CMDS := $(subst cmd/,bin/,$(wildcard cmd/*))

all: $(CMDS)

clean:
	$(RM) $(CMDS)

bin/%: cmd/%/*.go pkg/*/*.go Makefile
	mkdir -p $(dir $@) && \
	cd cmd/$(notdir $@) && \
	go build $(GCFLAGS) $(LDFLAGS) -o ../../$@
