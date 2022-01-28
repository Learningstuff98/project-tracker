import React, { useState } from "react";
import axios from 'axios';

function StageForm(props) {
  const [input, setInput] = useState('');

  const submitStage = (formData) => {
    axios.post(`${props.root_url}projects/${props.project.id}/stages`, formData)
    .catch((err) => console.log(err.response.data));
  };
  
  const handleSubmit = (e) => {
    e.preventDefault();
    if(input.length > 0) {
      submitStage({ name: input });
      setInput('');
    } else {
      alert("Stage name can't be blank");
    }
  };
  
  const inputButton = () => {
    return <input
      type="submit"
      value="Submit"
      className="btn btn-primary"
    />
  };
  
  const inputElement = () => {
    return <input
      type="text"
      placeholder="stage name"
      id="input-element"
      size="30"
      value={input}
      onChange={e => setInput(e.target.value)}
    />
  };
  
  return <form className="spacing-below" onSubmit={handleSubmit}>
    <div className="spacing-below">{inputElement()}</div>
    {inputButton()}
  </form>
}

export default StageForm;
