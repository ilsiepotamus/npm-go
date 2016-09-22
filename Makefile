filename = travistest

.PHONY: install release test travis

install:
	go get -t -v ./...

release:
	mkdir -p release
	GOOS=linux GOARCH=amd64 go build -o release/$(filename)-linux-x64
	gzip -f release/$(filename)-linux-x64
	GOOS=darwin GOARCH=amd64 go build -o release/$(filename)-darwin-x64
	gzip -f release/$(filename)-darwin-x64
	GOOS=windows GOARCH=amd64 go build -o release/$(filename)-win32-x64
	gzip -f release/$(filename)-win32-x64
	GOOS=freebsd GOARCH=amd64 go build -o release/$(filename)-freebsd-x64
	gzip -f release/$(filename)-freebsd-x64
	GOOS=openbsd GOARCH=amd64 go build -o release/$(filename)-openbsd-x64
	gzip -f release/$(filename)-openbsd-x64
