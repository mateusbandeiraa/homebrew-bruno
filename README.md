# homebrew-bruno

A Homebrew tap that builds [Bruno](https://github.com/usebruno/bruno) from source
and publishes it as a cask, so `brew upgrade` tracks upstream releases.

> **Unofficial.** This is not affiliated with, endorsed by, or supported by the
> Bruno project or its maintainers. `Bruno` is a trademark held by Anoop M D.
> Bruno is MIT-licensed; this tap redistributes a build of that MIT source and
> nothing else.

## Install

```sh
brew tap mateusbandeiraa/bruno
brew trust mateusbandeiraa/bruno
brew install --cask bruno-source
```

`brew trust` is required from Homebrew 7 onwards, which refuses to load casks
from untrusted third-party taps.

The app is ad-hoc signed rather than signed with an Apple Developer ID, and
Gatekeeper refuses a quarantined copy of such a build. Homebrew 7 removed
`--no-quarantine` and always quarantines cask artifacts, so the cask clears the
attribute itself in a `postflight` block — on upgrades as well as first install.

## Upgrade

```sh
brew upgrade --cask bruno-source
```

A scheduled workflow checks `usebruno/bruno` for new release tags once a day,
builds any it finds, publishes the artifact to this repo's releases, and updates
the cask. So `brew upgrade` behaves exactly as it does for any other cask.

To build a specific version, or to rebuild the current one, run the
**Build upstream release** workflow manually from the Actions tab.

## What you get, and what you don't

This builds only what upstream publishes under the MIT license. Features of
Bruno's commercial editions are **not** present in the public source and are not
reconstructed here — no native Git UI, no multiple workspaces, no secret manager
integration, and no cap on OpenAPI syncs, because the code that enforces that cap
was never part of the open-source tree.

One upstream quirk is corrected: `package.json` carries a placeholder version
(`2.0.0`) that upstream does not replace at release time, so the official
binaries report `2.0.0` in their `Info.plist` too. The build stamps the real
version from the tag, so the status bar, User-Agent and export metadata all
agree with the release.

## Limitations

- **Apple Silicon only.** The workflow builds `--arm64`. Add an x64 matrix leg
  and an `on_intel` block in the cask if you need Intel.
- **Ad-hoc signed.** Signing properly requires an Apple Developer ID ($99/yr)
  and the matching secrets in Actions.
- **Conflicts with the official cask.** `bruno` and `bruno-source` install to
  the same `/Applications/Bruno.app`, so the cask declares a conflict. Uninstall
  `bruno` first.

## License

The tap's own files (workflow, cask, this README) are MIT. Bruno itself is MIT,
Copyright (c) 2022 Anoop M D, Anusree P S and Contributors — see
[license.md](https://github.com/usebruno/bruno/blob/main/license.md) upstream.
