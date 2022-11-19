interface Role {
  name: string;
  roleId?: string;
}

interface Account {
  login: string;
  password: string;
  rolesId: string[];
  accountId?: string;
}

interface Group {
  name: string;
  genre: string;
  groupId?: string;
}

interface Album {
  name: string;
  groupId: string;
  albumId?: string;
}

interface Area {
  name: string;
  ownerId: string;
  membersId: string[];
  areaId?: string;
}

interface Occupation {
  name: string;
  occupationId?: string;
}

interface Artist {
  name: string;
  age: number;
  occupationId: string[];
  groupId: string[];
  artistId?: string;
}

interface Message {
  areaId: string;
  fromId: string;
  text: string;
  messageId?: string;
}

interface Session {
  accountId: string;
  token: string;
  ip: string;
  data: string;
  sessionId?: string;
}

interface Song {
  name: string;
  albumId: string[];
  songId?: string;
}
