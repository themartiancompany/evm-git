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
      string => uint256 ) ) public access;
  mapping(
    address => mapping(
      string => mapping(
        string => uint256 ) ) ) public branchAccess;
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
          address => uint256 ) ) ) ) public reader;
  mapping(
    address => mapping(
      string => mapping(
        string => mapping(
          uint256 => address ) ) ) ) public branchReaders;
  mapping(
    address => mapping(
      string => mapping(
        string => uint256 ) ) ) public branchReadersNo;
  mapping(
    address => mapping(
      string => mapping(
        string => mapping(
          address => uint256 ) ) ) ) public branchReader;
  mapping(
    address => mapping (
      string => mapping(
        string => bool ) ) ) public lock;
  mapping(
    address => mapping(
      string => mapping(
        string => mapping(
          uint256 => mapping(
            uint256 => string ) ) ) ) ) public head;
  mapping(
    address => mapping(
      string => mapping(
        string => mapping(
            uint256 => string ) ) ) ) public tag;
  mapping(
    address => mapping(
      string => mapping(
        string => uint256 ) ) ) public tagNo;
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
    view
    {
    require(
      msg.sender == _namespace,
      "Call sender is not namespace owner."
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
    address _reader)
    public
    {
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
   * @param _repository Repository name.
   * @param _commit Commit for which to remove the reader.
   * @param _reader The reader to remove.
   */
  function removeReader(
    address _namespace,
    string memory _repository,
    string memory _commit,
    address _reader)
    public
    {
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
   * @param _repository Repository name.
   * @param _commit Commit for which to remove the reader.
   * @param _reader The reader to remove.
   */
  function checkReader(
    address _namespace,
    string memory _repository,
    string memory _commit,
    address _reader)
    public
    view
    {
    require(
      _namespace == _reader ||
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
   * @param _repository Repository name.
   * @param _commit Commit for which to remove the reader.
   * @param _reader The reader to remove.
   */
  function checkNewReader(
    address _namespace,
    string memory _repository,
    string memory _commit,
    address _reader)
    public
    view
    {
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
   * @dev Remove branch reader.
   * @param _namespace Repository namespace.
   * @param _repository Repository name.
   * @param _branch Repository branch.
   * @param _reader The reader to remove.
   */
  function removeBranchReader(
    address _namespace,
    string memory _repository,
    string memory _branch,
    address _reader)
    public
    {
    checkOwner(
      _namespace);
    checkBranchReader(
      _namespace,
      _repository,
      _branch,
      _reader);
    uint256 _branchReaderNo =
      branchReader[
        _namespace][
          _repository][
            _branch][
              _reader];
    branchReaders[
      _namespace][
        _repository][
          _branch][
            _branchReaderNo] =
      address(
        0);
    branchReader[
      _namespace][
        _repository][
          _branch][
            _reader] =
      0;
  }

  /**
   * @dev Check branch reader.
   * @param _namespace Repository namespace.
   * @param _repository Repository name.
   * @param _branch Repository branch.
   * @param _reader The reader to remove.
   */
  function checkBranchReader(
    address _namespace,
    string memory _repository,
    string memory _branch,
    address _reader)
    public
    view
    {
    require(
      _namespace == _reader ||
      branchReader[
        _namespace][
          _repository][
            _branch][
              _reader] > 0,
        "The reader has no read access to this branch on the repository."
    );
  }

  /**
   * @dev Check reader has currently no read access to the branch on the repository.
   * @param _namespace Repository namespace.
   * @param _repository Repository name.
   * @param _branch Repository branch.
   * @param _reader The reader to remove.
   */
  function checkNewBranchReader(
    address _namespace,
    string memory _repository,
    string memory _branch,
    address _reader)
    public
    view
    {
    require(
      branchReader[
        _namespace][
          _repository][
            _branch][
              _reader] == 0,
        "The reader already has read access this branch on the repository."
    );
  }

  /**
   * @dev Makes a repository private.
   * @param _namespace Repository namespace.
   * @param _repository Repository name.
   */
  function setPrivate(
    address _namespace,
    string memory _repository)
    public
    {
    access[
      _namespace][
        _repository] =
      0;
  }

  /**
   * @dev Makes a repository not private.
   * @param _namespace Repository namespace.
   * @param _repository Repository name.
   */
  function setNotPrivate(
    address _namespace,
    string memory _repository)
    public
    {
    access[
      _namespace][
        _repository] =
      1;
  }

  /**
   * @dev Makes a repository public.
   * @param _namespace Repository namespace.
   * @param _repository Repository name.
   */
  function setPublic(
    address _namespace,
    string memory _repository)
    public
    {
    access[
      _namespace][
        _repository] =
      2;
  }

  /**
   * @dev Makes a repository branch private.
   * @param _namespace Repository namespace.
   * @param _repository Repository name.
   * @param _branch Repository branch.
   */
  function setBranchPrivate(
    address _namespace,
    string memory _repository,
    string memory _branch)
    public
    {
    branchAccess[
      _namespace][
        _repository][
          _branch] =
      0;
  }

  /**
   * @dev Makes a repository branch not private.
   * @param _namespace Repository namespace.
   * @param _repository Repository name.
   * @param _branch Repository branch.
   */
  function setNotPrivate(
    address _namespace,
    string memory _repository,
    string memory _branch)
    public
    {
    branchAccess[
      _namespace][
        _repository][
          _branch] =
      1;
  }

  /**
   * @dev Makes a branch repository public.
   * @param _namespace Repository namespace.
   * @param _repository Repository name.
   * @param _branch Repository branch.
   */
  function setBranchPublic(
    address _namespace,
    string memory _repository,
    string memory _branch)
    public
    {
    access[
      _namespace][
        _repository] =
      2;
  }

  /**
   * @dev Checks a repository is not private.
   * @param _namespace Repository namespace.
   * @param _repository Repository name.
   */
  function checkNotPrivate(
    address _namespace,
    string memory _repository)
    public
    view
    {
    require(
      msg.sender == _namespace ||
      access[
        _namespace][
          _repository] > 0,
      "The repository is private."
    );
  }

  /**
   * @dev Checks a repository is public.
   * @param _namespace Repository namespace.
   * @param _repository Repository name.
   */
  function checkPublic(
    address _namespace,
    string memory _repository)
    public
    view
    {
    require(
      msg.sender == _namespace ||
      access[
        _namespace][
          _repository] > 1,
      "The repository is public."
    );
  }

  /**
   * @dev Checks a repository branch is not private.
   * @param _namespace Repository namespace.
   * @param _repository Repository name.
   * @param _branch Repository branch.
   */
  function checkBranchNotPrivate(
    address _namespace,
    string memory _repository,
    string memory _branch)
    public
    view
    {
    require(
      msg.sender == _namespace ||
      branchAccess[
        _namespace][
          _repository][
            _branch] > 0,
      "The repository branch is private."
    );
  }

  /**
   * @dev Checks a repository branch is public.
   * @param _namespace Repository namespace.
   * @param _repository Repository name.
   * @param _branch Repository branch.
   */
  function checkPublic(
    address _namespace,
    string memory _repository,
    string memory _branch)
    public
    view
    {
    require(
      msg.sender == _namespace ||
      branchAccess[
        _namespace][
          _repository][
            _branch] > 1,
      "The repository is public."
    );
  }

  /**
   * @dev Check a repository commit is readable.
   * @param _namespace Repository namespace.
   * @param _repository Repository name.
   * @param _commit Commit to be verified readability.
   */
  function checkReadable(
    address _namespace,
    string memory _repository,
    string memory _commit)
    public
    view
    {
    require(
      msg.sender == _namespace ||
      access[
        _namespace][
          _repository] > 1 ||
      reader[
        _namespace][
          _repository][
            _commit][
              msg.sender] > 0,
      "The repository is not public or readable by the call sender."
    );
  }

  /**
   * @dev Check a repository branch is readable.
   * @param _namespace Repository namespace.
   * @param _repository Repository name.
   * @param _branch Repository branch.
   */
  function checkBranchReadable(
    address _namespace,
    string memory _repository,
    string memory _branch)
    public
    view
    {
    require(
      msg.sender == _namespace ||
      branchAccess[
        _namespace][
          _repository][
            _branch] > 1 ||
      branchReader[
        _namespace][
          _repository][
            _branch][
              msg.sender] > 0,
      "The repository branch is not public or readable by the call sender."
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
    view
    {
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
    view
    {
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
    view
    {
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
    string memory _uri)
    public
    {
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
    string memory _parent)
    public
    {
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
    string memory _branch)
    public
    view
    returns
      (string memory)
    {
    checkBranchReadable(
      _namespace,
      _repository,
      _branch);
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
   * @dev Checks the input 'bytes' variables are the same.
   * @param _a A 'bytes' type variable.
   * @param _b A 'bytes' type variable to compare with the previous one.
   */
  function sameBytes(
    bytes memory _a,
    bytes memory _b )
    internal pure {
    require(
      _a.length ==
      _b.length,
      "Input has different length.");
    require(
      keccak256(
        _a) ==
      keccak256(
        _b),
      "Input is not the same.");
    }

  /**
   * @dev Checks the input string are the same.
   * @param _a A string type variable.
   * @param _b A string type variable to compare with the previous one.
   */
  function sameString(
    string memory _a,
    string memory _b )
    internal pure {
    sameBytes(
      bytes(
        _a),
      bytes(
        _a));
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
    view
    {
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
    sameString(
      _head,
      _parent);
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
    string memory _commit)
    public
    {
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
      isNotForcedUpdate(
        _namespace,
        _repository,
        _branch,
        _commit);
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
   * @dev Publishes a tag.
   * @param _namespace Git repository namespace.
   * @param _repository Repository name.
   * @param _tag Tag to be set.
   * @param _commit Commit the tag must point to.
   */
  function publishTag(
    address _namespace,
    string memory _repository,
    string memory _tag,
    string memory _commit)
    public
    {
    checkOwner(
      _namespace);
    checkLocked(
      _namespace,
      _repository,
      _commit);
    uint256 _tagNo =
      tagNo[
        _namespace][
          _repository][
            _tag];
    tag[
      _namespace][
        _repository][
          _tag][
            _tagNo] =
      _commit;
    tagNo[
      _namespace][
        _repository][
          _tag] =
      _tagNo + 1;
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
    public
    {
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
  returns
    (string memory)
  {
    checkLocked(
      _namespace,
      _repository,
      _commit
    );
    checkReadable(
      _namespace,
      _repository,
      _commit);
    return commit[
             _namespace][
               _repository][
                 _commit];
  }
}
