[comment]: <> (SPDX-License-Identifier: AGPL-3.0)

[comment]: <> (-------------------------------------------------------------)
[comment]: <> (Copyright © 2024, 2025  Pellegrino Prevete)
[comment]: <> (All rights reserved)
[comment]: <> (-------------------------------------------------------------)

[comment]: <> (This program is free software: you can redistribute)
[comment]: <> (it and/or modify it under the terms of the GNU Affero)
[comment]: <> (General Public License as published by the Free)
[comment]: <> (Software Foundation, either version 3 of the License.)

[comment]: <> (This program is distributed in the hope that it will be useful,)
[comment]: <> (but WITHOUT ANY WARRANTY; without even the implied warranty of)
[comment]: <> (MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the)
[comment]: <> (GNU Affero General Public License for more details.)

[comment]: <> (You should have received a copy of the GNU Affero General Public)
[comment]: <> (License along with this program.)
[comment]: <> (If not, see <https://www.gnu.org/licenses/>.)


# Ethereum Virtual Machine Git

The Ethereum Virtual Machine (EVM)
Git is enables publishing and retrieving
git repositories onto Ethereum Virtual Machine
compatible blockchains.
It uses the
[Ethereum Virtual Machine File System](
  https://github.com/themartiancompany/evmfs)
for storage.

Data is compressed and signed
against deployers or users' 
[EVM GNU Privacy Guard](
  https://github.com/themartiancompany/evm-gnupg)
keys published on the
[EVM OpenPGP Key Server](
  https://github.com/themartiancompany/evm-openpgp-keyserver),
so to avoid users from potentially
malevolent RPC endpoints and
man-in-the-middle attacks.

It depends on the
[EVM Contracts Tools](
  https://github.com/themartiancompany/evm-contracts-tools)
to interact with EVM networks and it is
written using the
[LibEVM](
  https://github.com/themartiancompany/libevm)
and the
[Crash Bash](
  https://github.com/themartiancompany/crash-bash)
libraries.

### Installation

The program can be installed with a simple

```bash
make
make \
  install
```

Being the program written using the EVM Toolchain,
the build procedure requires
[EVM Make](
  https://github.com/themartiancompany/evm-make)
and
[Solidity Compiler](
  https://github.com/themartiancompany/solidity-compiler)
to be installed and available on the system.

The program has been officially published on the
the uncensorable
[Ur](
  https://github.com/themartiancompany/ur)
user repository and application store as
`evm-git`.
The source code is published on the
[Ethereum Virtual Machine File System](
  https://github.com/themartiancompany/evmfs)
so it can't possibly be taken down.

To install it from there just type

```bash
ur \
  evm-git
```

A censorable HTTP Github mirror of the recipe published there,
containing a full list of the software dependencies needed to run the
tools is hosted on
[evm-git-ur](
  https://github.com/themartiancompany/evm-git-ur).

Be aware the mirror could go offline any time as Github and more
in general all HTTP resources are inherently unstable and censorable.


### Usage

To upload the source code for
a contract one can type

```bash
evm-git \
  -v \
  publish \
    <commit_hash>
```

while to retrieve the source code one can
type

```bash
evm-git \
  -v \
  retrieve \
    <commit_hash>
```

For further information and options consult
the manuals

```bash
man \
  evm-git
man \
  evm-git
```

or run the commands with the `-h` help option.

## License

This program is released under the terms of the GNU
Affero General Public License version 3.0.
