
<img src=".github/ergo-nix.png" align="left" height="100" />

# Ergo Nix Toolkit

This repository provides Nix derivations for packages and services of [the Ergo ecosystem](https://ergoplatform.org/en/).

### [Why Nix?](https://nixos.org/guides/nix-pills/why-you-should-give-it-a-try.html)

There are many existing systems for software configuration and most of them are far more user friendly than Nix. However, I feel like Nix is the best available tool to build immutable and pure (as in functional programming) *Infrastructure as a Code*, which is so important in the FinTech world.

The way Nix calculates whether a derivation input has changed is by taking its cryptographic hash. Dependencies are recursive, so this hash is actually a hash of hashes — a powerful concept instantly recognizable to blockchain enthusiasts. If any of the inputs change, so does the result and therefore we end up with a totally different software package.

## Features
### Packages

 * `ergo-node`
   * provides the Ergo blockchain nodes
 * `ergo-explorer-backend`
   * provides Ergo explorer backend tooling (chain-grabber, explorer-api and utx-{watcher,broadcaster})
 * `ergo-explorer-frontend`
   * provides the Ergo explorer web interface
### Services
  * `services.ergo-node`

## Installation and setup

If you are not running NixOS, you need to at least install [Nix](https://nixos.org/download.html)

```bash
$ curl -L https://nixos.org/nix/install | sh
```

After installing Nix, add the following to `/etc/nix/nix.conf` to take advantage of the cache, so you do not have to rebuild everything. After adding it, you need to restart the `nix-daemon` service.

```
substituters         = https://cache.nixos.org https://ergo-nix.cachix.org
trusted-public-keys  = cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY= ergo-nix.cachix.org-1:5T2FPh0TfxXqrMYAwf/VGDycBW6Dy/W/L6I3DFhc1iQ=
```

If you are using NixOS, you probably know how to add these as your binary caches.

## Usage

You can add it as a channel.

```bash
$ nix-channel --add https://github.com/mmahut/ergo-nix/archive/master.tar.gz ergo-nix
$ nix-channel --update
unpacking channels...
```

```bash
$ nix-env -iA ergo-nix.ergo-node
installing 'ergo-node-3.3.6'
```

Or you can just use it directly as a Nix path.

```bash
$ nix-env -iA ergo-node -f https://github.com/mmahut/ergo-nix/archive/master.tar.gz
unpacking 'https://github.com/mmahut/ergo-nix/archive/master.tar.gz'...
installing 'ergo-node-3.3.6'
```
