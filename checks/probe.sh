#!/bin/sh
# /api/users runs a GraphQL query against MongoDB and returns the visible users.
curl -fsS --max-time 15 -H 'Content-Type: application/json' -d '{"query":"{ users { username } }"}' http://web:5003/api/users | grep -q '"users"'
