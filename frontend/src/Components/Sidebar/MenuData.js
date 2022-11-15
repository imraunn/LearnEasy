import Courses from "../Courses/Courses";
import Profile from "../Common/Profile";
import Doubts from "../Doubts/Doubts";
import Dashboard from "../Dashboard/Dashboard";
export const MenuData = [
  {
    name: "Dashboard",
    to: "/",
    iconClassName: "bi bi-speedometer2",
    exact: true,
    link: <Dashboard />,
  },
  {
    name: "Profile",
    to: "/profile",
    iconClassName: "bi bi-person-circle",
    exact: true,
    link: <Profile />,
  },
  {
    name: "Courses",
    to: "/courses",
    iconClassName: "bi bi-book",
    exact: true,
    link: <Courses />,
  },
  {
    name: "Doubts",
    to: `/doubts`,
    iconClassName: "bi bi-question-circle-fill",
    exact: true,
    link: <Doubts />,
  },
];
