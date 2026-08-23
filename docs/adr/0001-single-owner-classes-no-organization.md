# Single-owner Classes, no organization model

Status: accepted

A Class belongs to exactly one User (`created_by`), with no organization, school, or multi-teacher sharing layer above it. The core problem this project showcases is AI-based answer evaluation, not multi-tenant classroom administration — adding org/role/sharing management now would be building a different product. Revisit if co-teaching or shared class management becomes an actual requirement; the migration path is additive (a `class_members` join table) rather than a rework of the existing shape.
