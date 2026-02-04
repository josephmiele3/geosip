# GeoSip

GeoSip is a location-based imageboard inspired by communities like 4chan/2channel. Instead of topic boards, content is organized by geographic scope (world, country, state, city) with room for finer granularity in the future.

## Core Concepts

- **Location Boards**: Every thread lives in a geographic scope (world, country, state, city) with a specific location target.
- **Anonymous Posting**: Front-end posts are anonymous, but each post is associated with a backend account identified by email.
- **Thread IDs**: Each thread has a per-thread identifier to distinguish participants without exposing account identity.
- **Moderation**: Moderators can delete posts and ban users/accounts.

## Repository Structure

- `docs/requirements.md`: Product and system requirements.
- `docs/schema.sql`: Initial relational schema proposal.

## Next Steps

- Pick a backend framework (e.g., Rails, Django, FastAPI, or Express).
- Implement authentication and anonymous thread identity generation.
- Build moderation tooling and admin interfaces.
