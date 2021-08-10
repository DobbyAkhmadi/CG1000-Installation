-----------------------------------------------------------------------
--  Util testsuite - Util Testsuite
--  Copyright (C) 2009 - 2021 Stephane Carrez
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

with Util.Properties.Tests;
with Util.Properties.Bundles.Tests;
with Util.Properties.JSON.Tests;
with Util.Properties.Form.Tests;
with Util.Log.Tests;
with Util.Files.Tests;
with Util.Concurrent.Tests;
with Util.Events.Channels.Tests;
with Util.Events.Timers.Tests;
with Util.Listeners.Tests;
with Util.Locales.Tests;
with Util.Strings.Tests;
with Util.Dates.Tests;
with Util.Dates.Formats.Tests;
with Util.Encoders.Tests;
with Util.Encoders.KDF.Tests;
with Util.Encoders.ECC.Tests;
with Util.Mail.Tests;
with Util.Nullables.Tests;
with Util.Commands.Tests;
with Util.Streams.Buffered.Tests;
with Util.Streams.Files.Tests;
with Util.Streams.Texts.Tests;
with Util.Streams.Sockets.Tests;
with Util.Streams.Tests;
with Util.Texts.Builders_Tests;
with Util.Beans.Objects.Discretes;
with Util.Beans.Objects.Record_Tests;
with Util.Beans.Objects.Datasets.Tests;
with Util.Beans.Objects.Tests;
with Util.Beans.Ranges.Tests;
with Util.Serialize.IO.JSON.Tests;
with Util.Serialize.IO.Form.Tests;
with Util.Serialize.IO.XML.Tests;
with Util.Serialize.Tools.Tests;
with Util.Processes.Tests;
with Util.Http.Cookies.Tests;
with Util.Http.Clients.AWS.Tests;
with Util.Systems.DLLs.Tests;
with Util.Systems.Os.Tests;
package body Util.Testsuite is

   Tests : aliased Util.Tests.Test_Suite;

   function Suite return Util.Tests.Access_Test_Suite is
      Result : constant Util.Tests.Access_Test_Suite := Tests'Access;
   begin
      Util.Properties.Tests.Add_Tests (Result);
      Util.Properties.Bundles.Tests.Add_Tests (Result);
      Util.Locales.Tests.Add_Tests (Result);
      Util.Strings.Tests.Add_Tests (Result);
      Util.Nullables.Tests.Add_Tests (Result);
      Util.Mail.Tests.Add_Tests (Result);
      Util.Dates.Tests.Add_Tests (Result);
      Util.Dates.Formats.Tests.Add_Tests (Result);
      Util.Log.Tests.Add_Tests (Result);
      Util.Files.Tests.Add_Tests (Result);
      Util.Commands.Tests.Add_Tests (Result);
      Util.Concurrent.Tests.Add_Tests (Result);
      Util.Events.Channels.Tests.Add_Tests (Result);
      Util.Events.Timers.Tests.Add_Tests (Result);
      Util.Listeners.Tests.Add_Tests (Result);
      Util.Encoders.Tests.Add_Tests (Result);
      Util.Encoders.ECC.Tests.Add_Tests (Result);
      Util.Encoders.KDF.Tests.Add_Tests (Result);
      Util.Streams.Buffered.Tests.Add_Tests (Result);
      Util.Streams.Files.Tests.Add_Tests (Result);
      Util.Streams.Tests.Add_Tests (Result);
      Util.Streams.Texts.Tests.Add_Tests (Result);
      Util.Streams.Sockets.Tests.Add_Tests (Result);
      Util.Texts.Builders_Tests.Add_Tests (Result);
      Util.Beans.Objects.Discretes.Add_Tests (Result);
      Util.Beans.Objects.Record_Tests.Add_Tests (Result);
      Util.Beans.Objects.Datasets.Tests.Add_Tests (Result);
      Util.Beans.Objects.Tests.Add_Tests (Result);
      Util.Beans.Ranges.Tests.Add_Tests (Result);
      Util.Serialize.IO.JSON.Tests.Add_Tests (Result);
      Util.Serialize.IO.Form.Tests.Add_Tests (Result);
      Util.Properties.JSON.Tests.Add_Tests (Result);
      Util.Properties.Form.Tests.Add_Tests (Result);
      Util.Serialize.IO.XML.Tests.Add_Tests (Result);
      Util.Serialize.Tools.Tests.Add_Tests (Result);
      Util.Processes.Tests.Add_Tests (Result);
      Util.Http.Cookies.Tests.Add_Tests (Result);
      Util.Http.Clients.AWS.Tests.Add_Tests (Result);
      Util.Systems.DLLs.Tests.Add_Tests (Result);
      Util.Systems.Os.Tests.Add_Tests (Result);
      return Result;
   end Suite;

end Util.Testsuite;
