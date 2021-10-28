package main

import (
	"net/http"
	"time"

	"github.com/BedivereZero/test-cicd/version"
	"github.com/gin-gonic/gin"
)

func main() {
	r := gin.Default()

	r.GET("/ping", func(c *gin.Context) {
		c.String(http.StatusOK, "pong")
	})
	r.GET("/version", func(c *gin.Context) {
		c.JSON(http.StatusOK, version.Get())
	})

	starttime := time.Now()
	r.GET("/starttime", func(c *gin.Context) {
		c.String(http.StatusOK, starttime.Format(time.RFC3339))
	})

	r.Run(":1080") // listen and serve on 0.0.0.0:8080 (for windows "localhost:8080")
}
