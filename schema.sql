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

 CREATE TABLE responses(
   id serial PRIMARY KEY,
   question_id int REFERENCES questions(id) NOT NULL,
   contributor_id int REFERENCES contributors(id) NOT NULL,
   response text NOT NULL,
   submitted_on timestamp DEFAULT NOW()
 );
