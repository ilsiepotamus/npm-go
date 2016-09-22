filename = travistest
package = github.com/ilsiepotamus/$(filename)

.PHONY: install release test travis

install:
	go get -t -v ./...

release:
	mkdir -p release
	GOOS=linux GOARCH=amd64 go build -o release/$(filename)-linux-x64
	GOOS=darwin GOARCH=amd64 go build -o release/$(filename)-darwin-x64
	GOOS=windows GOARCH=amd64 go build -o release/$(filename)-win32-x64
	GOOS=freebsd GOARCH=amd64 go build -o release/$(filename)-freebsd-x64
	GOOS=openbsd GOARCH=amd64 go build -o release/$(filename)-openbsd-x64
	cd release
	gzip $(filename)-linux-x64 $(package)
	gzip $(filename)-darwin-x64 $(package)
	gzip $(filename)-win32-x64 $(package)
	gzip $(filename)-openbsd-x64 $(package)
	gzip $(filename)-freebsd-x64 $(package)
