# Stage 1: Build stage
FROM golang:latest AS build
WORKDIR /app
COPY dispatcher.go .
COPY static .
RUN go build dispatcher.go

# Stage 2: Runtime stage
FROM scratch
WORKDIR /app
COPY --from=build /app/dispatcher /app/dispatcher
COPY --from=build /app/static . /static
CMD ["/app/dispatcher"]
