# Docker Notes

## Part 1: Core concepts

### Container vs virtual machine
A **container** is a loosely isolated, runnable instance/environment of an image that packages an application together with its dependencies(runtime, libraries, config) and all that is needed to run the application on any computer with Docker. 
It is lightweight, starts in milliseconds and shares the host's operating system rather than building its own.

A **virtual machine** mimics a computer and runs/ships a full guest operating system on a hypervisor (software that allows to run one or more virtual machines on a single physical machine).

| | Container | Virtual machine |
|---|---|---|
| OS | Shares the host's kernel | Has its own full guest OS |
| Size | Usually megabytes | Usually gigabytes |
| Start time | Seconds or less | Minutes |
| Isolation | Process-level (lighter) | Hardware-level (stronger) |
| What it virtualises| Operating system | Hardware |

### Image vs container vs volume vs network
- **Image** - a standardized package/template that includes all of the app files, libraries, and configurations to run a container, built from a Dockerfile. Images cannot be modified once they are created but changes can be added on top of it or a new image can be created.
- **Container** - a instance of an image, like an object created from a class. Multiple container instances can be run from one image.
- **Volume** - Volumes are data stores for containers, that are created and managed by Docker and are isolated from the core functionality of the host machine. When a volume is created, it's stored within a directory on the Docker host and this directory is what's mounted into the container. When the container is removed its own filesystem is also removed, but volume data stays, therefore databases need volumes.
- **Network** - Compose automatically creates a default network per project. It allows containers to connect to and communicate with each other, as well as with non-Docker network services using the container port. Services/containers on the same network can reach each other by name (for example, `backend` connects to `db:5432`).

### Registry
A **registry** is a server that stores and manages Docker images. It contains repositories where one or more container images are stored. Images are shared across teams through these registries, which allows teams to have the same configurations for all stages of CI/CD and deployments.
- **Docker Hub** is the default public registry that anyone can use. `node:22` comes from there.
- **Private registries** such as AWS ECR, Azure ACR, GitLab Container Registry and so on, hold a company's own images, and require the user to log in to use them.
- `docker pull` downloads an image from the configured registry
- `docker push` uploads an image to a registry

With the app containerized, developers just have to pull the latest images from the registry, do their work locally, and then push their changes back to the registry.

### Image layers and build caching
Container images are composed of layers where each of these layers, once created, are immutable.
Each instruction in a Dockerfile creates a **layer** (`FROM`, `COPY`, `RUN`, and so on). 
These layers allows one to extend other images by reusing their base layers, allowing to add only the data that your application needs.
Docker caches layers, and on a rebuild it reuses them until one of the input has changed. That specific layer and every layer after it are rebuilt.
Layering make builds faster and reduce the amount of storage and bandwidth required to distribute the images.

The instructions in the docker file are arranged from least-changing to most-changing, as shown below;

```dockerfile
COPY package*.json ./   # changes rarely
RUN npm install         # slow, but cached while package.json is unchanged
COPY . .                # code changes often, so only this step reruns
```

If `COPY . .` came before `npm install`, everytime code changes it would reinstall all the dependencies.

---
