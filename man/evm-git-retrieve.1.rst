..
   SPDX-License-Identifier: AGPL-3.0-or-later

   ----------------------------------------------------------------------
   Copyright © 2024, 2025  Pellegrino Prevete

   All rights reserved
   ----------------------------------------------------------------------

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU Affero General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU Affero General Public License for more details.

   You should have received a copy of the GNU Affero General Public License
   along with this program.  If not, see <https://www.gnu.org/licenses/>.


====================================
evm-git-retrieve
====================================

--------------------------------------------------------------------------------
Ethereum Virtual Machine (EVM) Git Retrieve
--------------------------------------------------------------------------------
:Version: evm-git-retrieve |version|
:Manual section: 1

Synopsis
========

evm-git-retrieve
  *[options]*
  *uri*
  *commit*

Description
===========

Retrieves a git repository commit from a 'GitRepository'
smart contract's deployment uri.

Commands
==========

* publish
* retrieve

Description
===========

The Ethereum Virtual Machine (EVM)
Git is enables publishing and retrieving
git repositories onto Ethereum Virtual Machine
compatible blockchains.
It uses the Ethereum Virtual Machine File System
for storage.

Data is compressed and signed
against deployers or users' EVM GNU Privacy Guard
keys published on the EVM OpenPGP Key Server,
so to avoid users from potentially
malevolent RPC endpoints and
man-in-the-middle attacks.

It depends on the EVM Contracts Tools
to interact with EVM networks and it is
written using the LibEVM and the Crash Bash
libraries.

Networks
========

The list of supported networks can be
consulted using *evm-chains-info*.


Options
========

-P target_publisher     Target source publisher.
                        It defaults to the 'default'
                        evm-wallet account address.

Contract options
=================

-A gr_address           Address of the 'Git Repository'
                        contract on the network.
-V gr_version           Version of the target 'Git Repository'
                        contract.


LibEVM options
================

-u                      Whether to retrieve publishers' contract
                        address from user directory or custom
                        deployment.
-d deployments_dir      Contracts deployments directory.
-n network              EVM network name.


Credentials options
====================

-N wallet_name          Wallet name.
-w wallet_path          Wallet path.
-p wallet_password      Wallet password.
-s wallet_seed          Wallet seed path.
-k api_key              Etherscan-like service key.


Application options
====================

-H gnupg_home           GNUPG home directory.

-h                      Display help.
-c                      Enable color output
-v                      Enable verbose output


Bugs
====

https://github.com/themartiancompany/evm-git/-/issues

Copyright
=========

Copyright Pellegrino Prevete. AGPL-3.0.

See also
========

* evm-contract-call
* evm-contract-source-publish
* evm-openpgp-key-receive
* evm-deployer
* evmfs
* evm-wallet
* evm-chains-info
* libevm
* crash-bash

.. include:: variables.rst
