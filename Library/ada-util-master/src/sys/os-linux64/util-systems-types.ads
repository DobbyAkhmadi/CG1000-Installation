--  Generated by utildgen.c from system includes
with Interfaces.C;
package Util.Systems.Types is

   subtype dev_t is Long_Long_Integer;
   subtype ino_t is Long_Long_Integer;
   subtype off_t is Long_Long_Integer;
   subtype blksize_t is Long_Long_Integer;
   subtype blkcnt_t is Long_Long_Integer;
   subtype uid_t is Interfaces.C.unsigned;
   subtype gid_t is Interfaces.C.unsigned;
   subtype nlink_t is Long_Long_Integer;
   subtype mode_t is Interfaces.C.unsigned;

   S_IFMT   : constant mode_t := 8#00170000#;
   S_IFDIR  : constant mode_t := 8#00040000#;
   S_IFCHR  : constant mode_t := 8#00020000#;
   S_IFBLK  : constant mode_t := 8#00060000#;
   S_IFREG  : constant mode_t := 8#00100000#;
   S_IFIFO  : constant mode_t := 8#00010000#;
   S_IFLNK  : constant mode_t := 8#00120000#;
   S_IFSOCK : constant mode_t := 8#00140000#;
   S_ISUID  : constant mode_t := 8#00004000#;
   S_ISGID  : constant mode_t := 8#00002000#;
   S_IREAD  : constant mode_t := 8#00000400#;
   S_IWRITE : constant mode_t := 8#00000200#;
   S_IEXEC  : constant mode_t := 8#00000100#;

   type File_Type is new Interfaces.C.int;
   subtype Time_Type is Long_Long_Integer;

   type Timespec is record
      tv_sec  : Time_Type;
      tv_nsec : Long_Long_Integer;
   end record;
   pragma Convention (C_Pass_By_Copy, Timespec);

   type Seek_Mode is (SEEK_SET, SEEK_CUR, SEEK_END);
   for Seek_Mode use (SEEK_SET => 0, SEEK_CUR => 1, SEEK_END => 2);

   STAT_NAME  : constant String := "stat";
   FSTAT_NAME : constant String := "fstat";
   type Stat_Type is record
      st_dev     : dev_t;
      st_ino     : ino_t;
      st_nlink   : nlink_t;
      st_mode    : mode_t;
      st_uid     : uid_t;
      st_gid     : gid_t;
      pad1_0     : Interfaces.C.unsigned;
      st_rdev    : dev_t;
      st_size    : off_t;
      st_blksize : blksize_t;
      st_blocks  : blkcnt_t;
      st_atim    : Timespec;
      st_mtim    : Timespec;
      st_ctim    : Timespec;
      pad5    : Interfaces.C.unsigned_long;
      pad6    : Interfaces.C.unsigned_long;
      pad7    : Interfaces.C.unsigned_long;
   end record;
   pragma Convention (C_Pass_By_Copy, Stat_Type);


end Util.Systems.Types;
