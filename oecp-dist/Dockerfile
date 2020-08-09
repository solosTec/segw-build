ARG BASE_TAG
FROM seemann/oecp-node:${BASE_TAG} AS build


FROM ubuntu:bionic

WORKDIR /dist

COPY --from=build /src/node/build/*.ipk ./
