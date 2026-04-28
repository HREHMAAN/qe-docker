# Quantum ESPRESSO Docker Environment

This repository provides a Docker environment for building Quantum ESPRESSO from the official QEF GitLab repository.

Source repository: https://gitlab.com/QEF/q-e

## Build locally

Clone this repository:

```bash
git clone https://github.com/HREHMAAN/qe-docker.git
cd qe-docker
```

Build the Docker image:

```bash
docker build -t quantum-espresso .
```

## Run the container

```bash
docker run -it -v $(pwd):/root/shared --rm -w /root/shared quantum-espresso
```

## Test Quantum ESPRESSO

Inside the container, run:

```bash
which pw.x
pw.x
```

You should see Quantum ESPRESSO start and wait for input.

To exit if it waits for input, press:

```bash
Ctrl+C
```
## Run the demo

The repository includes a demo input file:

```text
demo/espresso.pwi
```

To run the demo, first start the Docker container:

```bash
docker run -it -v $(pwd):/root/shared --rm -w /root/shared quantum-espresso
```

Then inside the container:

```bash
cd demo
```

Run the demo with:

```bash
pw.x < espresso.pwi | tee espresso.out
```

This runs Quantum ESPRESSO and saves the output to `espresso.out` while also showing it in the terminal.

Alternatively, if using MPI:

```bash
mpirun pw.x < espresso.pwi > espresso.out
```

After the run finishes, check:

```bash
grep "JOB DONE" espresso.out
```

## Notes

The image currently builds Quantum ESPRESSO from the `develop` branch.

For reproducible research, using a fixed Quantum ESPRESSO release tag is recommended.
