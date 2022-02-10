import React, { useState, useEffect } from 'react';
import consumer from "channels/consumer";
import Stages from './Stages';

function Project(props) {
  const [stages, setStages] = useState(props.stages);
  const [issues, setIssues] = useState(props.issues);
  const [selectedIssue, setSelectedIssue] = useState(null);

  useEffect(() => {
    handleWebsocketUpdates();
  });

  const handleWebsocketUpdates = () => {
    consumer.subscriptions.create({channel: "ProjectChannel"}, {
      received(data) {
        if(data.project.id === props.project.id) {
          if(data.stages) {
            setStages(data.stages);
          }
          if(data.issues) {
            setIssues(data.issues);
          }
        }
      }
    });
  };

  const isProjectOwner = () => {
    return props.current_user.id === props.project.user_id;
  };

  const stagesComponent = <Stages
    stages={stages}
    root_url={props.root_url}
    project={props.project}
    issues={issues}
    isProjectOwner={isProjectOwner()}
    setSelectedIssue={setSelectedIssue}
    selectedIssue={selectedIssue}
  />

  return <div>
    {stagesComponent}
  </div>
}

export default Project;
