#!/usr/bin/env node
// Builds per-service OpenAPI bundles for the local Scalar docs viewer.
//
// Each services/*.yaml is already self-contained (no cross-file $refs), so
// bundling here just normalizes/copies them into scalar/services/ and
// regenerates the sources.json manifest that scalar/index.html reads to
// populate its document-selector dropdown.
//
// Service files are auto-discovered: any services/*.yaml that declares
// `paths:` is treated as a service. Files without paths (shared components,
// if any get added later) are skipped automatically.

const fs = require("node:fs");
const path = require("node:path");
const yaml = require("js-yaml");

const apiDir = path.resolve(__dirname, "..");
const servicesDir = path.join(apiDir, "services");
const distDir = path.join(apiDir, "scalar", "services");

function main() {
  fs.mkdirSync(distDir, { recursive: true });

  const files = fs
    .readdirSync(servicesDir)
    .filter((f) => f.endsWith(".yaml") || f.endsWith(".yml"))
    .sort();

  const sources = [];
  for (const file of files) {
    const srcPath = path.join(servicesDir, file);
    const doc = yaml.load(fs.readFileSync(srcPath, "utf8")) || {};

    if (!doc.paths || Object.keys(doc.paths).length === 0) {
      console.log(`skip   ${file} (no paths)`);
      continue;
    }

    fs.copyFileSync(srcPath, path.join(distDir, file));
    const slug = file.replace(/\.ya?ml$/, "");
    const title = doc.info?.title || slug;
    sources.push({ slug, title, url: `services/${file}` });
    console.log(`bundle ${file} -> ${title}`);
  }

  fs.writeFileSync(
    path.join(apiDir, "scalar", "sources.json"),
    JSON.stringify(sources, null, 2),
  );
  console.log(`\nWrote ${sources.length} service(s) to scalar/sources.json`);
}

main();
