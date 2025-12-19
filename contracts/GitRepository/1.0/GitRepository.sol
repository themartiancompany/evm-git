// SPDX-License-Identifier: AGPL-3.0

/**    ----------------------------------------------------------------------
 *     Copyright ©
 *       Pellegrino Prevete
 *         2024, 2025
 * 
 *     All rights reserved
 *     ----------------------------------------------------------------------
 * 
 *     This program is free software: you can redistribute it and/or modify
 *     it under the terms of the GNU General Public License as published by
 *     the Free Software Foundation, either version 3 of the License, or
 *     (at your option) any later version.
 * 
 *     This program is distributed in the hope that it will be useful,
 *     but WITHOUT ANY WARRANTY; without even the implied warranty of
 *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *     GNU General Public License for more details.
 * 
 *     You should have received a copy of the GNU General Public License
 *     along with this program.  If not, see <https://www.gnu.org/licenses/>.
 *
 *     ----------------------------------------------------------------------
 */

pragma solidity >=0.7.0 <0.9.0;

/**
 * @title Git Repository
 * @dev Partial Solidity Git repository data structure implementation.
 */
contract GitRepository {

  address public immutable deployer = 0xea02F564664A477286B93712829180be4764fAe2;

  mapping(
    address => mapping(
      string => bool ) ) public readable;
  mapping(
    address => mapping(
      string => uint256 ) ) public commitsNo;
  mapping(
    address => mapping(
      string => mapping(
        uint256 => string ) ) ) public commits;
  mapping(
    address => mapping(
      string => mapping(
        string => string ) ) ) public commit;
  mapping(
    address => mapping(
      string => mapping(
        string => uint256 ) ) ) public parentChainId;
  mapping(
    address => mapping(
      string => mapping(
        string => address) ) ) public parentNamespace;
  mapping(
    address => mapping(
      string => mapping(
        string => string ) ) ) public parentRepository;
  mapping(
    address => mapping(
      string => mapping(
        string => string ) ) ) public parent;
  mapping(
    address => mapping(
      string => mapping(
        string => mapping(
          uint256 => address ) ) ) ) public readers;
  mapping(
    address => mapping(
      string => mapping(
        string => uint256 ) ) ) public readersNo;
  mapping(
    address => mapping(
      string => mapping(
        string => mapping(
          address => bool ) ) ) ) public reader;
  mapping(
    address => mapping (
      string => mapping(
        string => bool ) ) ) public lock;
  mapping(
    address => mapping(
      string => mapping(
        string => mapping(
          uint256 => mapping(
            uint256 => string) ) ) ) ) public head;
  mapping(
    address => mapping(
      string => mapping(
        string => uint256 ) ) ) public epoch;
  mapping(
    address => mapping(
      string => mapping(
        string => mapping(
          uint256 => uint256 ) ) ) ) public length;

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
    checkNewReader(
      _namespace,
      _repository,
      _commit,
      _reader);
    uint256 _readersNo =
      readersNo[
        _namespace][
          _repository][
            _commit] + 1;
    readersNo[
      _namespace][
        _repository][
          _commit] =
      _readersNo;
    readers[
      _namespace][
        _repository][
          _commit][
            _readersNo] =
      _reader;
    reader[
      _namespace][
        _repository][
          _commit][
            _reader] =
      _readersNo;
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
    checkReader(
      _namespace,
      _repository,
      _commit,
      _reader);
    uint256 _readerNo =
      reader[
        _namespace][
          _repository][
            _commit][
              _reader];
    readers[
      _namespace][
        _repository][
          _commit][
            _readerNo] =
      address(
        0);
    reader[
      _namespace][
        _repository][
          _commit][
            _reader] =
      0;
  }

  /**
   * @dev Check reader.
   * @param _namespace Repository namespace.
   */
  function checkReader(
    address _namespace,
    string memory _repository,
    string memory _commit,
    address _reader
  )
    public
    view {
    require(
      reader[
        _namespace][
          _repository][
            _commit][
              _reader] > 0,
        "The reader has no read access to this commit on the repository."
    );
  }


  /**
   * @dev Check reader has currently no read access to the commit on the repository.
   * @param _namespace Repository namespace.
   * @param _namespace Repository namespace.
   */
  function checkNewReader(
    address _namespace,
    string memory _repository,
    string memory _commit,
    address _reader
  )
    public
    view {
    require(
      reader[
        _namespace][
          _repository][
            _commit][
              _reader] == 0,
        "The reader already has read access this commit on the repository."
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
          _repository],
      "The repository is not public."
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
              _commit],
      "The repository is locked."
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
            _commit],
      "The repository is unlocked."
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
   * @dev Publishes a parent for a commit onto a Repository.
   * @param _namespace Git repository namespace.
   * @param _repository Repository name.
   * @param _commit Target commit.
   * @param _parent_namespace Parent commit namespace.
   * @param _parent_repository Parent commit git repository.
   * @param _parent Parent commit.
   */
  function setParent(
    address _namespace,
    string memory _repository,
    string memory _commit,
    uint256 _parent_chain_id,
    address _parent_namespace,
    string memory _parent_repository,
    string memory _parent) public {
    checkOwner(
      _namespace);
    checkUnlocked(
      _namespace,
      _repository,
      _commit);
    parentChainId[
      _namespace][
        _repository][
          _commit] =
      _parent_chain_id;
    parentNamespace[
      _namespace][
        _repository][
          _commit] =
      _parent_namespace;
    parentRepository[
      _namespace][
        _repository][
          _commit] =
      _parent_repository;
    parent[
      _namespace][
        _repository][
          _commit] =
      _parent;
  }

  /**
   * @dev Lock the commit.
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
   * @dev Get current head commit for a branch.
   * @param _namespace Git repository namespace.
   * @param _repository Repository name.
   * @param _branch Branch of which to get the branch head.
   */
  function getHead(
    address _namespace,
    string memory _repository,
    string memory _branch) public
    returns (string memory)
    {
    uint256 _epoch =
      epoch[
        _namespace][
          _repository][
            _branch];
    uint256 _length =
      length[
        _namespace][
          _repository][
            _branch][
              _epoch];
    string memory _head =
      head[
        _namespace][
          _repository][
            _branch][
              _epoch][
                _length];
    return _head;
  }

  /**
   * @dev Check head set is not a forced update.
   * @param _commit Git repository namespace.
   * @param _repository Repository name.
   * @param _branch Branch of which to set the branch head.
   * @param _commit Commit you want to check if compatible with current head.
   */
  function isNotForcedUpdate(
    address _namespace,
    string memory _repository,
    string memory _branch,
    string memory _commit)
    public 
    returns (bool) {
    string memory _parent =
      parent[
        _namespace][
          _repository][
            _commit];
    string memory _head =
      getHead(
        _namespace,
        _repository,
        _branch);
    return ( _head == _commit );
  }

  /**
   * @dev Set head for a branch.
   * @param _namespace Git repository namespace.
   * @param _repository Repository name.
   * @param _branch Branch of which to set the branch head.
   * @param _commit Commit to set as branch head.
   */
  function setHead(
    address _namespace,
    string memory _repository,
    string memory _branch,
    string memory _commit) public {
    checkOwner(
      _namespace);
    checkLocked(
      _namespace,
      _repository,
      _commit);
    uint256 _epoch =
      epoch[
        _namespace][
          _repository][
            _branch];
    uint256 _length =
      length[
        _namespace][
          _repository][
            _branch][
              _epoch];
    if ( _epoch != 0 &&
         _length != 0 ) {
      require(
        _isNotForcedUpdate(
          _namespace,
          _repository,
          _branch,
          _commit),
          "To push an incompatible head use 'newHead'.");
    }
    head[
      _namespace][
        _repository][
          _branch][
            _epoch][
             _length] =
      _commit;
    length[
      _namespace][
        _repository][
          _branch][
            _epoch] =
      _length + 1;
  }

  /**
   * @dev Set new epoch for a branch.
   * @param _namespace Git repository namespace.
   * @param _repository Repository name.
   * @param _branch Branch of which to set the branch head.
   */
  function setEpoch(
    address _namespace,
    string memory _repository,
    string memory _branch)
    public {
    checkOwner(
      _namespace);
    uint256 _epoch =
      epoch[
        _namespace][
          _repository][
            _branch];
    epoch[
      _namespace][
        _repository][
          _branch] =
      _epoch + 1;
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
                          _commit,
			  msg.sender),
      "The repository is not public or the reader has no read access."
    );
    return commit[
             _namespace][
               _repository][
                 _commit];
  }
}
