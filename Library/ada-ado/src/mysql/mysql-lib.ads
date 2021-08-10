-----------------------------------------------------------------------
--  mysql-lib.ads --  MySQL Library information
--  Copyright (C) 2011, 2012, 2013, 2018 Stephane Carrez
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

package Mysql.Lib is

   pragma Pure;
   pragma Style_Checks ("-mr");

   MYSQL_LIB_NAME : constant String := "-lmariadb";

end Mysql.Lib;
