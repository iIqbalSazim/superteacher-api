# Superteacher-api

## Table of Contents

- [What is the project about](#what-is-the-project-about)
- [Why are we doing this project](#why-are-we-doing-this-project)
- [Entity-Relationship Diagram (ERD)](#entity-relationship-diagram-erd)
- [Architecture](#architecture)
- [Feature List](#feature-list)
- [Trello Board](#trello-board)
- [Local Development Setup](#local-development-setup)
- [Acknowledgments](#acknowledgments)

## What is the project about

Superteacher is a dedicated application designed for freelance teachers. It empowers teachers to create and oversee multiple classrooms, enabling effective student management.

## Why are we doing this project

The Superteacher project is undertaken as the final project of the Sazim Learner's Program. It serves as a culmination of the trainee's acquired skills and knowledge throughout the program, demonstrating their proficiency in **backend development using Ruby on Rails**. This project provides an opportunity for the trainee to apply their learning to a real-world application, showcasing their ability to build a robust and functional system tailored to the needs of freelance teachers.

## Entity Relationship Diagram (ERD)

- [Superteacher ERD](https://lucid.app/lucidchart/13c8691d-a04b-42e7-a9e4-72c30b9ad039/edit?viewport_loc=-669%2C-77%2C3125%2C1782%2C0_0&invitationId=inv_572d619b-68c5-4634-8740-dc931e27b6c9)

## Architecture

The backend of the Superteacher application is built using Ruby on Rails and it integrates with a [React frontend](https://github.com/iIqbalSazim/superteacher-client).
<br/>
It follows a RESTful architecture with a Model-View-Controller (MVC) pattern.

## Feature List

- **User Types:** Superteacher supports two types of users: **Students** and **Teachers**.

- **Login/Registration:**

  - Two types of registration processes are available for Students and Teachers, with tailored forms for each.
  - For Teachers, a unique code is required for registration, and the system limits the number of wrong attempts for the unique code to prevent misuse.

- **Teacher Functionalities:**

  - Creation and management of multiple classrooms, each with a title, subject, class time, and days.
  - Addition and removal of students from classes, with automated email notifications sent to added students.
  - Global chat thread within each class, allowing all participants to communicate realtime.
  - Upload of attachments such as assignments and learning resources, with automated email notifications sent to enrolled students.
  - Scheduling of exam dates and assignment deadlines.
  - Integration of Google Meet class links within classrooms.
  - Viewing of assignments submitted by students.
  - Automatic detection of late submissions.

- **Student Functionalities:**
  - Viewing of enrolled classes.
  - Participation in global chat threads within classes.
  - Access to and download of resource materials uploaded by teachers.
  - Viewing of assignment and exam schedules.
  - Joining Google Meet classes directly from the platform.
  - Submission of assignments.

## Trello Board

- [Superteacher [Final Project]](https://trello.com/invite/b/9Cy2KHbi/ATTIaac921f8a66bcba3842355892570a412620CD66F/superteacher-final-project)

## Local Development Setup

### Prerequisites

- Ruby v3.2.2 and Ruby on Rails installed on your machine
- PostgreSQL installed on your machine

### Step-by-step instructions

1. Clone the repository: `git clone <repository-url>`
2. Navigate to the api directory: `cd superteacher-api`
3. Install dependencies: `bundle install`
4. Set up PostgreSQL:
   - Create a new database. Grant all privileges on the database to the user.
5. Configure rails database:
   - Open config/database.yml file.
   - Update the database field under **development** section with your desired database name (e.g., superteacher_api_development).
   - Uncomment and update the username and password fields if necessary.
6. Set up the database: `rails db:create && rails db:migrate`
7. Run the development server: `rails server`

## Acknowledgments

- This project was developed as part of the Learner's Program Final Project January-February 2024.
- Special thanks to the instructors and mentors for their guidance and support throughout the program.
