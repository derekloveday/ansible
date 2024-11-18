# ansible
Fully automated development environment

## Goals

Provide fully automated multiple-OS development environment that is easy to set up and maintain.

### Why Ansible?

Ansible replicates what we would do to set up a development environment pretty well. There are many automation solutions out there - I happen to enjoy using Ansible.

## Requirements

### Operating System

This Ansible playbook only supports multiple OS's on a per-role basis. This gives a high level of flexibility to each role.

This means that you can run a role, and it will only run if your current OS is configured for that role.

This is accomplished with this `template` `main.yml` task in each role:
```yaml
---
- name: "{{ role_name }} | Checking for Distribution Config: {{ ansible_distribution }}"
  ansible.builtin.stat:
    path: "{{ role_path }}/tasks/os/{{ ansible_distribution }}.yml"
  register: distribution_config

- name: "{{ role_name }} | Run Tasks: {{ ansible_distribution }}"
  ansible.builtin.include_tasks: "{{ role_path }}/tasks/os/{{ ansible_distribution }}.yml"
  when: distribution_config.stat.exists
```
The first task checks for the existence of a `roles/<target role>/tasks/os/<current_distro>.yml` file. If that file exists (example `current_distro:MacOSX` and a `MacOSX.yml` file exists) it will be run automatically. This keeps roles from breaking if you run a role that isn't yet supported or configured for the system you are running `dotfiles` on.

Currently configured 'bootstrap-able' OS's:
- Ubuntu
- Archlinux (btw)
- MacOSX (darwin)

`bootstrap-able` means the pre-dotfiles setup is configured and performed automatically by this project. For example, before we can run this ansible project, we must first install ansible on each OS type.

To see details, see the `__task "Loading Setup for detected OS: $ID"` section of the `bin/dotfiles` script to see how each OS type is being handled.

### System Upgrade

Verify your `supported OS` installation has all latest packages installed before running the playbook.

```
# Ubuntu
sudo apt-get update && sudo apt-get upgrade -y
# Arch
sudo pacman -Syu
# MacOSX (brew)
brew update && brew upgrade
```

> [!NOTE]
> This may take some time...

## Setup

### all.yml values file

The `all.yml` file allows you to personalize your setup to your needs. This file will be created in the file located at `~/.dotfiles/group_vars/all.yaml` after you [Install this dotfiles](#install) and include your desired settings.

Below is a list of all available values. Not all are required but incorrect values will break the playbook if not properly set.

| Name             | Type                                   | Required |
| ---------------- | -------------------------------------- | -------- |
| default_roles    | list `(for roles to run)`              | yes      |
| env              | object `(see ENV Variable below)`      | yes      |
| op               | object `(see OP Variable below)`       | yes      |

### 1Password Integration

This project depends on a 1Password vault. This means you must have a setup and authenticated `op-cli` for CLI access to your vault. This can be done by installing the 1Password desktop application **OR** can be setup with the `op` cli only, but it a bit more annoying that way since the CLI tool can directly integrate with the Desktop application.

The initial run of `dotfiles` on a new system **should** error without 1Password being setup and having access to a vault (currently defaults to `my.1password.com`)

#### ENV Variable

Manage environment variables in order to avoid having to do lookup(..., ...) calls throughout the code

##### env.xdg_config_dir

`env.xdg_config_dir` is the XDG_CONFIG_DIR environment variable. XDG_CONFIG_DIR may initial be empty and will be defaulted to $HOME/.config in that case.

#### OP (1Password) Variable

Manage environment-critical items without needing `ansible-vault`, by using your `1Password` vault.

> [!NOTE]
> Currently, unless an `account` value is specified, the following `op` vaults assume `my.1password.com` vault.
##### op.git

`op.git` is where you will store any git-related vault paths. All values must be paths to vault.

###### op.git.personal
This variable stores `username` and `email` for personal github accounts

Example `op.git.personal` config:
```yaml
op:
  git:
    personal:
      username: "op://Dev Environment/Personal Git/username"
      email: "op://Dev Environment/Personal Git/email"
```
###### op.git.work
This variable stores `username` and `email` for work git accounts

Example `op.git.work` config:
```yaml
op:
  git:
    work:
      username: "op://Dev Environment/Work Git/username"
      email: "op://Dev Environment/Work Git/email"
```

## Usage

### Install

This playbook includes a custom shell script located at `bin/dotfiles`. This script is added to your $PATH after installation and can be run multiple times while making sure any Ansible dependencies are installed and updated.

This shell script is also used to initialize your environment after bootstrapping your `supported-OS` and performing a full system upgrade as mentioned above.

> [!NOTE]
> You must follow required steps before running this command or things may become unusable until fixed.

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/derekloveday/dotfiles/main/bin/dotfiles)"
```

If you want to run only a specific role, you can specify the following bash command:
```bash
curl -fsSL https://raw.githubusercontent.com/derekloveday/dotfiles/main/bin/dotfiles | bash -s -- --tags comma,seperated,tags
```

### Update

This repository is continuously updated with new features and settings which become available to you when updating.

To update your environment run the `dotfiles` command in your shell:

```bash
dotfiles
```

This will handle the following tasks:

- Verify Ansible is up-to-date
- Clone this repository locally to `~/.dotfiles`
- Verify any `ansible-galaxy` plugins are updated
- Run this playbook with the values in `~/.config/dotfiles/group_vars/all.yaml`

This `dotfiles` command is available to you after the first use of this repo, as it adds this repo's `bin` directory to your path, allowing you to call `dotfiles` from anywhere.

Any flags or arguments you pass to the `dotfiles` command are passed as-is to the `ansible-playbook` command.

For Example: Running the tmux tag with verbosity
```bash
dotfiles -t tmux -vvv
```

As an added bonus, the tags have tab completion!
```bash
dotfiles -t <tab><tab>
dotfiles -t t<tab>
dotfiles -t ne<tab>
```
