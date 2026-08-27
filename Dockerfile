# # Stage 1: Build
# FROM golang:1.26 AS build-stage

# # Gunakan /app sebagai standar working directory
# WORKDIR /app

# # Copy dependency list terlebih dahulu
# COPY go.mod go.sum ./
# RUN go mod download

# # Copy seluruh source code
# COPY . .

# # Arahkan go build secara eksplisit ke dalam folder cmd/main.go
# RUN CGO_ENABLED=0 GOOS=linux go build -o main ./cmd/main.go

# # Stage 2: Deploy
# FROM alpine:latest
# WORKDIR /app

# # Copy file 'main' dari folder /app di build-stage ke folder /app di stage ini
# COPY --from=build-stage /app/main .

# EXPOSE 4000

# Build stage
FROM docker.io/library/golang:1.25-alpine AS builder

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build \
    -o /app/server \
    ./cmd/api/main.go


# Runtime stage
FROM docker.io/library/alpine:latest

WORKDIR /app

RUN apk add --no-cache ca-certificates tzdata

COPY --from=builder /app/server ./server

EXPOSE 4000

CMD ["./main"]