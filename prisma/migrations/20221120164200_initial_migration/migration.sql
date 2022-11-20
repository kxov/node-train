-- CreateTable
CREATE TABLE "Account" (
    "accountId" BIGSERIAL NOT NULL,
    "login" VARCHAR(64) NOT NULL,
    "password" VARCHAR NOT NULL,

    CONSTRAINT "pkAccount" PRIMARY KEY ("accountId")
);

-- CreateTable
CREATE TABLE "AccountRole" (
    "accountId" BIGINT NOT NULL,
    "roleId" BIGINT NOT NULL,

    CONSTRAINT "pkAccountRole" PRIMARY KEY ("accountId","roleId")
);

-- CreateTable
CREATE TABLE "Album" (
    "albumId" BIGSERIAL NOT NULL,
    "name" VARCHAR NOT NULL,
    "groupId" BIGINT NOT NULL,

    CONSTRAINT "pkAlbum" PRIMARY KEY ("albumId")
);

-- CreateTable
CREATE TABLE "Area" (
    "areaId" BIGSERIAL NOT NULL,
    "name" VARCHAR NOT NULL,
    "ownerId" BIGINT NOT NULL,

    CONSTRAINT "pkArea" PRIMARY KEY ("areaId")
);

-- CreateTable
CREATE TABLE "AreaAccount" (
    "areaId" BIGINT NOT NULL,
    "accountId" BIGINT NOT NULL,

    CONSTRAINT "pkAreaAccount" PRIMARY KEY ("areaId","accountId")
);

-- CreateTable
CREATE TABLE "Artist" (
    "artistId" BIGSERIAL NOT NULL,
    "name" VARCHAR(64) NOT NULL,
    "age" DATE NOT NULL,

    CONSTRAINT "pkArtist" PRIMARY KEY ("artistId")
);

-- CreateTable
CREATE TABLE "ArtistGroup" (
    "artistId" BIGINT NOT NULL,
    "groupId" BIGINT NOT NULL,

    CONSTRAINT "pkArtistGroup" PRIMARY KEY ("artistId","groupId")
);

-- CreateTable
CREATE TABLE "ArtistOccupation" (
    "artistId" BIGINT NOT NULL,
    "occupationId" BIGINT NOT NULL,

    CONSTRAINT "pkArtistOccupation" PRIMARY KEY ("artistId","occupationId")
);

-- CreateTable
CREATE TABLE "Group" (
    "groupId" BIGSERIAL NOT NULL,
    "name" VARCHAR NOT NULL,
    "genre" VARCHAR NOT NULL,

    CONSTRAINT "pkGroup" PRIMARY KEY ("groupId")
);

-- CreateTable
CREATE TABLE "Message" (
    "messageId" BIGSERIAL NOT NULL,
    "areaId" BIGINT NOT NULL,
    "fromId" BIGINT NOT NULL,
    "text" VARCHAR NOT NULL,

    CONSTRAINT "pkMessage" PRIMARY KEY ("messageId")
);

-- CreateTable
CREATE TABLE "Occupation" (
    "occupationId" BIGSERIAL NOT NULL,
    "name" VARCHAR NOT NULL,

    CONSTRAINT "pkOccupation" PRIMARY KEY ("occupationId")
);

-- CreateTable
CREATE TABLE "Role" (
    "roleId" BIGSERIAL NOT NULL,
    "name" VARCHAR NOT NULL,

    CONSTRAINT "pkRole" PRIMARY KEY ("roleId")
);

-- CreateTable
CREATE TABLE "Session" (
    "sessionId" BIGSERIAL NOT NULL,
    "accountId" BIGINT NOT NULL,
    "token" VARCHAR NOT NULL,
    "ip" INET NOT NULL,
    "data" JSONB NOT NULL,

    CONSTRAINT "pkSession" PRIMARY KEY ("sessionId")
);

-- CreateTable
CREATE TABLE "Song" (
    "songId" BIGSERIAL NOT NULL,
    "name" VARCHAR NOT NULL,

    CONSTRAINT "pkSong" PRIMARY KEY ("songId")
);

-- CreateTable
CREATE TABLE "SongAlbum" (
    "songId" BIGINT NOT NULL,
    "albumId" BIGINT NOT NULL,

    CONSTRAINT "pkSongAlbum" PRIMARY KEY ("songId","albumId")
);

-- CreateIndex
CREATE UNIQUE INDEX "akAccountLogin" ON "Account"("login");

-- CreateIndex
CREATE UNIQUE INDEX "akAreaName" ON "Area"("name");

-- CreateIndex
CREATE UNIQUE INDEX "akGroupName" ON "Group"("name");

-- CreateIndex
CREATE UNIQUE INDEX "akOccupationName" ON "Occupation"("name");

-- CreateIndex
CREATE UNIQUE INDEX "akRoleName" ON "Role"("name");

-- CreateIndex
CREATE UNIQUE INDEX "akSessionToken" ON "Session"("token");

-- AddForeignKey
ALTER TABLE "AccountRole" ADD CONSTRAINT "fkAccountRoleAccount" FOREIGN KEY ("accountId") REFERENCES "Account"("accountId") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "AccountRole" ADD CONSTRAINT "fkAccountRoleRole" FOREIGN KEY ("roleId") REFERENCES "Role"("roleId") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "Album" ADD CONSTRAINT "fkAlbumGroup" FOREIGN KEY ("groupId") REFERENCES "Group"("groupId") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "Area" ADD CONSTRAINT "fkAreaOwner" FOREIGN KEY ("ownerId") REFERENCES "Account"("accountId") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "AreaAccount" ADD CONSTRAINT "fkAreaAccountAccount" FOREIGN KEY ("accountId") REFERENCES "Account"("accountId") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "AreaAccount" ADD CONSTRAINT "fkAreaAccountArea" FOREIGN KEY ("areaId") REFERENCES "Area"("areaId") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "ArtistGroup" ADD CONSTRAINT "fkArtistGroupArtist" FOREIGN KEY ("artistId") REFERENCES "Artist"("artistId") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "ArtistGroup" ADD CONSTRAINT "fkArtistGroupGroup" FOREIGN KEY ("groupId") REFERENCES "Group"("groupId") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "ArtistOccupation" ADD CONSTRAINT "fkArtistOccupationArtist" FOREIGN KEY ("artistId") REFERENCES "Artist"("artistId") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "ArtistOccupation" ADD CONSTRAINT "fkArtistOccupationOccupation" FOREIGN KEY ("occupationId") REFERENCES "Occupation"("occupationId") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "Message" ADD CONSTRAINT "fkMessageArea" FOREIGN KEY ("areaId") REFERENCES "Area"("areaId") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "Message" ADD CONSTRAINT "fkMessageFrom" FOREIGN KEY ("fromId") REFERENCES "Account"("accountId") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "Session" ADD CONSTRAINT "fkSessionAccount" FOREIGN KEY ("accountId") REFERENCES "Account"("accountId") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "SongAlbum" ADD CONSTRAINT "fkSongAlbumAlbum" FOREIGN KEY ("albumId") REFERENCES "Album"("albumId") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "SongAlbum" ADD CONSTRAINT "fkSongAlbumSong" FOREIGN KEY ("songId") REFERENCES "Song"("songId") ON DELETE CASCADE ON UPDATE NO ACTION;
