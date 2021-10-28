package main

import (
	"net/http"

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

	r.Run(":1080") // listen and serve on 0.0.0.0:8080 (for windows "localhost:8080")
}
