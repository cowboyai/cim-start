As a Rust developer working on distributed systems, using OCI+WASM instead of WASI for production services on 1/1/2025 offers significant advantages in terms of portability, ecosystem integration, and deployment efficiency. OCI (Open Container Initiative) registries provide a standardized and widely supported mechanism for packaging and distributing WebAssembly (WASM) modules, allowing you to leverage existing container ecosystems like Docker Hub or Azure Container Registry without additional overhead. This simplifies CI/CD pipelines by enabling the same artifact to run across diverse environments—cloud, edge, or on-premises—without requiring architecture-specific builds. Moreover, OCI+WASM integrates seamlessly with Kubernetes and other cloud-native tools, enabling distributed-first architectures using platforms like wasmCloud and NATS for connectivity. While WASI focuses on extending WASM with OS-like APIs, its feature set is less mature and not as universally supported as OCI-based workflows. By adopting OCI+WASM, you gain access to robust tooling, secure distribution mechanisms (e.g., image signing), and the ability to manage dependencies dynamically through tools like Rust's `cargo-component`, making it an ideal choice for scalable, distributed systems[1][3][5].

Over time we expect this dynamic to change and we are ready for WASI, but need a realistic alternative.
In the same way we can't do all layout in html, but we still need to support it.

Citations:
[1] https://opensource.microsoft.com/blog/2024/09/25/distributing-webassembly-components-using-oci-registries/
[2] https://www.redhat.com/en/blog/red-hat-and-webassembly
[3] https://wasmcloud.com/blog/how-webassembly-components-extend-the-frontiers-of-kubernetes-to-multi-cloud-edge-and-beyond
[4] https://www.thorsten-hans.com/distribute-webassembly-modules-as-oci-artifacts/
[5] https://wasmcloud.com/blog/WebAssembly-components-the-next-wave-of-cloud-native-computing
[6] https://www.cncf.io/blog/2024/07/09/webassembly-components-the-next-wave-of-cloud-native-computing/
[7] https://www.amplifypartners.com/blog-posts/how-webassembly-gets-used-the-18-most-exciting-startups-building-with-wasm
[8] https://arxiv.org/html/2408.04856v1
[9] https://users.rust-lang.org/t/wasm32-unknown-unknown-vs-wasm32-wasi/78325
[10] https://www.sobyte.net/post/2022-12/oci-wasm/
[11] https://opensource.com/article/22/10/wasm-containers