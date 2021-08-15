-----------------------------------------------------------------------
--  ADO.Model -- ADO.Model
-----------------------------------------------------------------------
--  File generated by ada-gen DO NOT MODIFY
--  Template used: templates/model/package-spec.xhtml
--  Ada Generator: https://ada-gen.googlecode.com/svn/trunk Revision 166
-----------------------------------------------------------------------
--  Copyright (C) 2011, 2012 Stephane Carrez
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--
--  Licensed under the Apache License, Version 2.0 (the "License");
--  you may not use this file except in compliance with the License.
--  You may obtain a copy of the License at
--
--      http://www.apache.org/licenses/LICENSE-2.0
--
--  Unless required by applicable law or agreed to in writing, software
--  distributed under the License is distributed on an "AS IS" BASIS,
--  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
--  See the License for the specific language governing permissions and
--  limitations under the License.
-----------------------------------------------------------------------
with ADO.Sessions;
with ADO.Statements;
with ADO.SQL;
with ADO.Schemas;
with Ada.Strings.Unbounded;
private package ADO.Model is

   NOT_FOUND : exception;

   --  --------------------
   --  Sequence generator
   --  --------------------

   type Sequence_Ref is tagged record
      Id         : Ada.Strings.Unbounded.Unbounded_String;
      Version    : Integer;
      Value      : ADO.Identifier;
      Block_Size : ADO.Identifier;
      Need_Save  : Boolean := False;
   end record;

   --  Set the sequence name
   procedure Set_Name (Object : in out Sequence_Ref;
                       Value  : in Ada.Strings.Unbounded.Unbounded_String);
   procedure Set_Name (Object : in out Sequence_Ref;
                       Value : in String);

   --  Get the sequence name
   function Get_Name (Object : in Sequence_Ref)
                 return Ada.Strings.Unbounded.Unbounded_String;
   function Get_Name (Object : in Sequence_Ref)
                 return String;
   --  Get the sequence record version
   function Get_Version (Object : in Sequence_Ref)
                 return Integer;

   --  Set the sequence value
   procedure Set_Value (Object : in out Sequence_Ref;
                        Value  : in ADO.Identifier);

   --  Get the sequence value
   function Get_Value (Object : in Sequence_Ref)
                 return ADO.Identifier;

   --  Set the sequence block size
   procedure Set_Block_Size (Object : in out Sequence_Ref;
                             Value  : in ADO.Identifier);

   --  Get the sequence block size
   function Get_Block_Size (Object : in Sequence_Ref)
                 return ADO.Identifier;

   --  Find and load the entity.
--     overriding
   procedure Find (Object  : in out Sequence_Ref;
                   Session : in out ADO.Sessions.Session'Class;
                   Query   : in ADO.SQL.Query'Class;
                   Found   : out Boolean);

   --  Save the entity.  If the entity does not have an identifier, an identifier is allocated
   --  and it is inserted in the table.  Otherwise, only data fields which have been changed
   --  are updated.
   procedure Save (Object  : in out Sequence_Ref;
                   Session : in out ADO.Sessions.Master_Session'Class);

   procedure Create (Object  : in out Sequence_Ref;
                     Session : in out ADO.Sessions.Master_Session'Class);

   --  Table definition
   SEQUENCE_TABLE : aliased constant ADO.Schemas.Class_Mapping;

   --  --------------------
   --  Entity types
   --  --------------------

   --  Table definition
   ENTITY_TYPE_TABLE : aliased constant ADO.Schemas.Class_Mapping;

private
   SEQUENCE_NAME : aliased constant String := "sequence";
   COL_0_1_NAME : aliased constant String := "name";
   COL_1_1_NAME : aliased constant String := "version";
   COL_2_1_NAME : aliased constant String := "value";
   COL_3_1_NAME : aliased constant String := "block_size";
   SEQUENCE_TABLE : aliased constant ADO.Schemas.Class_Mapping :=
     (Count => 4,
      Table => SEQUENCE_NAME'Access,
      Members => (
                  COL_0_1_NAME'Access,
                  COL_1_1_NAME'Access,
                  COL_2_1_NAME'Access,
                  COL_3_1_NAME'Access
                 )
     );

   ENTITY_TYPE_NAME : aliased constant String := "entity_type";
   COL_0_2_NAME : aliased constant String := "id";
   COL_1_2_NAME : aliased constant String := "name";
   ENTITY_TYPE_TABLE : aliased constant ADO.Schemas.Class_Mapping :=
     (Count => 2,
      Table => ENTITY_TYPE_NAME'Access,
      Members => (
                  COL_0_2_NAME'Access,
                  COL_1_2_NAME'Access
                 )
     );

   --  Load the object from current iterator position
   procedure Load (Object  : in out Sequence_Ref;
                   Stmt    : in out ADO.Statements.Query_Statement'Class;
                   Session : in out ADO.Sessions.Session'Class);

end ADO.Model;