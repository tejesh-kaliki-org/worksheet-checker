# PII boundary enforced by opaque IDs, not by Bifrost configuration

Status: accepted

Student name and Roll Number never leave this project's database. Every request to the LLM proxy (Bifrost) is correlated using a Correlation ID minted by this backend — never the Roll Number itself, since roll numbers are often sequential/predictable per class and are treated as indirectly identifying. This holds regardless of who operates Bifrost: during development it runs as shared home-lab infrastructure outside this project's full control, while in production it is expected to run project-owned (via this repo's own Dockerfile), at which point its retention/logging configuration becomes fully governable by this project rather than a third-party trust boundary. The opaque-ID boundary is deliberately not dependent on that ownership distinction — PII safety is designed into the data sent, not into trusting the proxy's configuration, so the guarantee holds the same way in both environments.
