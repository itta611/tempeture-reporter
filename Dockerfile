FROM rust:latest as builder
WORKDIR /app
COPY . .
RUN cargo build --release

FROM alpine:latest as stats-reporter
WORKDIR /app
COPY --from=builder /app/target/release/stats-reporter .
EXPOSE 2784
CMD [ "/app/stats-reporter" ]

FROM alpine:latest as stats-manager
WORKDIR /app
COPY --from=builder /app/target/release/stats-manager .
EXPOSE 2784
CMD [ "/app/stats-manager" ]
