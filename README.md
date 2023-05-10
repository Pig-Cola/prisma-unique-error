# Issue
The issue has been posted [here](https://github.com/prisma/prisma/issues/13935).

## 한국어 요약
1:1 관계에서 1:N 관계로 변경할 때,
Unique를 해제 하였지만 여전히 index가 남아있습니다.

이 작업만 단일로 수행하면 migration파일 (sql)이 비어있습니다.

### Bug description

I found a bug while using prisma.

When it changes from 1:1 relationship to 1:N relationship,
Unique index still exists even though unique was removed from the field.
(migration.sql is empty)

Unique addition and deletion of fields without changing relationships works normally.

A reproduction of this problem is [here.](https://github.com/Pig-Cola/prisma-unique-error)
More specifically, it appears in that commit. https://github.com/Pig-Cola/prisma-unique-error/commit/8d084dfce2d4467a2468b96f13aaf260b7c32c9f

One commit was generated each time the migration was performed. Please check the commit together.

### How to reproduce

The process of reproducing in a new project rather than in the repository provided.

1. Create a new project folder and make the default settings. (install for prisma, npx prisma init, set .env,  etc...)
2. Create and migrate two table models for a simple 1:1 relationship.
3. Remove the unique tag of the field required for relationship formation while changing to a 1:N relationship.
4. This migration creates an empty sql.

[Check commit history](https://github.com/Pig-Cola/prisma-unique-error/commits/main) to see detailed order

### Expected behavior

If it worked normally, the index should have been dropped.

### Prisma information

<!-- Do not include your database credentials when sharing your Prisma schema! -->
1. 1:1 relationship

``` prisma
generator client {
  provider = "prisma-client-js"
}

datasource test {
  provider = "mysql"
  url      = env("DATABASE_URL")
}

model Foo {
  id String @id @default(cuid())

  description String
  value       Int
  updateAt    DateTime @updatedAt
  Bar         Bar?
}

model Bar {
  id    String @id @default(cuid())
  fooId String @unique

  stage    Int
  createAt DateTime @default(now())

  foo Foo @relation(fields: [fooId], references: [id])
}
```

2.  Change to 1:N relationship
``` prisma
generator client {
  provider = "prisma-client-js"
}

datasource test {
  provider = "mysql"
  url      = env("DATABASE_URL")
}

model Foo {
  id String @id @default(cuid())

  description String
  value       Int
  updateAt    DateTime @updatedAt
  Bar         Bar[]
}

model Bar {
  id    String @id @default(cuid())
  fooId String

  stage    Int
  createAt DateTime @default(now())

  foo Foo @relation(fields: [fooId], references: [id])
}

```

### Environment & setup

- OS: <!--[e.g. Mac OS, Windows, Debian, CentOS, ...]--> Windows 11
- Database: <!--[PostgreSQL, MySQL, MariaDB or SQLite]--> MySQL
- Node.js version: <!--[Run `node -v` to see your Node.js version]--> 14.17.0


### Prisma Version

```
prisma                  : 3.15.2
@prisma/client          : 3.15.2
```


![image](https://raw.githubusercontent.com/Pig-Cola/prisma-unique-error/main/result.png)
