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
evm-git-publish
====================================

--------------------------------------------------------------------------------
Ethereum Virtual Machine (EVM) Git publishing tool
--------------------------------------------------------------------------------
:Version: evm-git-publish |version|
:Manual section: 1

Synopsis
========

evm-git-publish
  *[options]*
  *uri*
  *commit*

Description
===========

Publishes a git repository commit on a 'GitRepository'
smart contract's deployment.

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

* evm-git
* evm-git-retrieve
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
