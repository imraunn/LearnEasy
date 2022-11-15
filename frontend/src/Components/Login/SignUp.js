import React, { useState } from "react";
import Axios from "axios";

const SignUp = () => {
  const [name, setName] = useState("");
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [roleStudent, setRoleStudent] = useState(true);

  Axios.defaults.withCredentials = true;

  const handleReg = (e) => {
    e.preventDefault();
    if (email && password && name) {
      let obj = { name: name, email: email, password: password };
      if (roleStudent) {
        obj = { ...obj, role: "Student" };
      } else {
        obj = { ...obj, role: "Teacher" };
      }
      Axios.post("http://localhost:3002/userReg", obj)
        .then((res) => {
          alert("Successfully registered");
          console.log(res);
        })
        .catch((err) => {
          alert("email is already registered");
          console.log(err);
        });
    } else {
      alert("All feilds are mandatory!!");
    }
  };

  return (
    <main className="form-box">
      <h2>Join Now !</h2>
      <p>Create a new account</p>
      <div className="role">
        <div>I'm</div>
        <button
          className={`role-btn ${roleStudent && "active-btn"}`}
          onClick={() => setRoleStudent(!roleStudent)}
        >
          Student
        </button>
        <button
          className={`role-btn ${!roleStudent && "active-btn"}`}
          onClick={() => setRoleStudent(!roleStudent)}
        >
          Teacher
        </button>
      </div>
      <form className="form" onSubmit={handleReg}>
        <label htmlFor="name">Name</label>
        <input
          type="text"
          id="name"
          name="name"
          placeholder="Your name"
          value={name}
          onChange={(e) => setName(e.target.value)}
        />
        <label htmlFor="email">Email</label>
        <input
          type="email"
          id="email"
          name="email"
          placeholder="Your email"
          value={email}
          onChange={(e) => setEmail(e.target.value)}
        />
        <label htmlFor="password">Password</label>
        <input
          type="password"
          id="password"
          name="password"
          autoComplete="off"
          placeholder="Your password"
          value={password}
          onChange={(e) => setPassword(e.target.value)}
        />

        <br></br>
        <button className="opt-val-btn" type="submit">
          Sign Up
        </button>

        <hr />
      </form>
    </main>
  );
};
export default SignUp;
