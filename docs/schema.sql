-- GeoSip initial relational schema proposal.

CREATE TABLE accounts (
  id UUID PRIMARY KEY,
  email TEXT NOT NULL UNIQUE,
  password_hash TEXT NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW()
);

CREATE TABLE moderators (
  id UUID PRIMARY KEY,
  account_id UUID NOT NULL REFERENCES accounts(id),
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW()
);

CREATE TABLE locations (
  id UUID PRIMARY KEY,
  scope TEXT NOT NULL CHECK (scope IN ('world', 'country', 'state', 'city')),
  code TEXT NOT NULL,
  name TEXT NOT NULL,
  parent_id UUID REFERENCES locations(id),
  UNIQUE (scope, code)
);

CREATE TABLE threads (
  id UUID PRIMARY KEY,
  location_id UUID NOT NULL REFERENCES locations(id),
  title TEXT NOT NULL,
  created_by UUID NOT NULL REFERENCES accounts(id),
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW()
);

CREATE TABLE thread_participants (
  thread_id UUID NOT NULL REFERENCES threads(id),
  account_id UUID NOT NULL REFERENCES accounts(id),
  anon_id TEXT NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
  PRIMARY KEY (thread_id, account_id),
  UNIQUE (thread_id, anon_id)
);

CREATE TABLE posts (
  id UUID PRIMARY KEY,
  thread_id UUID NOT NULL REFERENCES threads(id),
  account_id UUID NOT NULL REFERENCES accounts(id),
  anon_id TEXT NOT NULL,
  body TEXT,
  media_url TEXT,
  is_deleted BOOLEAN NOT NULL DEFAULT FALSE,
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
  deleted_at TIMESTAMP WITH TIME ZONE,
  deleted_by UUID REFERENCES moderators(id)
);

CREATE INDEX idx_posts_thread_created ON posts (thread_id, created_at);

CREATE TABLE bans (
  id UUID PRIMARY KEY,
  account_id UUID NOT NULL REFERENCES accounts(id),
  reason TEXT NOT NULL,
  expires_at TIMESTAMP WITH TIME ZONE,
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
  created_by UUID NOT NULL REFERENCES moderators(id)
);

CREATE TABLE moderation_actions (
  id UUID PRIMARY KEY,
  moderator_id UUID NOT NULL REFERENCES moderators(id),
  action_type TEXT NOT NULL,
  target_type TEXT NOT NULL,
  target_id UUID NOT NULL,
  details JSONB,
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW()
);
