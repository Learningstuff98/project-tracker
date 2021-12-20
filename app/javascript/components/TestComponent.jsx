import React from 'react';

function TestComponent() {

  const helloWorld = () => {
    console.log('HELLO WORLD');
  };

  return <h1 onClick={() => helloWorld()}>
    REACT SAYS HELLO WORLD
  </h1>
}

export default TestComponent;
