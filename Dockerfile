# Stage 1: Build
FROM docker.io/library/golang:1.26 AS build-stage

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . .

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 \
    go build -o /app/main ./cmd/main.go


# Stage 2: Runtime
FROM docker.io/library/alpine:latest

WORKDIR /app

RUN apk add --no-cache ca-certificates tzdata

COPY --from=build-stage /app/main /app/main

EXPOSE 4000

CMD ["./main"]