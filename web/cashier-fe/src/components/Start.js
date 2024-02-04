import { Link } from "react-router-dom";

function reset() {
  fetch('/purchase/clear', { method: 'DELETE' })
    .catch(error => console.error("Error resetting table" + error));
}

function StartPage() {
  return (
    <div class="center">
      <h1>Welcome</h1>
      <Link to='/purchase'>
        <button onClick={reset()}>
          Start
        </button>
      </Link>
    </div>

  );
}

export default StartPage;
