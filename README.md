# sandcrab

Run [Claude Code](https://github.com/anthropics/claude-code) inside a disposable Docker sandbox. `sandcrab` builds an Ubuntu image with the Claude CLI (plus git, Python via pyenv, and Node) and drops you into `claude` with the current directory mounted as the workspace — so the agent can only touch the project you launched it from.

## Installation

```sh
curl -fsSL https://raw.githubusercontent.com/<owner>/sandcrab/master/install.sh | sh
```

This downloads `sandcrab` and `Dockerfile.template` into `~/.sandcrab/bin`. Add that directory to your `PATH` (the installer prints this line — put it in your `~/.bashrc`, `~/.zshrc`, etc.):

```sh
export PATH="$HOME/.sandcrab/bin:$PATH"
```

You'll also need [Docker](https://docs.docker.com/get-docker/) installed and running.

## What this does

Running `sandcrab` from any project directory:

1. **Builds a sandbox image** with the Claude Code CLI, `git`, `ssh`, `python`, and `node`.
2. **Mounts the current directory** into the container at `/workspace`, so Claude operates only there.
3. **Persists Claude's config and login** in `./.sandcrab/config`, bind-mounted into the container — so you stay logged in across runs without leaking credentials into the image.
4. **Runs `claude`** interactively, forwarding any arguments you pass (e.g. `sandcrab --model opus`).

### Per-workspace state (`.sandcrab/`)

Each workspace gets a `.sandcrab/` directory at its root:

- `.sandcrab/config` — Claude's config and login, bind-mounted into the container.
- `.sandcrab/packages` — optional list of extra Debian packages to install in the image (one per line; `#` comments and blank lines ignored).

Add `.sandcrab/` to your project's `.gitignore` to keep it out of version control.
