<div align="center">
  <h1
    style="font-size: 3rem; font-weight: bold; color: rgb(150, 108, 190);"
    >
    DPKG CHANGELOG
  </h1>
  <h3>
    A simple tool to generate a changelog from a Debian package
  </h3>
</div>

## About

A changelog is a must-have for any software project, however there is no standard across [Linux](https://kernel.org) based distributions. This tool aims to provide a simple way to generate a changelog from a Debian package. Not only does it generate a changelog, it also sets a version number for the package based on number of commits automating the process of versioning when building a package.

### Features

- Generate a changelog from a Debian package
- Set a version number for the package based on number of commits

## Installation

The best way to install this tool is to add the [repository](https://michaelschaecher.github.io/mls/) by following the instructions there. Once you have added the repository, you can install the tool using the following command:

```bash
sudo apt install dpkg-changelog
```

### Manual Installation

If you prefer to install the tool manually:

```bash
wget https://raw.githubusercontent.com/michaelschaecher/dpkg-changelog/main/dpkg-changelog_latest.deb
sudo dpkg -i dpkg-changelog_latest.deb
```

If you have any issues with dependencies, you can run the following command to fix them:

```bash
sudo apt --fix-broken install
```

## Usage

All that you need to do is simply run `dpkg-changelog` as is in the directory of your package.

## Contributing

Contributions are welcome! If you have any suggestions or improvements, please open an issue or a pull request.

## License

This project is licensed under the GNU General Public License v3.0. See the [COPYING](COPYING) file for details.

## Author

- [Michael Schaecher](https://github.com/MichaelSchaecher)
