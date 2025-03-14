# hyprblue-nxt &nbsp; [![bluebuild build badge](https://github.com/pliveyns/hyprblue-nxt/actions/workflows/build.yml/badge.svg)](https://github.com/pliveyns/hyprblue-nxt/actions/workflows/build.yml)

This is a custom image of Fedora Silverblue with Hyprland WM.

See the [BlueBuild docs](https://blue-build.org/how-to/setup/) for quick setup instructions for setting up your own repository based on this template.

## Installation

> [!WARNING]  
> [This is an experimental feature](https://www.fedoraproject.org/wiki/Changes/OstreeNativeContainerStable), try at your own discretion.

To rebase an existing atomic Fedora installation to the latest build:

- First rebase to the unsigned image, to get the proper signing keys and policies installed:
  ```
  rpm-ostree rebase ostree-unverified-registry:ghcr.io/pliveyns/hyprblue-nxt:latest
  ```
- Reboot to complete the rebase:
  ```
  systemctl reboot
  ```
- Then rebase to the signed image, like so:
  ```
  rpm-ostree rebase ostree-image-signed:docker://ghcr.io/pliveyns/hyprblue-nxt:latest
  ```
- Reboot again to complete the installation
  ```
  systemctl reboot
  ```

## Verification

These images are signed with [Sigstore](https://www.sigstore.dev/)'s [cosign](https://github.com/sigstore/cosign). You can verify the signature by downloading the `cosign.pub` file from this repo and running the following command:

```bash
cosign verify --key cosign.pub ghcr.io/pliveyns/hyprblue-nxt
```
