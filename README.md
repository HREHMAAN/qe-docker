# Quantum ESPRESSO Docker Environment

This repository provides a Docker environment for building Quantum ESPRESSO from the official QEF GitLab repository.

Source repository: https://gitlab.com/QEF/q-e

## Install Docker

Docker is required to build and run this image.

### macOS

Install Docker Desktop for Mac from the official Docker website:

```text
https://docs.docker.com/desktop/setup/install/mac-install/
```

### Windows

Install Docker Desktop for Windows from the official Docker website:

```text
https://docs.docker.com/desktop/setup/install/windows-install/
```

After installation, open Docker Desktop and wait until Docker is running.

## Build locally

After installing docker Clone this repository:

```bash
git clone https://github.com/HREHMAAN/qe-docker.git
```
```
cd qe-docker
```

Build the Docker image:

```bash
docker build -t quantum-espresso .
```

## Run the container

```bash
docker run -it -v $(pwd):/root/shared --rm -w /root/shared quantum-espresso
OR
docker run -it -v ${PWD}:/root/shared --rm -w /root/shared quantum-espresso
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
mpirun -np N pw.x < espresso.pwi > espresso.out
```
N is the number of cores, eg: 2,3,4,5,...

After the run finishes, check:

```bash
grep "JOB DONE" espresso.out
```
## Troubleshooting Docker build issues

If the Docker build fails because of network, DNS, or registry connection problems, you can try configuring Docker's daemon settings.

Create or edit Docker's `daemon.json` file and add:

```json
{
  "builder": {
    "gc": {
      "defaultKeepStorage": "20GB",
      "enabled": true
    }
  },
  "dns": ["8.8.8.8", "8.8.4.4"],
  "registry-mirrors": ["https://mirror.gcr.io"]
}
```

After saving the file, restart Docker and build again:

```bash
docker build --no-cache -t quantum-espresso .
```

On Linux, the file is usually located at:

```text
/etc/docker/daemon.json
```

On Docker Desktop, you can usually edit it from:

```text
Docker Desktop → Settings → Docker Engine
```

Then paste or modify the JSON configuration there and restart Docker.

## Notes

The image currently builds Quantum ESPRESSO from the `develop` branch.

For reproducible research, using a fixed Quantum ESPRESSO release tag is recommended.
