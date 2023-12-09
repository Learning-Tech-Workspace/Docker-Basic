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