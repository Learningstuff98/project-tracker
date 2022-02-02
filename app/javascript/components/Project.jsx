import React, { useState, useEffect } from 'react';
import consumer from "channels/consumer";
import Stages from './Stages';

function Project(props) {
  const [stages, setStages] = useState(props.stages);

  useEffect(() => {
    handleWebsocketUpdates();
  });

  const handleWebsocketUpdates = () => {
    consumer.subscriptions.create({channel: "ProjectChannel"}, {
      received(data) {
        if(data.project.id === props.project.id) {
          setStages(data.stages);
        }
      }
    });
  };

  const stagesComponent = <Stages
    stages={stages}
    root_url={props.root_url}
    project={props.project}
  />

  return <div>
    {stagesComponent}
  </div>
}

export default Project;
