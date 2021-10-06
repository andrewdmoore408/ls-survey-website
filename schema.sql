CREATE EXTENSION IF NOT EXISTS citext;

CREATE TABLE surveys(
   id serial PRIMARY KEY,
   name text NOT NULL,
   active boolean DEFAULT false
 );                                                        
 CREATE TABLE questions(
  id serial PRIMARY KEY,
  survey_id int REFERENCES surveys(id) NOT NULL,
  question text NOT NULL
);

 CREATE TABLE contributors(
   id serial PRIMARY KEY,
   email_address text UNIQUE NOT NULL
 );

CREATE TABLE choices(
  id serial PRIMARY KEY,
  question_id int REFERENCES questions(id) NOT NULL,
  choice citext NOT NULL, 
  UNIQUE (question_id, choice)
);
 
CREATE TABLE responses(
   id serial PRIMARY KEY,
   choices_id int REFERENCES choices(id) NOT NULL,
   contributor_id int REFERENCES contributors(id) NOT NULL,
   survey_id int REFERENCES surveys(id),
   submitted_on timestamp DEFAULT NOW(),
   UNIQUE (choices_id, contributor_id)
 );
