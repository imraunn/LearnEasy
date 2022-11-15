import React, { useState } from "react";
import { Link, useParams, useLocation } from "react-router-dom";
import Announcement from "./Announcement/Announcement";
import Assignment from "./Assignment/Assignment";

function SingleCourse() {
  const { id } = useParams();
  const choice = [<Announcement id={id} />, <Assignment id={id} />];
  const [opt, setOpt] = useState(0);
  return (
    <main>
      <header className="nav-selection">
        <button
          className={`role-btn ${opt === 0 && "active-btn"}`}
          onClick={() => setOpt(0)}
        >
          Announcement
        </button>
        <button
          className={`role-btn ${opt === 1 && "active-btn"}`}
          onClick={() => setOpt(1)}
        >
          Assignment
        </button>
        <hr />
      </header>
      <div className="choice">{choice[opt]}</div>
    </main>
  );
}

export default SingleCourse;
