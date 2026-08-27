package main

import (
	"net/http"

	"github.com/gin-gonic/gin"
)

type album struct {
	ID     string  `json:"id"`
	Title  string  `json:"title"`
	Artist string  `json:"artist"`
	Price  float64 `json:"price"`
}

var albums = []album{
	{ID: "1", Title: "LosT", Artist: "Bring Me The Horizon", Price: 36.99},
	{ID: "2", Title: "Gunslinger", Artist: "Avengend Sevenfold", Price: 20.99},
	{ID: "3", Title: "星の消えた夜に -rit. ver.-", Artist: "Aimer", Price: 19.99},
}

func main() {
	router := gin.Default()
	router.GET("/", getAlbums)

	router.Run(":8080")
}

func getAlbums(c *gin.Context) {
	c.IndentedJSON(http.StatusOK, albums)
}
