const express = require("express");
const app = express();
const cors = require("cors");
const cookieParser = require("cookie-parser");
const session = require("express-session");
const jwt = require("jsonwebtoken");
const dotenv = require("dotenv").config();
const user = require("./Source/login");
const knex = require("./Source/db");
const profile = require("./Source/profile");
const multer = require("multer");
const path = require("path");
const { resolveAny } = require("dns/promises");

app.use(express.static("./public"));
app.use(express.urlencoded({ extended: true }));
app.use(express.json());

app.use(
  cors({
    origin: ["http://localhost:3000"],
    methods: ["GET", "POST"],
    credentials: true,
  })
);
app.use(cookieParser());

app.use(
  session({
    key: "userId",
    secret: process.env.Session_secret,
    resave: false,
    saveUninitialized: false,
    cookie: {
      expires: 60 * 60 * 24 * 30,
    },
  })
);

/***********************************************/
//login//

app.post("/userReg", (req, res) => {
  user.userRegister(req, res);
});

app.post("/userLogin", (req, res) => {
  user
    .loginVerify(req)
    .then((result) => {
      res.json(result);
    })
    .catch((err) => console.log(err));
});

app.get("/userVerification", (req, res) => {
  console.log(req.session);
  if (req.session.user) {
    console.log(req.session.user);
    res.send({ loggedIn: true, user: req.session.user });
  } else {
    res.send({ loggedIn: false });
  }
});

app.get("/logout", (req, res) => {
  res.clearCookie("userId");
  if (req.session.user) {
    req.session.destroy();
  }
  console.log("You have been logged out!");
  res.send("You have been logged out!");
});

/*****************************************/
//     Get Profile       //
//Use of Multer
const storage = multer.diskStorage({
  destination: (req, file, callback) => {
    callback(null, "./public/images/");
  },
  filename: (req, file, callback) => {
    callback(null, Date.now() + path.extname(file.originalname));
  },
});

const upload = multer({
  storage: storage,
});

app.post("/getProfile", (req, res) => {
  profile.getProfile(req).then((result) => {
    res.send(result);
    console.log(result);
  });
});
app.post("/removePhoto", (req, res) => {
  profile.removePhoto(req);
});

app.post("/upload", upload.single("file"), (req, res) => {
  let imgsrc = "http://localhost:3002/images/" + req.file.filename;
  knex("user")
    .where({ id: req.body.id })
    .update({
      contact: req.body.contact,
      name: req.body.name,
      photo: imgsrc,
    })
    .then((result) => {
      console.log("profile image uploaded");
      res.send("updated");
    });
});

app.post("/updateProfile", (req, res) => {
  knex("user")
    .where({ id: req.body.id })
    .update({
      contact: req.body.contact,
      name: req.body.name,
    })
    .then((result) => {
      console.log("Profile updated");
      res.send("updated");
    });
});

/*********************************** */
//upload assignments

const storage3 = multer.diskStorage({
  destination: (req, file, callback) => {
    callback(null, "./public/assignments/");
  },
  filename: (req, file, callback) => {
    callback(null, Date.now() + path.extname(file.originalname));
  },
});

const upload3 = multer({
  storage: storage3,
});
app.post("/uploadAssignment", upload3.single("file"), (req, res) => {
  let fileSrc = "http://localhost:3002/assignments/" + req.file.filename;
  knex("assignment")
    .insert({
      courseId: req.body.courseId,
      file: fileSrc,
      fileName: req.body.fileName,
      title: req.body.title,
      topic: req.body.topic,
      deadline: req.body.deadline,
    })
    .then((result) => {
      //console.log(result)
      console.log("file uploaded");
      res.send("done");
    });
});

app.post("/getAssignments", (req, res) => {
  knex("assignment")
    .select()
    .where({ courseId: req.body.id })
    .then((result) => res.send(result));
});
app.post("/getAttemptedAssignments", (req, res) => {
  const query = `select asg.assignmentId, asg.courseId, asg.file, asg.fileName, title, topic, deadline from assignment as asg,assignment_submission as ass where asg.assignmentId=ass.assignmentId and asg.courseId=${req.body.id} and studentId=${req.body.studentId}`;
  knex.raw(query).then((result) => {
    res.send(result);
  });
});
app.post("/getUnAttemptedAssignments", (req, res) => {
  const query = `select * from assignment where assignmentId not in (select assignmentId from assignment_submission where studentId=${req.body.studentId}) and courseId=${req.body.id}`;
  knex.raw(query).then((result) => {
    res.send(result);
  });
});

/*************************************/
// upload Submission assignments
const storage4 = multer.diskStorage({
  destination: (req, file, callback) => {
    callback(null, "./public/StudentAssignmentSubmission/");
  },
  filename: (req, file, callback) => {
    callback(null, Date.now() + path.extname(file.originalname));
  },
});

const upload4 = multer({
  storage: storage4,
});
app.post("/uploadMyAssignment", upload4.single("file"), (req, res) => {
  console.log(req.file);
  let fileSrc =
    "http://localhost:3002/StudentAssignmentSubmission/" + req.file.filename;
  knex("assignment_submission")
    .insert({
      courseId: req.body.courseId,
      studentId: req.body.studentId,
      assignmentId: req.body.assignmentId,
      file: fileSrc,
      fileName: req.body.fileName,
      roll: req.body.roll,
      comment: req.body.comment,
      late: req.body.late,
    })
    .then((result) => {
      //console.log(result)
      console.log("file uploaded");
      res.send("hi");
    });
});

app.post("/deleteMyAssignment", (req, res) => {
  knex("assignment_submission")
    .where({ assignmentId: req.body.assignmentId })
    .del()
    .then((result) => {
      //console.log(result)
      console.log("succesffuly deleted");
      res.send("deleted..");
    });
});

app.post("/getMyAssignments", (req, res) => {
  knex("assignment_submission")
    .where({
      assignmentId: req.body.assignmentId,
      studentId: req.body.studentId,
    })
    .select("file", "fileName", "comment", "roll", "late")
    .then((result) => {
      //console.log(result)
      res.send(result);
    });
});

app.post("/viewStudentAssignmentSubmission", (req, res) => {
  const query = `select file,fileName,comment,roll,late,name,photo,assignment_submissionId from assignment_submission as ass, user where ass.studentId=user.id and user.role='Student' and ass.assignmentId=${req.body.assignmentId}`;
  knex
    .raw(query)
    .then((result) => {
      res.send(result);
    })
    .then((err) => {
      console.log(err);
    });
});

/********************************** */
// Add new course

app.post("/publishCourse", (req, res) => {
  knex("courses")
    .insert({
      courseName: req.body.courseName,
      credits: req.body.credit,
      bio: req.body.desc,
      teacherId: req.body.id,
      prerequisite: req.body.prereq,
    })
    .then((result) => {
      //console.log(result)
      console.log("Inserted");
      res.send(result);
    })
    .catch((err) => {
      console.log(err);
    });
});

app.get("/getCourseList", (req, res) => {
  knex("courses")
    .join("user", "teacherId", "=", "id")
    .select(
      "courseId",
      "courseName",
      "credits",
      "bio",
      "prerequisite",
      "name",
      "photo"
    )
    .then((result) => {
      //console.log(result)
      res.send(result);
    });
});

app.post("/enrollMe", (req, res) => {
  knex("studies")
    .insert({
      studentId: req.body.studentId,
      courseId: req.body.courseId,
    })
    .then((result) => {
      res.send("You are Successfully enrolled");
    });
});

app.post("/getMyCourses", (req, res) => {
  knex("courses")
    .join("studies", "courses.courseId", "=", "studies.courseId")
    .where({ studentId: req.body.id })
    .join("user", "teacherId", "=", "id")
    .select(
      "courses.courseId",
      "courseName",
      "credits",
      "bio",
      "prerequisite",
      "name",
      "photo"
    )
    .then((result) => {
      //console.log(result)
      res.send(result);
    });
});

app.post("/getTeacherCourse", (req, res) => {
  knex("courses")
    .select("courseId", "courseName", "credits", "bio", "prerequisite")
    .where({ teacherId: req.body.id })
    .then((result) => {
      //console.log(result)
      res.send(result);
    });
});

/***************************************************/
//Announcement
app.post("/createAnnouncement", (req, res) => {
  knex("announce")
    .insert({
      courseId: req.body.id,
      announcement: req.body.announcement,
    })
    .then((result) => {
      //console.log(result)
      res.send(result);
    });
});

app.post("/getAnnouncement", (req, res) => {
  // console.log(req.body.id);
  knex("announce")
    .select()
    .where({ courseId: req.body.id })
    .then((result) => {
      //console.log(result)
      res.send(result);
    });
});

/*******************************************/
//Doubt
app.post("/askDoubt", (req, res) => {
  knex("doubt")
    .insert(req.body)
    .then((result) => {
      //console.log(result)
    });
});

app.get("/getDoubtList", (req, res) => {
  knex("doubt")
    .join("user", "doubt.askerId", "=", "user.id")
    .select(
      "name",
      "photo",
      "doubtId",
      "question",
      "title",
      "topic",
      "status",
      "askerId"
    )
    .then((result) => {
      //console.log(result)
      res.send(result);
    });
});

app.post("/addDoubtAnswer", (req, res) => {
  knex("doubt_ans")
    .insert(req.body)
    .then((result) => {
      //console.log(result)
      res.send("done");
    });
});
app.post("/getDoubtAnswers", (req, res) => {
  const query = `select name,photo,doubt_ans,doubt_ansId from doubt_ans as ds, user where ds.replierId=user.id and doubtId=${req.body.doubtId}`;
  knex
    .raw(query)
    .then((result) => {
      res.send(result);
    })
    .catch((err) => {
      console.log(err);
    });
});

/*******************************************/
app.listen(3002, () => {
  console.log("listing on port 3002");
});
