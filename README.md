# Quantum ESPRESSO Docker Environment

To build a local image:
`docker build -t test_qef .`

To run the container:
`docker run -it -v $(pwd):/root/shared --rm -w /root/shared test_qef`
