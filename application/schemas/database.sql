CREATE TABLE "Role" (
  "roleId" bigint generated always as identity,
  "name" varchar NOT NULL
);

ALTER TABLE "Role" ADD CONSTRAINT "pkRole" PRIMARY KEY ("roleId");
CREATE UNIQUE INDEX "akRoleName" ON "Role" ("name");
CREATE TABLE "Account" (
  "accountId" bigint generated always as identity,
  "login" varchar(64) NOT NULL,
  "password" varchar NOT NULL
);

ALTER TABLE "Account" ADD CONSTRAINT "pkAccount" PRIMARY KEY ("accountId");
CREATE UNIQUE INDEX "akAccountLogin" ON "Account" ("login");

CREATE TABLE "AccountRole" (
  "accountId" bigint NOT NULL,
  "roleId" bigint NOT NULL
);

ALTER TABLE "AccountRole" ADD CONSTRAINT "pkAccountRole" PRIMARY KEY ("accountId", "roleId");
ALTER TABLE "AccountRole" ADD CONSTRAINT "fkAccountRoleAccount" FOREIGN KEY ("accountId") REFERENCES "Account" ("accountId") ON DELETE CASCADE;
ALTER TABLE "AccountRole" ADD CONSTRAINT "fkAccountRoleRole" FOREIGN KEY ("roleId") REFERENCES "Role" ("roleId") ON DELETE CASCADE;
CREATE TABLE "Group" (
  "groupId" bigint generated always as identity,
  "name" varchar NOT NULL,
  "genre" varchar NOT NULL
);

ALTER TABLE "Group" ADD CONSTRAINT "pkGroup" PRIMARY KEY ("groupId");
CREATE UNIQUE INDEX "akGroupName" ON "Group" ("name");
CREATE TABLE "Album" (
  "albumId" bigint generated always as identity,
  "name" varchar NOT NULL,
  "groupId" bigint NOT NULL
);

ALTER TABLE "Album" ADD CONSTRAINT "pkAlbum" PRIMARY KEY ("albumId");
ALTER TABLE "Album" ADD CONSTRAINT "fkAlbumGroup" FOREIGN KEY ("groupId") REFERENCES "Group" ("groupId");
CREATE TABLE "Area" (
  "areaId" bigint generated always as identity,
  "name" varchar NOT NULL,
  "ownerId" bigint NOT NULL
);

ALTER TABLE "Area" ADD CONSTRAINT "pkArea" PRIMARY KEY ("areaId");
CREATE UNIQUE INDEX "akAreaName" ON "Area" ("name");
ALTER TABLE "Area" ADD CONSTRAINT "fkAreaOwner" FOREIGN KEY ("ownerId") REFERENCES "Account" ("accountId");

CREATE TABLE "AreaAccount" (
  "areaId" bigint NOT NULL,
  "accountId" bigint NOT NULL
);

ALTER TABLE "AreaAccount" ADD CONSTRAINT "pkAreaAccount" PRIMARY KEY ("areaId", "accountId");
ALTER TABLE "AreaAccount" ADD CONSTRAINT "fkAreaAccountArea" FOREIGN KEY ("areaId") REFERENCES "Area" ("areaId") ON DELETE CASCADE;
ALTER TABLE "AreaAccount" ADD CONSTRAINT "fkAreaAccountAccount" FOREIGN KEY ("accountId") REFERENCES "Account" ("accountId") ON DELETE CASCADE;
CREATE TABLE "Occupation" (
  "occupationId" bigint generated always as identity,
  "name" varchar NOT NULL
);

ALTER TABLE "Occupation" ADD CONSTRAINT "pkOccupation" PRIMARY KEY ("occupationId");
CREATE UNIQUE INDEX "akOccupationName" ON "Occupation" ("name");
CREATE TABLE "Artist" (
  "artistId" bigint generated always as identity,
  "name" varchar(64) NOT NULL,
  "age" date NOT NULL
);

ALTER TABLE "Artist" ADD CONSTRAINT "pkArtist" PRIMARY KEY ("artistId");

CREATE TABLE "ArtistOccupation" (
  "artistId" bigint NOT NULL,
  "occupationId" bigint NOT NULL
);

ALTER TABLE "ArtistOccupation" ADD CONSTRAINT "pkArtistOccupation" PRIMARY KEY ("artistId", "occupationId");
ALTER TABLE "ArtistOccupation" ADD CONSTRAINT "fkArtistOccupationArtist" FOREIGN KEY ("artistId") REFERENCES "Artist" ("artistId") ON DELETE CASCADE;
ALTER TABLE "ArtistOccupation" ADD CONSTRAINT "fkArtistOccupationOccupation" FOREIGN KEY ("occupationId") REFERENCES "Occupation" ("occupationId") ON DELETE CASCADE;

CREATE TABLE "ArtistGroup" (
  "artistId" bigint NOT NULL,
  "groupId" bigint NOT NULL
);

ALTER TABLE "ArtistGroup" ADD CONSTRAINT "pkArtistGroup" PRIMARY KEY ("artistId", "groupId");
ALTER TABLE "ArtistGroup" ADD CONSTRAINT "fkArtistGroupArtist" FOREIGN KEY ("artistId") REFERENCES "Artist" ("artistId") ON DELETE CASCADE;
ALTER TABLE "ArtistGroup" ADD CONSTRAINT "fkArtistGroupGroup" FOREIGN KEY ("groupId") REFERENCES "Group" ("groupId") ON DELETE CASCADE;
CREATE TABLE "Message" (
  "messageId" bigint generated always as identity,
  "areaId" bigint NOT NULL,
  "fromId" bigint NOT NULL,
  "text" varchar NOT NULL
);

ALTER TABLE "Message" ADD CONSTRAINT "pkMessage" PRIMARY KEY ("messageId");
ALTER TABLE "Message" ADD CONSTRAINT "fkMessageArea" FOREIGN KEY ("areaId") REFERENCES "Area" ("areaId");
ALTER TABLE "Message" ADD CONSTRAINT "fkMessageFrom" FOREIGN KEY ("fromId") REFERENCES "Account" ("accountId");
CREATE TABLE "Session" (
  "sessionId" bigint generated always as identity,
  "accountId" bigint NOT NULL,
  "token" varchar NOT NULL,
  "ip" inet NOT NULL,
  "data" jsonb NOT NULL
);

ALTER TABLE "Session" ADD CONSTRAINT "pkSession" PRIMARY KEY ("sessionId");
ALTER TABLE "Session" ADD CONSTRAINT "fkSessionAccount" FOREIGN KEY ("accountId") REFERENCES "Account" ("accountId");
CREATE UNIQUE INDEX "akSessionToken" ON "Session" ("token");
CREATE TABLE "Song" (
  "songId" bigint generated always as identity,
  "name" varchar NOT NULL
);

ALTER TABLE "Song" ADD CONSTRAINT "pkSong" PRIMARY KEY ("songId");

CREATE TABLE "SongAlbum" (
  "songId" bigint NOT NULL,
  "albumId" bigint NOT NULL
);

ALTER TABLE "SongAlbum" ADD CONSTRAINT "pkSongAlbum" PRIMARY KEY ("songId", "albumId");
ALTER TABLE "SongAlbum" ADD CONSTRAINT "fkSongAlbumSong" FOREIGN KEY ("songId") REFERENCES "Song" ("songId") ON DELETE CASCADE;
ALTER TABLE "SongAlbum" ADD CONSTRAINT "fkSongAlbumAlbum" FOREIGN KEY ("albumId") REFERENCES "Album" ("albumId") ON DELETE CASCADE;