package main

import (
	"context"
	"fmt"
	"os"

	"github.com/containerd/nri/skel"
	types "github.com/containerd/nri/types/v1"

	"github.com/sirupsen/logrus"

)

type blockioNRI struct {
}

func (c *blockioNRI) Type() string {
	return "blockio-nri"
}

func (c *blockioNRI) Invoke(ctx context.Context, r *types.Request) (*types.Result, error) {
	result := r.NewResult("blockio-nri")
	logrus.Debugf("context: %+v", ctx)
	logrus.Debugf("request: %+v", r)
	return result, nil
}

func main() {
	f, err := os.OpenFile("/tmp/blockio-nri.log", os.O_WRONLY | os.O_CREATE | os.O_APPEND, 0666)
	if err != nil {
		logrus.Fatalf("error opening file: %v", err)
	}
	defer f.Close()

	logrus.SetOutput(f)
	logrus.SetLevel(5)
	logrus.Debugf("launching blockio-nri")
	ctx := context.Background()
	if err := skel.Run(ctx, &blockioNRI{}); err != nil {
		fmt.Fprintf(os.Stderr, "%s", err)
		logrus.Debugf("exit with error %q", err)
		os.Exit(1)
	}
	logrus.Debugf("exit success")
}
