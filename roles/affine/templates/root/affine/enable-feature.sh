#!/usr/bin/env bash
set -euo pipefail

POSTGRES_CONTAINER="affine_postgres"
REDIS_CONTAINER="affine_redis"
AFFINE_CONTAINER="affine_server"
DB_USER="{{ affine_db_user }}"
DB_NAME="{{ affine_db_name }}"

echo "==> 正しいスキーマでフィーチャーフラグを適用中..."
docker exec -i "${POSTGRES_CONTAINER}" psql -U "${DB_USER}" -d "${DB_NAME}" << 'EOSQL'
-- ユーザー側に early_access を付与
INSERT INTO user_features (user_id, name, type, reason, activated, created_at)
SELECT id, 'early_access', 0, 'selfhost enable', true, NOW() FROM users
ON CONFLICT (user_id, name) DO UPDATE SET activated = true;

-- Workspace側に early_access を付与
INSERT INTO workspace_features (workspace_id, name, type, reason, activated, created_at, configs)
SELECT id, 'early_access', 0, 'selfhost enable', true, NOW(), '{}'::jsonb FROM workspaces
ON CONFLICT (workspace_id, name) DO UPDATE SET activated = true;

-- Workspace側に publish_to_web を付与
INSERT INTO workspace_features (workspace_id, name, type, reason, activated, created_at, configs)
SELECT id, 'publish_to_web', 0, 'selfhost enable', true, NOW(), '{}'::jsonb FROM workspaces
ON CONFLICT (workspace_id, name) DO UPDATE SET activated = true;

\echo '=== Currently Workspace Config ==='
SELECT id, workspace_id, name, type, activated, configs FROM workspace_features;

\echo '=== Currently user_features Config ==='
SELECT id, user_id, name, type, activated FROM user_features;
EOSQL

docker exec -i "${REDIS_CONTAINER}" redis-cli FLUSHALL

docker restart "${AFFINE_CONTAINER}"
