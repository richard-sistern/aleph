# Dockerfile Best Practices

*Notes from Sysdig, examples [available on GitHub](https://github.com/airadier/webinar-dockerfile-best-practices)*

[Top 20 Dockerfile best practices](https://sysdig.com/blog/dockerfile-best-practices/) 

Focus on Dockerfile as removes risk in advance.  Shift left security, tackle issues as soon as possible.

**Shift-left**

- Implement security closer to the earlier stages of the life cycle
- Everyone shares responsibility for security and collaborates towards common goals

**Layer optimisation**

Combine commands to reduce number of layers.  Chain with `&&`

Move RUN command before source copy as source code will change regularly and invalidate RUN layer if set afterwards.

## Permissions

Containers shouldn't be running as root (UID 0).   To run as non-root:

```dockerfile
RUN chown 1000:1000 /app
USER 1000
```

Alternatively to run with any user:

```dockerfile
WORKDIR /tmp
```

Best to split application (UID:1000) and data (root) ownership.  

## Attack Surface

Remove unnecessary packages and unused ports.

Don't build application externally, copy into the container.  Leads to bad reproducibility.  Should build directory inside the final containers.

**Multistage build pattern**

```dockerfile
# This is the builder stage
FROM goland:1.16 as builder
WORKDIR /my-go-app
COPY src .
RUNS GOOS=linux GOARCH=amd64 go build .

# This is the final stage
# We copy artifcats from build stage
FROM alpine
COPY --from=builder /my-go-app/example_app /bin/example_app
ENTRYPOINT ["/bin/example_app"]
```

Don't use big, generic distro images if not required or outdated images.  Prefer verified and official images from trusted repositories and providers.  For example, Bitnami or Google distroless.

Build base image yourself and define a versioning strategy.  Rebuild image and packages periodically.

## Credentials and Confidentiality

*Leaking credential or confidential information*

Don't include hard coded credentials or add credential files/environment variables.  Credential files deleted in the build process can be recovered from image layers.

Be careful with `.` build context.  Best to specify `folder/`

## Linting and Scanning

Incorporate into a CI pipeline.  For example [Haskell Dockerfile Linter](https://github.com/hadolint/hadolint).  Image scanning can be performed at different stages, earlier is better but not always possible.

## Beyond Image Building

Restrict application capabilities at runtime.

Avoid [mutated](https://sysdig.com/blog/toctou-tag-mutability/) (:latest) tags as the underlying image can change.

The docker socket should be protected

Use Docker health checks or Kubernetes liveness probe