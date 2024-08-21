import { useEffect, useState } from 'react';
import { demo_hacker_house_backend } from 'declarations/demo-hacker-house-backend';

function App() {
  const [appIdeas, setAppIdeas] = useState([]);

  function addIdeas(event) {
    event.preventDefault();
    const title = event.target.elements.title.value;
    const description = event.target.elements.description.value;
    demo_hacker_house_backend.addAppIdea(title, description).then((appIdeas) => {
      
    });
    // return false;
  }

  function upvoteUse(id) {
    demo_hacker_house_backend.upvoteUseThis(id).then((appIdeas) => {
      fetchIdeas()
    });
    // return false;
  }
  function upvotePay(id) {
    demo_hacker_house_backend.upvotePayThis(id).then((appIdeas) => {
      fetchIdeas()
    });
    // return false;
  }

  const fetchIdeas = async () => {
  try {
    let ideas = await demo_hacker_house_backend.getIdeas();
    console.log(ideas);
    setAppIdeas(ideas)
  } catch (error) {
    console.error('Error fetching ideas:', error);
  }
};
  useEffect(() => {
  
    fetchIdeas();
  }, []);

  return (
    <main>
      <h1>Ideas Hub</h1>

      <form></form>
      {/* <img src="/logo2.svg" alt="DFINITY logo" /> */}
      {/* <br /> */}
      {/* <br /> */}
      <form action="#" onSubmit={addIdeas}>
        <label htmlFor="name">Build This: &nbsp;</label>
        <p>Discover and share your ideas On-Chain</p>
        <label htmlFor="name">Title: &nbsp;</label>
        <input id="title" alt="title" type="text" />
        <label htmlFor="name">Description: &nbsp;</label>
        <input id="description" alt="Description" type="text" />
        <button type="submit">Add New Ideas</button>
      </form>
      <section id="greeting">{addIdeas}</section>
      <div>{appIdeas.map((idea, i) => (
        <div>
          {/* {i} */}
          <h5>
          {idea.title} = {idea.description}
          </h5>
          <div>
            <button onClick={()=>upvoteUse(idea.id)}>i would use this👌: {parseInt(idea.useThis)}</button>
            <button onClick={() => upvotePay(idea.id)}>i would pay this💵: {parseInt(idea.payThis)}</button>
          </div>
          </div>
      ))}</div>
    </main>
  );
}

export default App;
