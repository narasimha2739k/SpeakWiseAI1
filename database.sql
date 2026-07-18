-- Supabase SQL Schema setup for SpeakWise AI

-- 1. Create Users Table
create table if not exists users (
  _id uuid primary key default gen_random_uuid(),
  email text unique not null,
  "passwordHash" text not null,
  name text not null,
  bio text default '',
  occupation text default '',
  experience text default '',
  skills text[] default '{}',
  "socialLinks" jsonb default '{"website": "", "linkedin": "", "twitter": "", "github": ""}',
  "profilePic" text default '',
  "coverImage" text default '',
  "createdAt" timestamp with time zone default now(),
  "updatedAt" timestamp with time zone default now()
);

-- 2. Create Sessions Table
create table if not exists sessions (
  _id uuid primary key default gen_random_uuid(),
  "userId" uuid references users(_id) on delete cascade,
  "sessionName" text not null,
  "topicName" text not null,
  "sessionType" text not null,
  date text not null,
  time text not null,
  duration integer not null,
  "audienceAgeGroup" text not null,
  "isBeginner" boolean default false,
  "isIntermediate" boolean default false,
  "isAdvanced" boolean default false,
  "attendeesCount" integer default 0,
  description text not null,
  "learningObjectives" text not null,
  "keyConcepts" text not null,
  "topicsToCover" text not null,
  "expectedOutcome" text not null,
  "teachingStyle" text not null,
  "difficultyLevel" text not null,
  "additionalNotes" text default '',
  "aiPlan" jsonb,
  "createdAt" timestamp with time zone default now(),
  "updatedAt" timestamp with time zone default now()
);

-- 3. Create Upcoming Sessions Table
create table if not exists upcoming_sessions (
  _id uuid primary key default gen_random_uuid(),
  "userId" uuid references users(_id) on delete cascade,
  title text not null,
  topic text default '',
  date text not null,
  time text not null,
  duration integer not null,
  description text default '',
  "alertReminder" boolean default false,
  "notifiedOneDay" boolean default false,
  "notifiedOneHour" boolean default false,
  "notifiedTenMinutes" boolean default false
);

-- 4. Create Practice Evaluations Table
create table if not exists practice_evaluations (
  _id uuid primary key default gen_random_uuid(),
  "userId" uuid references users(_id) on delete cascade,
  "sessionId" text default '',
  "sessionTitle" text not null,
  transcript text not null,
  "durationSeconds" integer not null,
  "overallScore" integer not null,
  "confidenceScore" integer not null,
  "communicationScore" integer not null,
  "engagementScore" integer not null,
  "speechQuality" jsonb,
  "presentationAnalysis" jsonb,
  feedback jsonb,
  "evaluatedAt" timestamp with time zone default now()
);

-- 5. Create Notifications Table
create table if not exists notifications (
  _id uuid primary key default gen_random_uuid(),
  "userId" uuid references users(_id) on delete cascade,
  title text not null,
  message text not null,
  type text not null,
  read boolean default false,
  "createdAt" timestamp with time zone default now()
);

-- 6. Insert Pre-seeded Demo User (Password is 'password123')
insert into users (email, "passwordHash", name, bio, occupation, experience, skills, "socialLinks", "profilePic", "coverImage")
values (
  'demo@speakwise.ai',
  '$2b$10$bIhjgV6d8w8nJ9PeHqXHdOPll8tvFOghjElntCqLMeT5838aEueXS',
  'Elena Rostova',
  'Professional keynote speaker and corporate coach passionate about storytelling and dynamic presentation design.',
  'Lead Communication Consultant',
  '8+ Years',
  array['Storytelling', 'Vocal Variety', 'Interactive Q&A', 'Slide Design', 'Anxiety Management'],
  '{"website": "https://speakwise.ai", "linkedin": "https://linkedin.com/in/demo", "twitter": "https://twitter.com/demo", "github": "https://github.com/demo"}',
  '',
  ''
) on conflict (email) do nothing;
