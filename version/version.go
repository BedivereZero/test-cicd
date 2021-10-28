package version

import (
	"runtime"
)

var (
	version   string
	buildDate string

	gitCommit    string
	gitTreeState string
)

type Info struct {
	Version   string `json:"version"`
	BuildDate string `json:"buildDate"`

	GitCommit    string `json:"gitCommit"`
	GitTreeState string `json:"gitTreeState"`

	GoVersion string `json:"goVersion"`
	Compiler  string `json:"compiler"`
	Platform  string `json:"platform"`
}

func Get() Info {
	return Info{
		Version:   version,
		BuildDate: buildDate,

		GitCommit:    gitCommit,
		GitTreeState: gitTreeState,

		GoVersion: runtime.Version(),
		Compiler:  runtime.Compiler,
		Platform:  runtime.GOOS + "/" + runtime.GOARCH,
	}
}
