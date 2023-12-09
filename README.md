[Tutorial trực quan dễ hiểu](https://www.youtube.com/watch?v=pg19Z8LL06w)

## Docker dùng để làm gì?
Đóng gói ứng dụng (source code) với các configuration, dependency, system tools and run time vào <b>container</b> hiểu nôm na là như ta thiết lập môi trường để chạy ứng dụng và ta có thể share cái container này cho những người khác để họ có thể chạy app mà không cần phải cài đặt các môi trường cần thiết lên máy (hệ điều hành) của họ

Ví dụ: ta có một API được build bằng framework ExpressJS để có thể thực thi nó thì ta cần phải cài đặt NodeJS lên máy chúng ta. Tương tự như vậy container sẽ chứa từ source code, NodeJS environment, các dependencies mà app chúng ta sử dụng,...


Start service as Docker Container
Ví dụ: app của chúng ta sử dụng 2 service mongoDB, redis thì ta để chạy 2 service đó ta gõ docker command cho mỗi container
```
docker run mongoDB 
docker run redis
```

## VM vs Docker
Docker virtualize application layer nghĩa là khi chạy docker container nó chứa application layer của OS, cũng như các application khác được cài trên layer đó ví dụ NodeJS,... và sử dụng kernel của host vì nó không có kernel

VM has application layer và kernel của nó cho nên nó virtualize 1 OS hoàn chỉnh nghĩa là khi download VM image trên máy của bạn thì nó không sử dụng kernel trên máy bạn mà sử dụng kernel trong VM luôn.

### Vấn đề của docker về compatibility:
Máy của bạn cài Windows với Windows kernel và application layer của nó. Bạn muốn chạy Linux based Docker Image trên Window host thì không được vì <b>Linux based Docker images không sử dụng Windows kernel mà cần Linux kernel để chạy </b>
Nhưng <b>Docker Desktop đã giải quyết vấn đề này bằng cách sử dụng WSL2 (đối với Windows) </b> hoặc Hypervisor layer with Linux distribution để cung cấp Linux kernel

## Docker Images
Hiểu đơn giản nó như là application artifact (.jar, .exe, .wasm,...)


Khác biệt so với jar file hay các application artifacts khác là không chỉ chứa compiled application code mà còn chứa environment configuration.

## Docker Containers
A <b>running instance</b> of an image is container. => 1 docker image có thể có nhiều docker container. Vì vậy có thể hiểu docker image như là template.

## Docker Registries
Nó giống như cái npm Registry (nơi chứa các thư viện JS). Docker Registries này nó chứa các Docker images.

Official verified images from Docker (mongoDB, redis,...)

Docker Hub có thể tìm thấy các Official Image và những images đến từ các tổ chức hoặc cá nhân khác tạo ra và upload lên đây.

Docker images cũng có version và phân biệt dựa trên tag.

### Pull image from Docker Hub
```
docker pull {name}:{tag}
```

### Run an image
```
docker run {name}:{tag}
```

### Show local images
```
docker images
```

### Show list running container
```
docker ps
```

### Start container in background without blocking the terminal
```
docker run -d {name}:{tag}
```
Nhưng nếu bạn vẫn muốn xem application log trong container (tiện cho debug) thì dùng docker command sau
```
docker logs {container_id or container_name}
```

### Stop container
```
docker stop {container_id or container_name}
```

## Port Binding
Application inside container run in an isolated Docker network => allow to run same app on same port multiple times => can not access it from our computer browser.

Need to expose container to our network
=> Port binding: bind container's port to host's port to make the service available outside world

Tell docker to bind container port ... to our local host port ...

Chỉ 1 service có thể chạy trên 1 port của host.

### Publish container's port to host
```
docker run -p {HOST_PORT}:{CONTAINER_PORT}
```

## Docker run command
Create new container when run command instead of re-use previous container


### List all containers (stopped and running)
```
docker ps -a
```

### Restart container created before
```
docker start {container_id or container_name}
```

### Assign name for container
```
docker run --name {name} ...
```

## Registry vs Repository
Docker registry have multiple Docker repositories for different application images

Docker repository: collection of related images with same name but different version

Giống npm Registry.

## Dockerfile - create own images
Dockerfile is definition how to build image from our application

Dockerfile can build a Docker Image.

### Structure of Dockerfile

#### Base image (parent image)
Ví dụ:
- NodeJS image nếu app ta được xây dựng dựa trên JS
- Python image nếu app ta được xây dựng dựa trên Python
- Tomcat image nếu app ta được xây dựng dựa trên Java

Define base image using directive (meaning build our image from the base image)
```
FROM 
```

Every image gồm <b>multiple image layers</b> => image layer can be cached => Efficient

#### Execute Linux Command
Execute any command in shell inside container environment
```
RUN
```

RUN executed in container

#### Copy files from local computer and paste into container
Copies files or dir from <src> and adds to filesystem of container at <dest>
```
COPY
```

COPY executed in host

#### Move into working directory
Move into working directory for following commands like cd in Linux command
```
WORKDIR
```
#### Last command in Dockerfile
Instruction that to be executed when docker container start
```
CMD 
```

just one CMD instruction in dockerfile

#### Note
/app/ slash at the end quan trọng vì docker sẽ tạo folder app nếu không tồn tại trong container

## Build image
```
docker build -t {path_dockerfile} 
```
-t => set name and tag in "name:tag" format

A docker image consist of layers 

Each instruction in docker file create one layer