GOV=$(asdf where golang)
export GOROOT=$GOV/go
export GOPATH=$(go env GOPATH)
export PATH=$PATH:$GOPATH/bin
