# GeoSip Requirements

## Goals

- Provide an imageboard-style community organized by geographic scope.
- Preserve front-end anonymity while ensuring backend accountability.
- Enable moderators to manage content and ban abusive users.
- Support future expansion to finer geographic granularity.

## Functional Requirements

### Boards & Locations

- Support board scopes: `world`, `country`, `state`, `city`.
- Each thread belongs to exactly one board scope and a specific location identifier (e.g., country code, state code, city id).
- Location metadata should be normalized (separate `locations` table) for consistent lookups.

### Threads & Posts

- Users can create threads and reply with posts containing text and optional media.
- Each thread has a per-thread anonymous ID for each participant (e.g., `anon_id`), consistent within the thread.
- Posts are displayed without revealing account identity.
- Images are stored in object storage with references stored in the database.

### Accounts

- Accounts are identified by email and a unique account id.
- Accounts can post across any location board.

### Moderation

- Moderators can remove (soft-delete) posts.
- Moderators can ban accounts by email or account id, with reason and duration.
- Moderation actions are auditable.

## Non-Functional Requirements

- **Privacy**: no email exposure in public views.
- **Abuse Prevention**: rate limiting per account and per IP.
- **Scalability**: efficient indexing for location + thread + post queries.
- **Observability**: logging of moderation actions and bans.

## Future Considerations

- More granular geographies (neighborhoods, postal codes).
- Anonymous “tripcode”-style opt-in identities.
- Read-only snapshots for archived threads.
