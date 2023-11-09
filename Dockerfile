FROM golang:1.21 as build
WORKDIR /app
COPY ./catgpt/go.mod ./catgpt/go.sum  ./
RUN go mod download && go mod verify
COPY ./catgpt/ ./
RUN CGO_ENABLED=0 go build -o /app/catgpt ./...

FROM gcr.io/distroless/static-debian12:latest-amd64
COPY --from=build /app/catgpt /
EXPOSE 8080
CMD ["/catgpt"]
