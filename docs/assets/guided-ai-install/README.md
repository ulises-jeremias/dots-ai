# Guided AI Install — screenshot assets

This folder holds visual assets referenced by [`docs/wiki/GUIDED_AI_INSTALL.md`](../../wiki/GUIDED_AI_INSTALL.md).

## Conventions

- Prefer **PNG** (lossless) at **≤ 1600 px wide**, with clear readable text.
- Filenames follow `NN-os-step-description.png`, padded to 2 digits:
  - `01-windows-open-terminal.png`
  - `02-windows-paste-command.png`
  - `03-windows-success.png`
  - `01-macos-open-terminal.png`
  - `01-linux-open-terminal.png`
- Crop tightly to the relevant UI — avoid capturing full desktops.
- Redact any personal tokens / usernames beyond `you@hostname`.

## Adding new images

1. Drop the PNG here with the naming scheme above.
2. Reference it from `docs/wiki/GUIDED_AI_INSTALL.md` using a relative path:

   ```markdown
   ![Windows PowerShell paste](assets/guided-ai-install/02-windows-paste-command.png)
   ```

3. Keep the alt text descriptive — it is read by screen readers and is the
   fallback when images are blocked (corporate networks, some GitHub previews).

## Why no binaries are tracked yet

Screenshots are taken from real operator machines after each release that
changes the installer UX. Until that happens this README is the placeholder
so the folder is tracked in git without binary churn.
