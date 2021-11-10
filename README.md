# O'Reiilly Training - Introduction to Apache Iceberg

### Requirements

The only thing needed is docker and docker-compose.

### Project Structure

### Preparations

Create folder for the data

```sh
mkdir ./_data
```

Build Docker images:

```sh
./dbuild
```

Run the entire stack using Docker Compose:

```sh
./drun
```

### Cleanup

You can remove all Docker containers and images generated for the purpose of the training by running:

```sh
./dclean
```

If you wish, you can also remove the `_data` folder:

```sh
rm -rf ./_data
```
