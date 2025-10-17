// SPDX-License-Identifier: AGPL-3.0

//    ----------------------------------------------------------------------
//    Copyright © 2024, 2025  Pellegrino Prevete
//
//    All rights reserved
//    ----------------------------------------------------------------------
//
//    This program is free software: you can redistribute it and/or modify
//    it under the terms of the GNU Affero General Public License as published by
//    the Free Software Foundation, either version 3 of the License, or
//    (at your option) any later version.
//
//    This program is distributed in the hope that it will be useful,
//    but WITHOUT ANY WARRANTY; without even the implied warranty of
//    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//    GNU Affero General Public License for more details.
//
//    You should have received a copy of the GNU Affero General Public License
//    along with this program.  If not, see <https://www.gnu.org/licenses/>.

pragma solidity >=0.7.0 <0.9.0;

/**
 * @title Git Repository
 * @dev Partial Solidity Git repository data structure implementation.
 */
contract GitRepository {

  address public immutable deployer = 0xea02F564664A477286B93712829180be4764fAe2;
  string public hijess = "mm";

  mapping(
    address => mapping (
      string => bool ) ) public readable;
  mapping(
    address => mapping (
      string => uint256 ) ) public commitsNo;
  mapping(
    address => mapping (
      string => mapping(
        uint256 => string ) ) ) public commits;
  mapping(
    address => mapping (
      string => mapping(
        string => string ) ) ) public commit;
  mapping(
    address => mapping (
      string => mapping(
        string => string ) ) ) public parent;
  mapping(
    address => mapping (
      string => mapping(
        string => uint256 ) ) public readersNo;
  mapping(
    address => mapping (
      string => mapping(
        string => mapping(
          uint256 => address ) ) ) ) public readers;
  mapping(
    address => mapping (
      string => mapping(
        string => mapping(
          address => bool ) ) ) ) public reader;
  mapping(
    address => mapping (
      string => mapping(
        string => bool ) ) ) public lock;
  constructor() {}

  /**
   * @dev Check owner.
   * @param _namespace Repository namespace.
   */
  function checkOwner(
    address _namespace)
    public
    view {
    require(
      msg.sender == _namespace
    );
  }

  /**
   * @dev Check reader.
   * @param _namespace Repository namespace.
   */
  function addReader(
    address _namespace,
    string memory _repository,
    string memory _commit,
    address _reader
  )
    public
    view {
    checkOwner(
      _namespace);
    require(
      reader[
        _namespace][
          _repository][
            _commit][
              _reader] ==
        false
    );
    reader[
      _namespace][
        _repository][
          _commit][
            _reader] =
      true;
    readers[
      _namespace][
        _repository][
          _commit][
      readersNo[
        _namespace][
          _repository][
            _commit]]
  }

  /**
   * @dev Remove reader.
   * @param _namespace Repository namespace.
   */
  function removeReader(
    address _namespace,
    string memory _repository,
    string memory _commit,
    address _reader
  )
    public
    view {
    checkOwner(
      _namespace);
    reader[
      _namespace][
        _repository][
          _commit][
            _reader] =
      false;
  }

  /**
   * @dev Make a reader listable.
   * @param _namespace Repository namespace.
   */
  function listReader(
    address _namespace,
    string memory _repository,
    string memory _commit,
    address _reader
  )
    public
    view {
    checkOwner(
      _namespace);
    reader[
      _namespace][
        _repository][
          _commit][
            _reader] =
      true;
  }

  /**
   * @dev Check reader.
   * @param _namespace Repository namespace.
   */
  function checkReader(
    address _namespace,
    string memory _repository,
    string memory _commit
  )
    public
    view {
    require(
      reader[
        _namespace][
	  _repository][
	    _commit][
	      msg.sender]
    );
  }

  /**
   * @dev Check global read state.
   * @param _namespace Repository namespace.
   * @param _repository Repository name.
   */
  function checkPublic(
    address _namespace,
    string memory _repository)
    public
    {
    require(
      readable[
        _namespace][
          _repository]
    );
  }

  /**
   * @dev Check commit unlock state.
   * @param _namespace Repository namespace.
   * @param _repository Repository name.
   * @param _commit Commit for which to check the lock state.
   */
  function checkUnlocked(
    address _namespace,
    string memory _repository,
    string memory _commit)
    public
    view {
    require(
      ! lock[
          _namespace][
            _repository][
              _commit]
    );
  }

  /**
   * @dev Checks commit lock state.
   * @param _namespace Repository namespace.
   * @param _repository Repository name.
   * @param _commit Commit for which to check the lock state.
   */
  function checkLocked(
    address _namespace,
    string memory _repository,
    string memory _commit)
    public
    view {
    require(
      lock[
        _namespace][
          _repository][
            _commit]
    );
  }

  /**
   * @dev Check an URI is an EVMFS resource.
   * @param _uri The URI to check.
   */
  function checkUri(
    string memory _uri)
    internal
    pure {
    bytes memory _prefix =
      bytes(
        "evmfs://");
    bytes memory _uri_prefix =
      new bytes(
        8);
    for(
      uint _i = 0;
      _i <= 7;
      _i++){
      _uri_prefix[
        _i] =
        bytes(
          _uri)[
            _i];
    }
    require(
      _uri_prefix.length == _prefix.length &&
      keccak256(
        _uri_prefix) == keccak256(
                          _prefix),
      "Input is not an EVMFS uri.");
  }

  /**
   * @dev Publishes a commit onto a Repository.
   * @param _namespace Git repository namespace.
   * @param _repository Repository name.
   * @param _commit Commit to publish.
   */
  function publishCommit(
    address _namespace,
    string memory _repository,
    string memory _commit,
    string memory _uri) public {
    checkOwner(
      _namespace);
    checkUnlocked(
      _namespace,
      _repository,
      _commit);
    checkUri(
      _uri);
    commit[
      _namespace][
        _repository][
          _commit] =
      _uri;
  }

  /**
   * @dev Lock the contract source.
   * @param _namespace Git repository namespace.
   * @param _repository Repository name.
   * @param _commit Commit to publish.
   */
  function lockCommit(
    address _namespace,
    string memory _repository,
    string memory _commit)
  public
  {
    checkOwner(
      _namespace);
    checkUnlocked(
      _namespace,
      _repository,
      _commit);
    lock[
      _namespace][
        _repository][
          _commit] =
      true;
    uint256 _commitsNo =
      commitsNo[
        _namespace][
          _repository];
    commits[
      _namespace][
        _repository][
          _commitsNo] =
      _commit;
    commitsNo[
      _namespace][
        _repository] =
      _commitsNo + 1;
  }

  /**
   * @dev Read URI for a repository commit.
   * @param _namespace Repository namespace.
   * @param _repository Repository name.
   * @param _commit Commit to publish.
   */
  function readUri(
    address _namespace,
    string memory _repository,
    string memory _commit)
  public
  view
  returns (string memory)
  {
    checkLocked(
      _namespace,
      _repository,
      _commit
    );
    require(
      checkPublic(
        _namespace,
	_repository) || checkReader(
                          _namespace,
                          _repository,
                          _commit
    );
    return commit[
             _namespace][
               _repository][
                 _commit];
  }
}
