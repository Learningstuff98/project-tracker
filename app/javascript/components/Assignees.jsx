import React, { useState, useEffect } from 'react';
import axios from 'axios';

function Assignees(props) {
  const [assignees, setAssignees] = useState(props.assignees);
  const [isAssigned, setIsAssigned] = useState(false);

  useEffect(() => {
    checkIfUserIsAssigned();
  });

  const checkIfUserIsAssigned = () => {
    for(const assignee of assignees) {
      if(assignee.assignee_id === props.current_user.id) {
        setIsAssigned(true);
        return;
      }
    }
    setIsAssigned(false);
  };

  const assignUser = () => {
    axios.post(`${props.root_url}/issues/${props.issue.id}/assignees`, assigneeValues)
    .then(() => getAssignees())
    .catch((err) => console.log(err.response.data));
  };

  const unassignUser = (assignee) => {
    axios.delete(`${props.root_url}/assignees/${assignee.id}`)
    .then(() => getAssignees())
    .catch((err) => console.log(err.response.data));
  };

  const getAssignees = () => {
    axios.get(`${props.root_url}/issues/${props.issue.id}/assignees`)
    .then((res) => setAssignees(res.data))
    .catch((err) => console.log(err.response.data));
  };

  const assigneeValues = {
    assignee_username: props.current_user.username,
    assignee_id: props.current_user.id,
    issue_id: props.issue.id
  }

  const renderAssignees = <div>
    {assignees.map((assignee) => {
      return <h5 className="green" key={assignee.id}>
        {assignee.assignee_username}
      </h5>
    })}
  </div>

  const getAssignee = () => {
    for(const assignee of assignees) {
      if(assignee.assignee_id === props.current_user.id) {
        return assignee;
      }
    }
  };

  const assignButton = <h5 className="green cursor assign-button" onClick={() => assignUser()}>
    Assign yourself to this issue
  </h5>

  const unassignButton = () => {
    return <h5 className="green cursor unassign-button" onClick={() => unassignUser(getAssignee())}>
      Unassign yourself from this issue
    </h5>
  };

  const handleAssignButtons = () => {
    if(isAssigned) {
      return unassignButton();
    }
    return assignButton;
  };

  return <div>
    <div className="spacing-below">{handleAssignButtons()}</div>
    <h5 className="green spacing-below">People working on this issue</h5>
    {renderAssignees}
  </div>
}

export default Assignees;
