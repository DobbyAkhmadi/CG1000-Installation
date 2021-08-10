--
-- Copyright (c) 2007-2009 Tero Koskinen <tero.koskinen@iki.fi>
--
-- Permission to use, copy, modify, and distribute this software for any
-- purpose with or without fee is hereby granted, provided that the above
-- copyright notice and this permission notice appear in all copies.
--
-- THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
-- WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
-- MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
-- ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
-- WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
-- ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
-- OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
--
with Ahven.Framework;
with Ahven.Results;
with Ahven.Parameters;

package Ahven.XML_Runner is

   procedure Run (Suite : in out Framework.Test_Suite'Class);
   -- Run the suite and print the results.

   procedure Run (Suite : Framework.Test_Suite_Access);
   -- Run the suite and print the results. The routine is
   -- identical to the above routine, but takes an access
   -- parameter to a test suite.

   procedure Report_Results (Result : Results.Result_Collection;
                             Dir    : String);
   -- Report results to the given directory.
private
   procedure Do_Report (Test_Results : Results.Result_Collection;
                        Args         : Parameters.Parameter_Info);
end Ahven.XML_Runner;
