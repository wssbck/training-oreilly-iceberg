# O'Reilly Training - Introduction to Apache Iceberg

This repository contains Docker environment, code examples and exercises for the O'Reilly training titled "Getting Started With Apache Iceberg".

https://www.oreilly.com/live-events/getting-started-with-apache-iceberg/0636920063359/

### Requirements

The only required component is `docker` and `docker-compose`, which can be downloaded as a single package from https://www.docker.com/products/docker-desktop. Shortcut scripts prepared in this repository assume that a *nix operating system is being used, offering one of the standard shell environments like `sh` or `bash`.

**Windows**

In order to use the contents of this repository on Windows, WSL (Windows Subsystem for Linux) is required. In addition to that, an option in Docker Desktop to integrate with WSL needs to be enabled.

**All commands described here should be executed from the main folder of the repository.**

### Project Structure

The structure of the folders and files in this project is as follows:

```
+- ./_data/      # stores data generated when executing Jupyter notebooks
+- ./_notebooks/ # Jupyter notebooks with examples and exercises
+- ./docker/     # definitions of Docker images and Docker Compose stack
+- ./dbuild      # build command (see below)
+- ./dclean      # clean command (see below)
+- ./drun        # run command (see below)
```

### Preparations

Build Docker images (it may take awhile):

```sh
./dbuild
```

### Running and Testing

Run the entire stack using Docker Compose:

```sh
./drun
```

After the stack is up, the Jupyter environment will be available at http://localhost:8888. Once opened, training notebooks are available in the folder `/_oreilly_iceberg/notebooks/`.

To verify that everything works, try executing all cells in the notebook called `00_test.ipynb`, one by one.

### Cleanup

After working with the included notebooks, all Docker containers and images generated for the purpose of the training can be removed by running:

```sh
./dclean
```

Afterwards the images will have to be rebuilt from scratch if necessary. Additionally, a quick way to remove all data files generated during the execution of the notebooks is to remove all untracked files using `git`:

```sh
git clean -fx
```
