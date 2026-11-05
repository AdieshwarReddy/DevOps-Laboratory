
package main

import (
	"fmt"
	"log"
	"net/http"
	"os"
	"strconv"
	"sync/atomic"
	"time"
)

var totalRequests atomic.Uint64
var errorRequests atomic.Uint64

func homeHandler(w http.ResponseWriter, r *http.Request) {
	totalRequests.Add(1)

	w.Header().Set("Content-Type", "text/plain")
	fmt.Fprintln(w, "DevOps Laboratory - Experiment 10")
	fmt.Fprintln(w, "End-to-End DevOps Workflow")
	fmt.Fprintln(w, "Git + Jenkins + Docker + Kubernetes")
	fmt.Fprintln(w, "Prometheus + Grafana")
}

func healthHandler(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")
	fmt.Fprintln(w, `{"status":"healthy"}`)
}

func errorHandler(w http.ResponseWriter, r *http.Request) {
	totalRequests.Add(1)
	errorRequests.Add(1)

	http.Error(
		w,
		"Simulated application error",
		http.StatusInternalServerError,
	)
}

func metricsHandler(w http.ResponseWriter, r *http.Request) {
	w.Header().Set(
		"Content-Type",
		"text/plain; version=0.0.4; charset=utf-8",
	)

	fmt.Fprintln(w, "# HELP app_requests_total Total application requests")
	fmt.Fprintln(w, "# TYPE app_requests_total counter")
	fmt.Fprintln(
		w,
		"app_requests_total "+strconv.FormatUint(
			totalRequests.Load(), 10,
		),
	)

	fmt.Fprintln(w, "# HELP app_errors_total Total application errors")
	fmt.Fprintln(w, "# TYPE app_errors_total counter")
	fmt.Fprintln(
		w,
		"app_errors_total "+strconv.FormatUint(
			errorRequests.Load(), 10,
		),
	)

	fmt.Fprintln(w, "# HELP app_up Application availability")
	fmt.Fprintln(w, "# TYPE app_up gauge")
	fmt.Fprintln(w, "app_up 1")
}

func newHandler() http.Handler {
	mux := http.NewServeMux()

	mux.HandleFunc("/", homeHandler)
	mux.HandleFunc("/health", healthHandler)
	mux.HandleFunc("/error", errorHandler)
	mux.HandleFunc("/metrics", metricsHandler)

	return mux
}

func main() {
	port := os.Getenv("PORT")
	if port == "" {
		port = "8080"
	}

	server := &http.Server{
		Addr:              ":" + port,
		Handler:           newHandler(),
		ReadHeaderTimeout: 5 * time.Second,
	}

	log.Printf("DevOps application listening on port %s", port)
	log.Fatal(server.ListenAndServe())
}
