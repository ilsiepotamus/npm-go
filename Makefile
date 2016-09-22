PROJECT = travistest
OSES = linux darwin freebsd openbsd

.PHONY: install release test travis

install:
	go get -t -v ./...

release:
	mkdir -p release
	for os in ${OSES}; do \
    GOOS=$$os GOARCH=amd64 go build -o release/$(PROJECT)-$(VERSION)-$$os-x64; \
    gzip -f release/$(PROJECT)-$(VERSION)-$$os-x64; \
  done
	GOOS=windows GOARCH=amd64 go build -o release/$(PROJECT)-$(VERSION)-win32-x64
	gzip -f release/$(PROJECT)-$(VERSION)-win32-x64
