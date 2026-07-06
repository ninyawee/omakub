# Omakub

Turn a fresh Ubuntu installation into a fully-configured, beautiful, and modern web development system by running a single command. That's the one-line pitch for Omakub. No need to write bespoke configs for every essential tool just to get started or to be up on all the latest command-line tools. Omakub is an opinionated take on what Linux can be at its best.

Watch the introduction video and read more at [omakub.org](https://omakub.org).

## This fork: Ubuntu 26.04 support (`next-ubuntu26` branch)

`master` here is kept as a clean mirror of [basecamp/omakub](https://github.com/basecamp/omakub) so it can always fast-forward from upstream. The `next-ubuntu26` branch carries Ubuntu 26.04 ("Resolute Raccoon") compatibility on top of that:

- Upstream [PR #600](https://github.com/basecamp/omakub/pull/600) — reboot handling, dev-language install/uninstall robustness, a maintained `asdcontrol` fork, and space-bar extension schema compat.
- A fix for [#604](https://github.com/basecamp/omakub/issues/604) — several themes referenced Yaru icon variants and `accent-color` values that don't exist on 26.04's Yaru package / GNOME 47+'s accent enum. `OMAKUB_THEME_COLOR` (Yaru variant) and `OMAKUB_GNOME_ACCENT` (accent-color) are now set independently per theme.

Known gap: [#607](https://github.com/basecamp/omakub/issues/607) (keyboard shortcuts misbehaving on 26.04) is unfixed — no diagnosed root cause yet.

To install from this branch on a fresh Ubuntu 26.04 machine:

```bash
sudo apt-get update
sudo apt-get install -y git
rm -rf ~/.local/share/omakub
git clone https://github.com/ninyawee/omakub.git ~/.local/share/omakub
cd ~/.local/share/omakub
git checkout next-ubuntu26
source ~/.local/share/omakub/install.sh
```

## Contributing to the documentation

Please help us improve Omakub's documentation on the [basecamp/omakub-site repository](https://github.com/basecamp/omakub-site).

## License

Omakub is released under the [MIT License](https://opensource.org/licenses/MIT).

## Extras

While omakub is purposed to be an opinionated take, the open source community offers alternative customization, add-ons, extras, that you can use to adjust, replace or enrich your experience.

[⇒ Browse the omakub extensions.](EXTENSIONS.md)
