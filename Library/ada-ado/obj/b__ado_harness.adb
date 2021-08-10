pragma Warnings (Off);
pragma Ada_95;
pragma Source_File_Name (ada_main, Spec_File_Name => "b__ado_harness.ads");
pragma Source_File_Name (ada_main, Body_File_Name => "b__ado_harness.adb");
pragma Suppress (Overflow_Check);

with System.Restrictions;
with Ada.Exceptions;

package body ada_main is

   E073 : Short_Integer; pragma Import (Ada, E073, "system__os_lib_E");
   E011 : Short_Integer; pragma Import (Ada, E011, "system__soft_links_E");
   E023 : Short_Integer; pragma Import (Ada, E023, "system__exception_table_E");
   E038 : Short_Integer; pragma Import (Ada, E038, "ada__containers_E");
   E068 : Short_Integer; pragma Import (Ada, E068, "ada__io_exceptions_E");
   E053 : Short_Integer; pragma Import (Ada, E053, "ada__strings_E");
   E055 : Short_Integer; pragma Import (Ada, E055, "ada__strings__maps_E");
   E059 : Short_Integer; pragma Import (Ada, E059, "ada__strings__maps__constants_E");
   E043 : Short_Integer; pragma Import (Ada, E043, "interfaces__c_E");
   E025 : Short_Integer; pragma Import (Ada, E025, "system__exceptions_E");
   E079 : Short_Integer; pragma Import (Ada, E079, "system__object_reader_E");
   E048 : Short_Integer; pragma Import (Ada, E048, "system__dwarf_lines_E");
   E019 : Short_Integer; pragma Import (Ada, E019, "system__soft_links__initialize_E");
   E037 : Short_Integer; pragma Import (Ada, E037, "system__traceback__symbolic_E");
   E257 : Short_Integer; pragma Import (Ada, E257, "ada__strings__utf_encoding_E");
   E097 : Short_Integer; pragma Import (Ada, E097, "ada__tags_E");
   E146 : Short_Integer; pragma Import (Ada, E146, "ada__streams_E");
   E203 : Short_Integer; pragma Import (Ada, E203, "gnat_E");
   E284 : Short_Integer; pragma Import (Ada, E284, "interfaces__c__strings_E");
   E163 : Short_Integer; pragma Import (Ada, E163, "system__file_control_block_E");
   E148 : Short_Integer; pragma Import (Ada, E148, "system__finalization_root_E");
   E144 : Short_Integer; pragma Import (Ada, E144, "ada__finalization_E");
   E160 : Short_Integer; pragma Import (Ada, E160, "system__file_io_E");
   E167 : Short_Integer; pragma Import (Ada, E167, "ada__streams__stream_io_E");
   E150 : Short_Integer; pragma Import (Ada, E150, "system__storage_pools_E");
   E141 : Short_Integer; pragma Import (Ada, E141, "system__finalization_masters_E");
   E139 : Short_Integer; pragma Import (Ada, E139, "system__storage_pools__subpools_E");
   E133 : Short_Integer; pragma Import (Ada, E133, "ada__strings__unbounded_E");
   E278 : Short_Integer; pragma Import (Ada, E278, "ada__strings__wide_wide_maps_E");
   E274 : Short_Integer; pragma Import (Ada, E274, "ada__strings__wide_wide_unbounded_E");
   E224 : Short_Integer; pragma Import (Ada, E224, "system__task_info_E");
   E218 : Short_Integer; pragma Import (Ada, E218, "system__task_primitives__operations_E");
   E588 : Short_Integer; pragma Import (Ada, E588, "system__regpat_E");
   E107 : Short_Integer; pragma Import (Ada, E107, "ada__calendar_E");
   E463 : Short_Integer; pragma Import (Ada, E463, "ada__calendar__delays_E");
   E113 : Short_Integer; pragma Import (Ada, E113, "ada__calendar__time_zones_E");
   E528 : Short_Integer; pragma Import (Ada, E528, "ada__real_time_E");
   E202 : Short_Integer; pragma Import (Ada, E202, "ada__text_io_E");
   E382 : Short_Integer; pragma Import (Ada, E382, "gnat__calendar_E");
   E385 : Short_Integer; pragma Import (Ada, E385, "gnat__calendar__time_io_E");
   E345 : Short_Integer; pragma Import (Ada, E345, "gnat__directory_operations_E");
   E208 : Short_Integer; pragma Import (Ada, E208, "system__assertions_E");
   E174 : Short_Integer; pragma Import (Ada, E174, "system__pool_global_E");
   E165 : Short_Integer; pragma Import (Ada, E165, "system__regexp_E");
   E105 : Short_Integer; pragma Import (Ada, E105, "ada__directories_E");
   E583 : Short_Integer; pragma Import (Ada, E583, "gnat__command_line_E");
   E483 : Short_Integer; pragma Import (Ada, E483, "system__tasking__initialization_E");
   E238 : Short_Integer; pragma Import (Ada, E238, "system__tasking__protected_objects_E");
   E489 : Short_Integer; pragma Import (Ada, E489, "system__tasking__protected_objects__entries_E");
   E487 : Short_Integer; pragma Import (Ada, E487, "system__tasking__queuing_E");
   E542 : Short_Integer; pragma Import (Ada, E542, "system__tasking__stages_E");
   E357 : Short_Integer; pragma Import (Ada, E357, "unicode_E");
   E253 : Short_Integer; pragma Import (Ada, E253, "util__beans__objects_E");
   E272 : Short_Integer; pragma Import (Ada, E272, "util__beans__basic_E");
   E191 : Short_Integer; pragma Import (Ada, E191, "util__log_E");
   E181 : Short_Integer; pragma Import (Ada, E181, "util__refs_E");
   E172 : Short_Integer; pragma Import (Ada, E172, "util__streams_E");
   E336 : Short_Integer; pragma Import (Ada, E336, "util__streams__buffered_E");
   E244 : Short_Integer; pragma Import (Ada, E244, "util__strings_E");
   E524 : Short_Integer; pragma Import (Ada, E524, "ahven_E");
   E546 : Short_Integer; pragma Import (Ada, E546, "ahven__astrings_E");
   E545 : Short_Integer; pragma Import (Ada, E545, "ahven__astrings_E");
   E530 : Short_Integer; pragma Import (Ada, E530, "ahven__long_astrings_E");
   E529 : Short_Integer; pragma Import (Ada, E529, "ahven__long_astrings_E");
   E548 : Short_Integer; pragma Import (Ada, E548, "ahven__listeners_E");
   E550 : Short_Integer; pragma Import (Ada, E550, "ahven__slist_E");
   E565 : Short_Integer; pragma Import (Ada, E565, "ahven__results_E");
   E567 : Short_Integer; pragma Import (Ada, E567, "ahven__temporary_output_E");
   E563 : Short_Integer; pragma Import (Ada, E563, "ahven__listeners__basic_E");
   E579 : Short_Integer; pragma Import (Ada, E579, "ahven_compat_E");
   E353 : Short_Integer; pragma Import (Ada, E353, "sax__htable_E");
   E355 : Short_Integer; pragma Import (Ada, E355, "sax__pointers_E");
   E370 : Short_Integer; pragma Import (Ada, E370, "unicode__ccs_E");
   E402 : Short_Integer; pragma Import (Ada, E402, "unicode__ccs__iso_8859_1_E");
   E404 : Short_Integer; pragma Import (Ada, E404, "unicode__ccs__iso_8859_15_E");
   E409 : Short_Integer; pragma Import (Ada, E409, "unicode__ccs__iso_8859_2_E");
   E412 : Short_Integer; pragma Import (Ada, E412, "unicode__ccs__iso_8859_3_E");
   E414 : Short_Integer; pragma Import (Ada, E414, "unicode__ccs__iso_8859_4_E");
   E416 : Short_Integer; pragma Import (Ada, E416, "unicode__ccs__windows_1251_E");
   E421 : Short_Integer; pragma Import (Ada, E421, "unicode__ccs__windows_1252_E");
   E366 : Short_Integer; pragma Import (Ada, E366, "unicode__ces_E");
   E348 : Short_Integer; pragma Import (Ada, E348, "sax__symbols_E");
   E343 : Short_Integer; pragma Import (Ada, E343, "sax__locators_E");
   E341 : Short_Integer; pragma Import (Ada, E341, "sax__exceptions_E");
   E372 : Short_Integer; pragma Import (Ada, E372, "unicode__ces__utf32_E");
   E424 : Short_Integer; pragma Import (Ada, E424, "unicode__ces__basic_8bit_E");
   E426 : Short_Integer; pragma Import (Ada, E426, "unicode__ces__utf16_E");
   E368 : Short_Integer; pragma Import (Ada, E368, "unicode__ces__utf8_E");
   E430 : Short_Integer; pragma Import (Ada, E430, "sax__models_E");
   E428 : Short_Integer; pragma Import (Ada, E428, "sax__attributes_E");
   E439 : Short_Integer; pragma Import (Ada, E439, "sax__utils_E");
   E400 : Short_Integer; pragma Import (Ada, E400, "unicode__encodings_E");
   E398 : Short_Integer; pragma Import (Ada, E398, "input_sources_E");
   E435 : Short_Integer; pragma Import (Ada, E435, "input_sources__file_E");
   E437 : Short_Integer; pragma Import (Ada, E437, "input_sources__strings_E");
   E433 : Short_Integer; pragma Import (Ada, E433, "sax__readers_E");
   E557 : Short_Integer; pragma Import (Ada, E557, "util__beans__basic__lists_E");
   E597 : Short_Integer; pragma Import (Ada, E597, "util__beans__objects__datasets_E");
   E280 : Short_Integer; pragma Import (Ada, E280, "util__beans__objects__maps_E");
   E374 : Short_Integer; pragma Import (Ada, E374, "util__dates_E");
   E378 : Short_Integer; pragma Import (Ada, E378, "util__dates__iso8601_E");
   E179 : Short_Integer; pragma Import (Ada, E179, "util__nullables_E");
   E467 : Short_Integer; pragma Import (Ada, E467, "util__beans__objects__time_E");
   E332 : Short_Integer; pragma Import (Ada, E332, "util__serialize__contexts_E");
   E178 : Short_Integer; pragma Import (Ada, E178, "util__streams__files_E");
   E103 : Short_Integer; pragma Import (Ada, E103, "ado_E");
   E493 : Short_Integer; pragma Import (Ada, E493, "ado__c_E");
   E449 : Short_Integer; pragma Import (Ada, E449, "ado__dialects_E");
   E453 : Short_Integer; pragma Import (Ada, E453, "ado__utils_E");
   E380 : Short_Integer; pragma Import (Ada, E380, "util__streams__texts_E");
   E544 : Short_Integer; pragma Import (Ada, E544, "util__measures_E");
   E291 : Short_Integer; pragma Import (Ada, E291, "util__strings__maps_E");
   E293 : Short_Integer; pragma Import (Ada, E293, "util__strings__vectors_E");
   E282 : Short_Integer; pragma Import (Ada, E282, "util__files_E");
   E248 : Short_Integer; pragma Import (Ada, E248, "util__properties_E");
   E297 : Short_Integer; pragma Import (Ada, E297, "util__properties__discrete_E");
   E246 : Short_Integer; pragma Import (Ada, E246, "util__log__appenders_E");
   E193 : Short_Integer; pragma Import (Ada, E193, "util__log__loggers_E");
   E189 : Short_Integer; pragma Import (Ada, E189, "ado__configs_E");
   E451 : Short_Integer; pragma Import (Ada, E451, "ado__parameters_E");
   E459 : Short_Integer; pragma Import (Ada, E459, "ado__caches_E");
   E311 : Short_Integer; pragma Import (Ada, E311, "ado__schemas_E");
   E447 : Short_Integer; pragma Import (Ada, E447, "ado__sql_E");
   E526 : Short_Integer; pragma Import (Ada, E526, "ahven__framework_E");
   E575 : Short_Integer; pragma Import (Ada, E575, "ahven__parameters_E");
   E571 : Short_Integer; pragma Import (Ada, E571, "ahven__runner_E");
   E577 : Short_Integer; pragma Import (Ada, E577, "ahven__xml_runner_E");
   E569 : Short_Integer; pragma Import (Ada, E569, "ahven__text_runner_E");
   E592 : Short_Integer; pragma Import (Ada, E592, "util__assertions_E");
   E561 : Short_Integer; pragma Import (Ada, E561, "util__xunit_E");
   E581 : Short_Integer; pragma Import (Ada, E581, "util__tests_E");
   E334 : Short_Integer; pragma Import (Ada, E334, "util__serialize__io_E");
   E338 : Short_Integer; pragma Import (Ada, E338, "util__serialize__io__xml_E");
   E441 : Short_Integer; pragma Import (Ada, E441, "util__serialize__mappers_E");
   E445 : Short_Integer; pragma Import (Ada, E445, "util__serialize__mappers__record_mapper_E");
   E308 : Short_Integer; pragma Import (Ada, E308, "util__systems__dlls_E");
   E317 : Short_Integer; pragma Import (Ada, E317, "ado__objects_E");
   E475 : Short_Integer; pragma Import (Ada, E475, "ado__objects__cache_E");
   E327 : Short_Integer; pragma Import (Ada, E327, "ado__queries_E");
   E315 : Short_Integer; pragma Import (Ada, E315, "ado__statements_E");
   E305 : Short_Integer; pragma Import (Ada, E305, "ado__connections_E");
   E329 : Short_Integer; pragma Import (Ada, E329, "ado__queries__loaders_E");
   E321 : Short_Integer; pragma Import (Ada, E321, "ado__sessions_E");
   E465 : Short_Integer; pragma Import (Ada, E465, "ado__audits_E");
   E457 : Short_Integer; pragma Import (Ada, E457, "ado__model_E");
   E455 : Short_Integer; pragma Import (Ada, E455, "ado__schemas__entities_E");
   E323 : Short_Integer; pragma Import (Ada, E323, "ado__sequences_E");
   E461 : Short_Integer; pragma Import (Ada, E461, "ado__sequences__hilo_E");
   E471 : Short_Integer; pragma Import (Ada, E471, "ado__sessions__sources_E");
   E325 : Short_Integer; pragma Import (Ada, E325, "ado__sessions__factory_E");
   E473 : Short_Integer; pragma Import (Ada, E473, "ado__statements__create_E");
   E595 : Short_Integer; pragma Import (Ada, E595, "ado__datasets_E");
   E621 : Short_Integer; pragma Import (Ada, E621, "ado__schemas__databases_E");
   E495 : Short_Integer; pragma Import (Ada, E495, "ado__schemas__mysql_E");
   E522 : Short_Integer; pragma Import (Ada, E522, "ado__sessions__entities_E");
   E497 : Short_Integer; pragma Import (Ada, E497, "ado__statements__mysql_E");
   E552 : Short_Integer; pragma Import (Ada, E552, "regtests_E");
   E555 : Short_Integer; pragma Import (Ada, E555, "regtests__audits__model_E");
   E630 : Short_Integer; pragma Import (Ada, E630, "regtests__images__model_E");
   E602 : Short_Integer; pragma Import (Ada, E602, "regtests__simple__model_E");
   E611 : Short_Integer; pragma Import (Ada, E611, "regtests__comments_E");
   E605 : Short_Integer; pragma Import (Ada, E605, "regtests__statements__model_E");
   E506 : Short_Integer; pragma Import (Ada, E506, "util__processes_E");
   E510 : Short_Integer; pragma Import (Ada, E510, "util__streams__raw_E");
   E508 : Short_Integer; pragma Import (Ada, E508, "util__processes__os_E");
   E516 : Short_Integer; pragma Import (Ada, E516, "util__streams__pipes_E");
   E514 : Short_Integer; pragma Import (Ada, E514, "util__processes__tools_E");
   E477 : Short_Integer; pragma Import (Ada, E477, "ado__connections__mysql_E");
   E187 : Short_Integer; pragma Import (Ada, E187, "ado__drivers_E");
   E559 : Short_Integer; pragma Import (Ada, E559, "util__test_caller_E");
   E520 : Short_Integer; pragma Import (Ada, E520, "ado__audits__tests_E");
   E599 : Short_Integer; pragma Import (Ada, E599, "ado__datasets__tests_E");
   E607 : Short_Integer; pragma Import (Ada, E607, "ado__drivers__tests_E");
   E609 : Short_Integer; pragma Import (Ada, E609, "ado__objects__tests_E");
   E613 : Short_Integer; pragma Import (Ada, E613, "ado__parameters__tests_E");
   E617 : Short_Integer; pragma Import (Ada, E617, "ado__queries__tests_E");
   E619 : Short_Integer; pragma Import (Ada, E619, "ado__schemas__tests_E");
   E623 : Short_Integer; pragma Import (Ada, E623, "ado__sequences__tests_E");
   E625 : Short_Integer; pragma Import (Ada, E625, "ado__statements__tests_E");
   E627 : Short_Integer; pragma Import (Ada, E627, "ado__tests_E");
   E518 : Short_Integer; pragma Import (Ada, E518, "ado__testsuite_E");

   Sec_Default_Sized_Stacks : array (1 .. 1) of aliased System.Secondary_Stack.SS_Stack (System.Parameters.Runtime_Default_Sec_Stack_Size);

   Local_Priority_Specific_Dispatching : constant String := "";
   Local_Interrupt_States : constant String := "";

   Is_Elaborated : Boolean := False;

   procedure finalize_library is
   begin
      declare
         procedure F1;
         pragma Import (Ada, F1, "ado__testsuite__finalize_body");
      begin
         E518 := E518 - 1;
         F1;
      end;
      declare
         procedure F2;
         pragma Import (Ada, F2, "ado__tests__finalize_body");
      begin
         E627 := E627 - 1;
         F2;
      end;
      declare
         procedure F3;
         pragma Import (Ada, F3, "ado__tests__finalize_spec");
      begin
         F3;
      end;
      E625 := E625 - 1;
      declare
         procedure F4;
         pragma Import (Ada, F4, "ado__statements__tests__finalize_spec");
      begin
         F4;
      end;
      declare
         procedure F5;
         pragma Import (Ada, F5, "ado__sequences__tests__finalize_body");
      begin
         E623 := E623 - 1;
         F5;
      end;
      declare
         procedure F6;
         pragma Import (Ada, F6, "ado__sequences__tests__finalize_spec");
      begin
         F6;
      end;
      E619 := E619 - 1;
      declare
         procedure F7;
         pragma Import (Ada, F7, "ado__schemas__tests__finalize_spec");
      begin
         F7;
      end;
      E617 := E617 - 1;
      declare
         procedure F8;
         pragma Import (Ada, F8, "ado__queries__tests__finalize_spec");
      begin
         F8;
      end;
      declare
         procedure F9;
         pragma Import (Ada, F9, "ado__parameters__tests__finalize_body");
      begin
         E613 := E613 - 1;
         F9;
      end;
      declare
         procedure F10;
         pragma Import (Ada, F10, "ado__parameters__tests__finalize_spec");
      begin
         F10;
      end;
      E609 := E609 - 1;
      declare
         procedure F11;
         pragma Import (Ada, F11, "ado__objects__tests__finalize_spec");
      begin
         F11;
      end;
      E607 := E607 - 1;
      declare
         procedure F12;
         pragma Import (Ada, F12, "ado__drivers__tests__finalize_spec");
      begin
         F12;
      end;
      E599 := E599 - 1;
      declare
         procedure F13;
         pragma Import (Ada, F13, "ado__datasets__tests__finalize_spec");
      begin
         F13;
      end;
      declare
         procedure F14;
         pragma Import (Ada, F14, "ado__audits__tests__finalize_body");
      begin
         E520 := E520 - 1;
         F14;
      end;
      declare
         procedure F15;
         pragma Import (Ada, F15, "ado__audits__tests__finalize_spec");
      begin
         F15;
      end;
      declare
         procedure F16;
         pragma Import (Ada, F16, "ado__connections__mysql__finalize_body");
      begin
         E477 := E477 - 1;
         F16;
      end;
      declare
         procedure F17;
         pragma Import (Ada, F17, "ado__connections__mysql__finalize_spec");
      begin
         F17;
      end;
      E516 := E516 - 1;
      declare
         procedure F18;
         pragma Import (Ada, F18, "util__streams__pipes__finalize_spec");
      begin
         F18;
      end;
      declare
         procedure F19;
         pragma Import (Ada, F19, "util__processes__finalize_body");
      begin
         E506 := E506 - 1;
         F19;
      end;
      E508 := E508 - 1;
      declare
         procedure F20;
         pragma Import (Ada, F20, "util__processes__os__finalize_spec");
      begin
         F20;
      end;
      E510 := E510 - 1;
      declare
         procedure F21;
         pragma Import (Ada, F21, "util__streams__raw__finalize_spec");
      begin
         F21;
      end;
      declare
         procedure F22;
         pragma Import (Ada, F22, "util__processes__finalize_spec");
      begin
         F22;
      end;
      E605 := E605 - 1;
      declare
         procedure F23;
         pragma Import (Ada, F23, "regtests__statements__model__finalize_spec");
      begin
         F23;
      end;
      E611 := E611 - 1;
      declare
         procedure F24;
         pragma Import (Ada, F24, "regtests__comments__finalize_spec");
      begin
         F24;
      end;
      E602 := E602 - 1;
      declare
         procedure F25;
         pragma Import (Ada, F25, "regtests__simple__model__finalize_spec");
      begin
         F25;
      end;
      E630 := E630 - 1;
      declare
         procedure F26;
         pragma Import (Ada, F26, "regtests__images__model__finalize_spec");
      begin
         F26;
      end;
      E555 := E555 - 1;
      declare
         procedure F27;
         pragma Import (Ada, F27, "regtests__audits__model__finalize_spec");
      begin
         F27;
      end;
      declare
         procedure F28;
         pragma Import (Ada, F28, "regtests__finalize_body");
      begin
         E552 := E552 - 1;
         F28;
      end;
      declare
         procedure F29;
         pragma Import (Ada, F29, "ado__statements__mysql__finalize_body");
      begin
         E497 := E497 - 1;
         F29;
      end;
      declare
         procedure F30;
         pragma Import (Ada, F30, "ado__statements__mysql__finalize_spec");
      begin
         F30;
      end;
      declare
         procedure F31;
         pragma Import (Ada, F31, "ado__sessions__finalize_body");
      begin
         E321 := E321 - 1;
         F31;
      end;
      declare
         procedure F32;
         pragma Import (Ada, F32, "ado__sequences__finalize_body");
      begin
         E323 := E323 - 1;
         F32;
      end;
      E317 := E317 - 1;
      E325 := E325 - 1;
      declare
         procedure F33;
         pragma Import (Ada, F33, "ado__sessions__factory__finalize_spec");
      begin
         F33;
      end;
      E471 := E471 - 1;
      declare
         procedure F34;
         pragma Import (Ada, F34, "ado__sessions__sources__finalize_spec");
      begin
         F34;
      end;
      declare
         procedure F35;
         pragma Import (Ada, F35, "ado__sequences__hilo__finalize_body");
      begin
         E461 := E461 - 1;
         F35;
      end;
      declare
         procedure F36;
         pragma Import (Ada, F36, "ado__sequences__hilo__finalize_spec");
      begin
         F36;
      end;
      declare
         procedure F37;
         pragma Import (Ada, F37, "ado__sequences__finalize_spec");
      begin
         F37;
      end;
      declare
         procedure F38;
         pragma Import (Ada, F38, "ado__schemas__entities__finalize_body");
      begin
         E455 := E455 - 1;
         F38;
      end;
      declare
         procedure F39;
         pragma Import (Ada, F39, "ado__schemas__entities__finalize_spec");
      begin
         F39;
      end;
      E457 := E457 - 1;
      declare
         procedure F40;
         pragma Import (Ada, F40, "ado__model__finalize_spec");
      begin
         F40;
      end;
      E465 := E465 - 1;
      declare
         procedure F41;
         pragma Import (Ada, F41, "ado__audits__finalize_spec");
      begin
         F41;
      end;
      declare
         procedure F42;
         pragma Import (Ada, F42, "ado__sessions__finalize_spec");
      begin
         F42;
      end;
      E327 := E327 - 1;
      declare
         procedure F43;
         pragma Import (Ada, F43, "ado__queries__loaders__finalize_body");
      begin
         E329 := E329 - 1;
         F43;
      end;
      declare
         procedure F44;
         pragma Import (Ada, F44, "ado__connections__finalize_body");
      begin
         E305 := E305 - 1;
         F44;
      end;
      declare
         procedure F45;
         pragma Import (Ada, F45, "ado__connections__finalize_spec");
      begin
         F45;
      end;
      declare
         procedure F46;
         pragma Import (Ada, F46, "ado__statements__finalize_body");
      begin
         E315 := E315 - 1;
         F46;
      end;
      declare
         procedure F47;
         pragma Import (Ada, F47, "ado__statements__finalize_spec");
      begin
         F47;
      end;
      declare
         procedure F48;
         pragma Import (Ada, F48, "ado__queries__finalize_spec");
      begin
         F48;
      end;
      E475 := E475 - 1;
      declare
         procedure F49;
         pragma Import (Ada, F49, "ado__objects__cache__finalize_spec");
      begin
         F49;
      end;
      declare
         procedure F50;
         pragma Import (Ada, F50, "ado__objects__finalize_spec");
      begin
         F50;
      end;
      declare
         procedure F51;
         pragma Import (Ada, F51, "util__serialize__mappers__finalize_body");
      begin
         E441 := E441 - 1;
         F51;
      end;
      declare
         procedure F52;
         pragma Import (Ada, F52, "util__serialize__mappers__finalize_spec");
      begin
         F52;
      end;
      declare
         procedure F53;
         pragma Import (Ada, F53, "util__serialize__io__xml__finalize_body");
      begin
         E338 := E338 - 1;
         F53;
      end;
      declare
         procedure F54;
         pragma Import (Ada, F54, "util__serialize__io__xml__finalize_spec");
      begin
         F54;
      end;
      declare
         procedure F55;
         pragma Import (Ada, F55, "util__serialize__io__finalize_body");
      begin
         E334 := E334 - 1;
         F55;
      end;
      E561 := E561 - 1;
      declare
         procedure F56;
         pragma Import (Ada, F56, "util__tests__finalize_body");
      begin
         E581 := E581 - 1;
         F56;
      end;
      declare
         procedure F57;
         pragma Import (Ada, F57, "util__tests__finalize_spec");
      begin
         F57;
      end;
      declare
         procedure F58;
         pragma Import (Ada, F58, "util__xunit__finalize_spec");
      begin
         F58;
      end;
      E526 := E526 - 1;
      declare
         procedure F59;
         pragma Import (Ada, F59, "ahven__framework__finalize_spec");
      begin
         F59;
      end;
      E447 := E447 - 1;
      declare
         procedure F60;
         pragma Import (Ada, F60, "ado__sql__finalize_spec");
      begin
         F60;
      end;
      E311 := E311 - 1;
      declare
         procedure F61;
         pragma Import (Ada, F61, "ado__schemas__finalize_spec");
      begin
         F61;
      end;
      E459 := E459 - 1;
      declare
         procedure F62;
         pragma Import (Ada, F62, "ado__caches__finalize_spec");
      begin
         F62;
      end;
      declare
         procedure F63;
         pragma Import (Ada, F63, "ado__parameters__finalize_body");
      begin
         E451 := E451 - 1;
         F63;
      end;
      declare
         procedure F64;
         pragma Import (Ada, F64, "ado__parameters__finalize_spec");
      begin
         F64;
      end;
      declare
         procedure F65;
         pragma Import (Ada, F65, "ado__configs__finalize_body");
      begin
         E189 := E189 - 1;
         F65;
      end;
      declare
         procedure F66;
         pragma Import (Ada, F66, "ado__configs__finalize_spec");
      begin
         F66;
      end;
      E246 := E246 - 1;
      declare
         procedure F67;
         pragma Import (Ada, F67, "util__log__loggers__finalize_body");
      begin
         E193 := E193 - 1;
         F67;
      end;
      declare
         procedure F68;
         pragma Import (Ada, F68, "util__log__loggers__finalize_spec");
      begin
         F68;
      end;
      declare
         procedure F69;
         pragma Import (Ada, F69, "util__log__appenders__finalize_spec");
      begin
         F69;
      end;
      declare
         procedure F70;
         pragma Import (Ada, F70, "util__properties__finalize_body");
      begin
         E248 := E248 - 1;
         F70;
      end;
      declare
         procedure F71;
         pragma Import (Ada, F71, "util__properties__finalize_spec");
      begin
         F71;
      end;
      E544 := E544 - 1;
      declare
         procedure F72;
         pragma Import (Ada, F72, "util__measures__finalize_spec");
      begin
         F72;
      end;
      E380 := E380 - 1;
      declare
         procedure F73;
         pragma Import (Ada, F73, "util__streams__texts__finalize_spec");
      begin
         F73;
      end;
      E453 := E453 - 1;
      declare
         procedure F74;
         pragma Import (Ada, F74, "ado__utils__finalize_spec");
      begin
         F74;
      end;
      E449 := E449 - 1;
      declare
         procedure F75;
         pragma Import (Ada, F75, "ado__dialects__finalize_spec");
      begin
         F75;
      end;
      E493 := E493 - 1;
      declare
         procedure F76;
         pragma Import (Ada, F76, "ado__c__finalize_spec");
      begin
         F76;
      end;
      declare
         procedure F77;
         pragma Import (Ada, F77, "ado__finalize_body");
      begin
         E103 := E103 - 1;
         F77;
      end;
      declare
         procedure F78;
         pragma Import (Ada, F78, "ado__finalize_spec");
      begin
         F78;
      end;
      E178 := E178 - 1;
      declare
         procedure F79;
         pragma Import (Ada, F79, "util__streams__files__finalize_spec");
      begin
         F79;
      end;
      E332 := E332 - 1;
      declare
         procedure F80;
         pragma Import (Ada, F80, "util__serialize__contexts__finalize_spec");
      begin
         F80;
      end;
      declare
         procedure F81;
         pragma Import (Ada, F81, "util__beans__objects__time__finalize_body");
      begin
         E467 := E467 - 1;
         F81;
      end;
      E280 := E280 - 1;
      declare
         procedure F82;
         pragma Import (Ada, F82, "util__beans__objects__maps__finalize_spec");
      begin
         F82;
      end;
      E597 := E597 - 1;
      declare
         procedure F83;
         pragma Import (Ada, F83, "util__beans__objects__datasets__finalize_spec");
      begin
         F83;
      end;
      E433 := E433 - 1;
      declare
         procedure F84;
         pragma Import (Ada, F84, "sax__readers__finalize_spec");
      begin
         F84;
      end;
      E437 := E437 - 1;
      declare
         procedure F85;
         pragma Import (Ada, F85, "input_sources__strings__finalize_spec");
      begin
         F85;
      end;
      E435 := E435 - 1;
      declare
         procedure F86;
         pragma Import (Ada, F86, "input_sources__file__finalize_spec");
      begin
         F86;
      end;
      E398 := E398 - 1;
      declare
         procedure F87;
         pragma Import (Ada, F87, "input_sources__finalize_spec");
      begin
         F87;
      end;
      E439 := E439 - 1;
      declare
         procedure F88;
         pragma Import (Ada, F88, "sax__utils__finalize_spec");
      begin
         F88;
      end;
      E428 := E428 - 1;
      declare
         procedure F89;
         pragma Import (Ada, F89, "sax__attributes__finalize_spec");
      begin
         F89;
      end;
      E341 := E341 - 1;
      declare
         procedure F90;
         pragma Import (Ada, F90, "sax__exceptions__finalize_spec");
      begin
         F90;
      end;
      E348 := E348 - 1;
      declare
         procedure F91;
         pragma Import (Ada, F91, "sax__symbols__finalize_spec");
      begin
         F91;
      end;
      E355 := E355 - 1;
      declare
         procedure F92;
         pragma Import (Ada, F92, "sax__pointers__finalize_spec");
      begin
         F92;
      end;
      E563 := E563 - 1;
      declare
         procedure F93;
         pragma Import (Ada, F93, "ahven__listeners__basic__finalize_spec");
      begin
         F93;
      end;
      E565 := E565 - 1;
      declare
         procedure F94;
         pragma Import (Ada, F94, "ahven__results__finalize_spec");
      begin
         F94;
      end;
      E548 := E548 - 1;
      declare
         procedure F95;
         pragma Import (Ada, F95, "ahven__listeners__finalize_spec");
      begin
         F95;
      end;
      E244 := E244 - 1;
      declare
         procedure F96;
         pragma Import (Ada, F96, "util__strings__finalize_spec");
      begin
         F96;
      end;
      E336 := E336 - 1;
      declare
         procedure F97;
         pragma Import (Ada, F97, "util__streams__buffered__finalize_spec");
      begin
         F97;
      end;
      E172 := E172 - 1;
      declare
         procedure F98;
         pragma Import (Ada, F98, "util__streams__finalize_spec");
      begin
         F98;
      end;
      E253 := E253 - 1;
      declare
         procedure F99;
         pragma Import (Ada, F99, "util__beans__basic__finalize_spec");
      begin
         E272 := E272 - 1;
         F99;
      end;
      declare
         procedure F100;
         pragma Import (Ada, F100, "util__beans__objects__finalize_spec");
      begin
         F100;
      end;
      E489 := E489 - 1;
      declare
         procedure F101;
         pragma Import (Ada, F101, "system__tasking__protected_objects__entries__finalize_spec");
      begin
         F101;
      end;
      E105 := E105 - 1;
      declare
         procedure F102;
         pragma Import (Ada, F102, "ada__directories__finalize_spec");
      begin
         F102;
      end;
      E165 := E165 - 1;
      declare
         procedure F103;
         pragma Import (Ada, F103, "system__regexp__finalize_spec");
      begin
         F103;
      end;
      E174 := E174 - 1;
      declare
         procedure F104;
         pragma Import (Ada, F104, "system__pool_global__finalize_spec");
      begin
         F104;
      end;
      E202 := E202 - 1;
      declare
         procedure F105;
         pragma Import (Ada, F105, "ada__text_io__finalize_spec");
      begin
         F105;
      end;
      E274 := E274 - 1;
      declare
         procedure F106;
         pragma Import (Ada, F106, "ada__strings__wide_wide_unbounded__finalize_spec");
      begin
         F106;
      end;
      E278 := E278 - 1;
      declare
         procedure F107;
         pragma Import (Ada, F107, "ada__strings__wide_wide_maps__finalize_spec");
      begin
         F107;
      end;
      E133 := E133 - 1;
      declare
         procedure F108;
         pragma Import (Ada, F108, "ada__strings__unbounded__finalize_spec");
      begin
         F108;
      end;
      E139 := E139 - 1;
      declare
         procedure F109;
         pragma Import (Ada, F109, "system__storage_pools__subpools__finalize_spec");
      begin
         F109;
      end;
      E141 := E141 - 1;
      declare
         procedure F110;
         pragma Import (Ada, F110, "system__finalization_masters__finalize_spec");
      begin
         F110;
      end;
      E167 := E167 - 1;
      declare
         procedure F111;
         pragma Import (Ada, F111, "ada__streams__stream_io__finalize_spec");
      begin
         F111;
      end;
      declare
         procedure F112;
         pragma Import (Ada, F112, "system__file_io__finalize_body");
      begin
         E160 := E160 - 1;
         F112;
      end;
      declare
         procedure Reraise_Library_Exception_If_Any;
            pragma Import (Ada, Reraise_Library_Exception_If_Any, "__gnat_reraise_library_exception_if_any");
      begin
         Reraise_Library_Exception_If_Any;
      end;
   end finalize_library;

   procedure adafinal is
      procedure s_stalib_adafinal;
      pragma Import (C, s_stalib_adafinal, "system__standard_library__adafinal");

      procedure Runtime_Finalize;
      pragma Import (C, Runtime_Finalize, "__gnat_runtime_finalize");

   begin
      if not Is_Elaborated then
         return;
      end if;
      Is_Elaborated := False;
      Runtime_Finalize;
      s_stalib_adafinal;
   end adafinal;

   type No_Param_Proc is access procedure;

   procedure adainit is
      Main_Priority : Integer;
      pragma Import (C, Main_Priority, "__gl_main_priority");
      Time_Slice_Value : Integer;
      pragma Import (C, Time_Slice_Value, "__gl_time_slice_val");
      WC_Encoding : Character;
      pragma Import (C, WC_Encoding, "__gl_wc_encoding");
      Locking_Policy : Character;
      pragma Import (C, Locking_Policy, "__gl_locking_policy");
      Queuing_Policy : Character;
      pragma Import (C, Queuing_Policy, "__gl_queuing_policy");
      Task_Dispatching_Policy : Character;
      pragma Import (C, Task_Dispatching_Policy, "__gl_task_dispatching_policy");
      Priority_Specific_Dispatching : System.Address;
      pragma Import (C, Priority_Specific_Dispatching, "__gl_priority_specific_dispatching");
      Num_Specific_Dispatching : Integer;
      pragma Import (C, Num_Specific_Dispatching, "__gl_num_specific_dispatching");
      Main_CPU : Integer;
      pragma Import (C, Main_CPU, "__gl_main_cpu");
      Interrupt_States : System.Address;
      pragma Import (C, Interrupt_States, "__gl_interrupt_states");
      Num_Interrupt_States : Integer;
      pragma Import (C, Num_Interrupt_States, "__gl_num_interrupt_states");
      Unreserve_All_Interrupts : Integer;
      pragma Import (C, Unreserve_All_Interrupts, "__gl_unreserve_all_interrupts");
      Exception_Tracebacks : Integer;
      pragma Import (C, Exception_Tracebacks, "__gl_exception_tracebacks");
      Detect_Blocking : Integer;
      pragma Import (C, Detect_Blocking, "__gl_detect_blocking");
      Default_Stack_Size : Integer;
      pragma Import (C, Default_Stack_Size, "__gl_default_stack_size");
      Default_Secondary_Stack_Size : System.Parameters.Size_Type;
      pragma Import (C, Default_Secondary_Stack_Size, "__gnat_default_ss_size");
      Leap_Seconds_Support : Integer;
      pragma Import (C, Leap_Seconds_Support, "__gl_leap_seconds_support");
      Bind_Env_Addr : System.Address;
      pragma Import (C, Bind_Env_Addr, "__gl_bind_env_addr");

      procedure Runtime_Initialize (Install_Handler : Integer);
      pragma Import (C, Runtime_Initialize, "__gnat_runtime_initialize");

      Finalize_Library_Objects : No_Param_Proc;
      pragma Import (C, Finalize_Library_Objects, "__gnat_finalize_library_objects");
      Binder_Sec_Stacks_Count : Natural;
      pragma Import (Ada, Binder_Sec_Stacks_Count, "__gnat_binder_ss_count");
      Default_Sized_SS_Pool : System.Address;
      pragma Import (Ada, Default_Sized_SS_Pool, "__gnat_default_ss_pool");

   begin
      if Is_Elaborated then
         return;
      end if;
      Is_Elaborated := True;
      Main_Priority := -1;
      Time_Slice_Value := -1;
      WC_Encoding := 'b';
      Locking_Policy := ' ';
      Queuing_Policy := ' ';
      Task_Dispatching_Policy := ' ';
      System.Restrictions.Run_Time_Restrictions :=
        (Set =>
          (False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, True, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False),
         Value => (0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
         Violated =>
          (False, False, True, False, True, True, False, False, 
           True, False, False, True, True, True, True, False, 
           False, True, False, False, True, True, False, True, 
           True, False, True, True, True, True, False, True, 
           False, False, False, True, False, True, True, False, 
           True, True, True, True, False, True, False, True, 
           True, False, False, True, False, True, False, True, 
           False, True, False, True, False, True, True, True, 
           False, False, True, False, True, True, True, False, 
           True, True, False, True, True, True, True, False, 
           True, True, False, False, False, False, False, True, 
           True, False, True, False),
         Count => (0, 0, 0, 0, 0, 2, 1, 0, 6, 0),
         Unknown => (False, False, False, False, False, False, True, False, True, False));
      Priority_Specific_Dispatching :=
        Local_Priority_Specific_Dispatching'Address;
      Num_Specific_Dispatching := 0;
      Main_CPU := -1;
      Interrupt_States := Local_Interrupt_States'Address;
      Num_Interrupt_States := 0;
      Unreserve_All_Interrupts := 0;
      Exception_Tracebacks := 1;
      Detect_Blocking := 0;
      Default_Stack_Size := -1;
      Leap_Seconds_Support := 0;

      ada_main'Elab_Body;
      Default_Secondary_Stack_Size := System.Parameters.Runtime_Default_Sec_Stack_Size;
      Binder_Sec_Stacks_Count := 1;
      Default_Sized_SS_Pool := Sec_Default_Sized_Stacks'Address;

      Runtime_Initialize (1);

      Finalize_Library_Objects := finalize_library'access;

      System.Soft_Links'Elab_Spec;
      System.Exception_Table'Elab_Body;
      E023 := E023 + 1;
      Ada.Containers'Elab_Spec;
      E038 := E038 + 1;
      Ada.Io_Exceptions'Elab_Spec;
      E068 := E068 + 1;
      Ada.Strings'Elab_Spec;
      E053 := E053 + 1;
      Ada.Strings.Maps'Elab_Spec;
      E055 := E055 + 1;
      Ada.Strings.Maps.Constants'Elab_Spec;
      E059 := E059 + 1;
      Interfaces.C'Elab_Spec;
      E043 := E043 + 1;
      System.Exceptions'Elab_Spec;
      E025 := E025 + 1;
      System.Object_Reader'Elab_Spec;
      E079 := E079 + 1;
      System.Dwarf_Lines'Elab_Spec;
      E048 := E048 + 1;
      System.Os_Lib'Elab_Body;
      E073 := E073 + 1;
      System.Soft_Links.Initialize'Elab_Body;
      E019 := E019 + 1;
      E011 := E011 + 1;
      System.Traceback.Symbolic'Elab_Body;
      E037 := E037 + 1;
      Ada.Strings.Utf_Encoding'Elab_Spec;
      E257 := E257 + 1;
      Ada.Tags'Elab_Spec;
      Ada.Tags'Elab_Body;
      E097 := E097 + 1;
      Ada.Streams'Elab_Spec;
      E146 := E146 + 1;
      Gnat'Elab_Spec;
      E203 := E203 + 1;
      Interfaces.C.Strings'Elab_Spec;
      E284 := E284 + 1;
      System.File_Control_Block'Elab_Spec;
      E163 := E163 + 1;
      System.Finalization_Root'Elab_Spec;
      E148 := E148 + 1;
      Ada.Finalization'Elab_Spec;
      E144 := E144 + 1;
      System.File_Io'Elab_Body;
      E160 := E160 + 1;
      Ada.Streams.Stream_Io'Elab_Spec;
      E167 := E167 + 1;
      System.Storage_Pools'Elab_Spec;
      E150 := E150 + 1;
      System.Finalization_Masters'Elab_Spec;
      System.Finalization_Masters'Elab_Body;
      E141 := E141 + 1;
      System.Storage_Pools.Subpools'Elab_Spec;
      E139 := E139 + 1;
      Ada.Strings.Unbounded'Elab_Spec;
      E133 := E133 + 1;
      Ada.Strings.Wide_Wide_Maps'Elab_Spec;
      E278 := E278 + 1;
      Ada.Strings.Wide_Wide_Unbounded'Elab_Spec;
      E274 := E274 + 1;
      System.Task_Info'Elab_Spec;
      E224 := E224 + 1;
      System.Task_Primitives.Operations'Elab_Body;
      E218 := E218 + 1;
      System.Regpat'Elab_Spec;
      E588 := E588 + 1;
      Ada.Calendar'Elab_Spec;
      Ada.Calendar'Elab_Body;
      E107 := E107 + 1;
      Ada.Calendar.Delays'Elab_Body;
      E463 := E463 + 1;
      Ada.Calendar.Time_Zones'Elab_Spec;
      E113 := E113 + 1;
      Ada.Real_Time'Elab_Spec;
      Ada.Real_Time'Elab_Body;
      E528 := E528 + 1;
      Ada.Text_Io'Elab_Spec;
      Ada.Text_Io'Elab_Body;
      E202 := E202 + 1;
      Gnat.Calendar'Elab_Spec;
      E382 := E382 + 1;
      Gnat.Calendar.Time_Io'Elab_Spec;
      E385 := E385 + 1;
      Gnat.Directory_Operations'Elab_Spec;
      Gnat.Directory_Operations'Elab_Body;
      E345 := E345 + 1;
      System.Assertions'Elab_Spec;
      E208 := E208 + 1;
      System.Pool_Global'Elab_Spec;
      E174 := E174 + 1;
      System.Regexp'Elab_Spec;
      E165 := E165 + 1;
      Ada.Directories'Elab_Spec;
      Ada.Directories'Elab_Body;
      E105 := E105 + 1;
      Gnat.Command_Line'Elab_Spec;
      Gnat.Command_Line'Elab_Body;
      E583 := E583 + 1;
      System.Tasking.Initialization'Elab_Body;
      E483 := E483 + 1;
      System.Tasking.Protected_Objects'Elab_Body;
      E238 := E238 + 1;
      System.Tasking.Protected_Objects.Entries'Elab_Spec;
      E489 := E489 + 1;
      System.Tasking.Queuing'Elab_Body;
      E487 := E487 + 1;
      System.Tasking.Stages'Elab_Body;
      E542 := E542 + 1;
      Unicode'Elab_Body;
      E357 := E357 + 1;
      Util.Beans.Objects'Elab_Spec;
      Util.Beans.Basic'Elab_Spec;
      E272 := E272 + 1;
      Util.Beans.Objects'Elab_Body;
      E253 := E253 + 1;
      Util.Log'Elab_Spec;
      E191 := E191 + 1;
      Util.Refs'Elab_Spec;
      E181 := E181 + 1;
      Util.Streams'Elab_Spec;
      E172 := E172 + 1;
      Util.Streams.Buffered'Elab_Spec;
      Util.Streams.Buffered'Elab_Body;
      E336 := E336 + 1;
      Util.Strings'Elab_Spec;
      Util.Strings'Elab_Body;
      E244 := E244 + 1;
      Ahven'Elab_Spec;
      E524 := E524 + 1;
      Ahven.Astrings'Elab_Body;
      E546 := E546 + 1;
      Ahven.Long_Astrings'Elab_Body;
      E530 := E530 + 1;
      Ahven.Listeners'Elab_Spec;
      Ahven.Listeners'Elab_Body;
      E548 := E548 + 1;
      E550 := E550 + 1;
      Ahven.Results'Elab_Spec;
      E565 := E565 + 1;
      Ahven.Temporary_Output'Elab_Spec;
      E567 := E567 + 1;
      Ahven.Listeners.Basic'Elab_Spec;
      Ahven.Listeners.Basic'Elab_Body;
      E563 := E563 + 1;
      E579 := E579 + 1;
      E353 := E353 + 1;
      Sax.Pointers'Elab_Spec;
      Sax.Pointers'Elab_Body;
      E355 := E355 + 1;
      Unicode.Ccs'Elab_Spec;
      E370 := E370 + 1;
      E402 := E402 + 1;
      E404 := E404 + 1;
      E409 := E409 + 1;
      E412 := E412 + 1;
      E414 := E414 + 1;
      E416 := E416 + 1;
      E421 := E421 + 1;
      Unicode.Ces'Elab_Spec;
      E366 := E366 + 1;
      Sax.Symbols'Elab_Spec;
      Sax.Symbols'Elab_Body;
      E348 := E348 + 1;
      E343 := E343 + 1;
      Sax.Exceptions'Elab_Spec;
      Sax.Exceptions'Elab_Body;
      E341 := E341 + 1;
      E372 := E372 + 1;
      E424 := E424 + 1;
      E426 := E426 + 1;
      E368 := E368 + 1;
      Sax.Models'Elab_Spec;
      E430 := E430 + 1;
      Sax.Attributes'Elab_Spec;
      Sax.Attributes'Elab_Body;
      E428 := E428 + 1;
      Sax.Utils'Elab_Spec;
      Sax.Utils'Elab_Body;
      E439 := E439 + 1;
      E400 := E400 + 1;
      Input_Sources'Elab_Spec;
      Input_Sources'Elab_Body;
      E398 := E398 + 1;
      Input_Sources.File'Elab_Spec;
      Input_Sources.File'Elab_Body;
      E435 := E435 + 1;
      Input_Sources.Strings'Elab_Spec;
      Input_Sources.Strings'Elab_Body;
      E437 := E437 + 1;
      Sax.Readers'Elab_Spec;
      Sax.Readers'Elab_Body;
      E433 := E433 + 1;
      E557 := E557 + 1;
      Util.Beans.Objects.Datasets'Elab_Spec;
      Util.Beans.Objects.Datasets'Elab_Body;
      E597 := E597 + 1;
      Util.Beans.Objects.Maps'Elab_Spec;
      Util.Beans.Objects.Maps'Elab_Body;
      E280 := E280 + 1;
      E374 := E374 + 1;
      E378 := E378 + 1;
      Util.Nullables'Elab_Spec;
      E179 := E179 + 1;
      Util.Beans.Objects.Time'Elab_Body;
      E467 := E467 + 1;
      Util.Serialize.Contexts'Elab_Spec;
      Util.Serialize.Contexts'Elab_Body;
      E332 := E332 + 1;
      Util.Streams.Files'Elab_Spec;
      Util.Streams.Files'Elab_Body;
      E178 := E178 + 1;
      ADO'ELAB_SPEC;
      ADO'ELAB_BODY;
      E103 := E103 + 1;
      ADO.C'ELAB_SPEC;
      ADO.C'ELAB_BODY;
      E493 := E493 + 1;
      ADO.DIALECTS'ELAB_SPEC;
      ADO.DIALECTS'ELAB_BODY;
      E449 := E449 + 1;
      ADO.UTILS'ELAB_SPEC;
      E453 := E453 + 1;
      Util.Streams.Texts'Elab_Spec;
      Util.Streams.Texts'Elab_Body;
      E380 := E380 + 1;
      Util.Measures'Elab_Spec;
      Util.Measures'Elab_Body;
      E544 := E544 + 1;
      Util.Strings.Maps'Elab_Spec;
      E291 := E291 + 1;
      Util.Strings.Vectors'Elab_Spec;
      E293 := E293 + 1;
      E282 := E282 + 1;
      Util.Properties'Elab_Spec;
      Util.Properties'Elab_Body;
      E248 := E248 + 1;
      E297 := E297 + 1;
      Util.Log.Appenders'Elab_Spec;
      Util.Log.Loggers'Elab_Spec;
      Util.Log.Loggers'Elab_Body;
      E193 := E193 + 1;
      Util.Log.Appenders'Elab_Body;
      E246 := E246 + 1;
      ADO.CONFIGS'ELAB_SPEC;
      ADO.CONFIGS'ELAB_BODY;
      E189 := E189 + 1;
      ADO.PARAMETERS'ELAB_SPEC;
      ADO.PARAMETERS'ELAB_BODY;
      E451 := E451 + 1;
      ADO.CACHES'ELAB_SPEC;
      ADO.CACHES'ELAB_BODY;
      E459 := E459 + 1;
      ADO.SCHEMAS'ELAB_SPEC;
      ADO.SCHEMAS'ELAB_BODY;
      E311 := E311 + 1;
      ADO.SQL'ELAB_SPEC;
      ADO.SQL'ELAB_BODY;
      E447 := E447 + 1;
      Ahven.Framework'Elab_Spec;
      Ahven.Framework'Elab_Body;
      E526 := E526 + 1;
      Ahven.Parameters'Elab_Spec;
      E575 := E575 + 1;
      E571 := E571 + 1;
      E577 := E577 + 1;
      E569 := E569 + 1;
      Util.Xunit'Elab_Spec;
      E592 := E592 + 1;
      Util.Tests'Elab_Spec;
      Util.Tests'Elab_Body;
      E581 := E581 + 1;
      Util.Xunit'Elab_Body;
      E561 := E561 + 1;
      Util.Serialize.Io'Elab_Spec;
      Util.Serialize.Io'Elab_Body;
      E334 := E334 + 1;
      Util.Serialize.Io.Xml'Elab_Spec;
      Util.Serialize.Io.Xml'Elab_Body;
      E338 := E338 + 1;
      Util.Serialize.Mappers'Elab_Spec;
      Util.Serialize.Mappers'Elab_Body;
      E441 := E441 + 1;
      E445 := E445 + 1;
      Util.Systems.Dlls'Elab_Spec;
      E308 := E308 + 1;
      ADO.OBJECTS'ELAB_SPEC;
      ADO.OBJECTS.CACHE'ELAB_SPEC;
      ADO.OBJECTS.CACHE'ELAB_BODY;
      E475 := E475 + 1;
      ADO.QUERIES'ELAB_SPEC;
      ADO.STATEMENTS'ELAB_SPEC;
      ADO.STATEMENTS'ELAB_BODY;
      E315 := E315 + 1;
      ADO.CONNECTIONS'ELAB_SPEC;
      ADO.CONNECTIONS'ELAB_BODY;
      E305 := E305 + 1;
      ADO.QUERIES.LOADERS'ELAB_BODY;
      E329 := E329 + 1;
      ADO.QUERIES'ELAB_BODY;
      E327 := E327 + 1;
      ADO.SESSIONS'ELAB_SPEC;
      ADO.AUDITS'ELAB_SPEC;
      ADO.AUDITS'ELAB_BODY;
      E465 := E465 + 1;
      ADO.MODEL'ELAB_SPEC;
      ADO.MODEL'ELAB_BODY;
      E457 := E457 + 1;
      ADO.SCHEMAS.ENTITIES'ELAB_SPEC;
      ADO.SCHEMAS.ENTITIES'ELAB_BODY;
      E455 := E455 + 1;
      ADO.SEQUENCES'ELAB_SPEC;
      ADO.SEQUENCES.HILO'ELAB_SPEC;
      ADO.SEQUENCES.HILO'ELAB_BODY;
      E461 := E461 + 1;
      ADO.SESSIONS.SOURCES'ELAB_SPEC;
      ADO.SESSIONS.SOURCES'ELAB_BODY;
      E471 := E471 + 1;
      ADO.SESSIONS.FACTORY'ELAB_SPEC;
      ADO.SESSIONS.FACTORY'ELAB_BODY;
      E325 := E325 + 1;
      ADO.OBJECTS'ELAB_BODY;
      E317 := E317 + 1;
      ADO.SEQUENCES'ELAB_BODY;
      E323 := E323 + 1;
      E473 := E473 + 1;
      ADO.SESSIONS'ELAB_BODY;
      E321 := E321 + 1;
      E595 := E595 + 1;
      E621 := E621 + 1;
      E495 := E495 + 1;
      E522 := E522 + 1;
      ADO.STATEMENTS.MYSQL'ELAB_SPEC;
      ADO.STATEMENTS.MYSQL'ELAB_BODY;
      E497 := E497 + 1;
      Regtests'Elab_Body;
      E552 := E552 + 1;
      Regtests.Audits.Model'Elab_Spec;
      Regtests.Audits.Model'Elab_Body;
      E555 := E555 + 1;
      Regtests.Images.Model'Elab_Spec;
      Regtests.Images.Model'Elab_Body;
      E630 := E630 + 1;
      Regtests.Simple.Model'Elab_Spec;
      Regtests.Simple.Model'Elab_Body;
      E602 := E602 + 1;
      Regtests.Comments'Elab_Spec;
      Regtests.Comments'Elab_Body;
      E611 := E611 + 1;
      Regtests.Statements.Model'Elab_Spec;
      Regtests.Statements.Model'Elab_Body;
      E605 := E605 + 1;
      Util.Processes'Elab_Spec;
      Util.Streams.Raw'Elab_Spec;
      Util.Streams.Raw'Elab_Body;
      E510 := E510 + 1;
      Util.Processes.Os'Elab_Spec;
      Util.Processes.Os'Elab_Body;
      E508 := E508 + 1;
      Util.Processes'Elab_Body;
      E506 := E506 + 1;
      Util.Streams.Pipes'Elab_Spec;
      Util.Streams.Pipes'Elab_Body;
      E516 := E516 + 1;
      E514 := E514 + 1;
      ADO.CONNECTIONS.MYSQL'ELAB_SPEC;
      ADO.CONNECTIONS.MYSQL'ELAB_BODY;
      E477 := E477 + 1;
      E187 := E187 + 1;
      E559 := E559 + 1;
      ADO.AUDITS.TESTS'ELAB_SPEC;
      ADO.AUDITS.TESTS'ELAB_BODY;
      E520 := E520 + 1;
      ADO.DATASETS.TESTS'ELAB_SPEC;
      ADO.DATASETS.TESTS'ELAB_BODY;
      E599 := E599 + 1;
      ADO.DRIVERS.TESTS'ELAB_SPEC;
      ADO.DRIVERS.TESTS'ELAB_BODY;
      E607 := E607 + 1;
      ADO.OBJECTS.TESTS'ELAB_SPEC;
      ADO.OBJECTS.TESTS'ELAB_BODY;
      E609 := E609 + 1;
      ADO.PARAMETERS.TESTS'ELAB_SPEC;
      ADO.PARAMETERS.TESTS'ELAB_BODY;
      E613 := E613 + 1;
      ADO.QUERIES.TESTS'ELAB_SPEC;
      ADO.QUERIES.TESTS'ELAB_BODY;
      E617 := E617 + 1;
      ADO.SCHEMAS.TESTS'ELAB_SPEC;
      ADO.SCHEMAS.TESTS'ELAB_BODY;
      E619 := E619 + 1;
      ADO.SEQUENCES.TESTS'ELAB_SPEC;
      ADO.SEQUENCES.TESTS'ELAB_BODY;
      E623 := E623 + 1;
      ADO.STATEMENTS.TESTS'ELAB_SPEC;
      ADO.STATEMENTS.TESTS'ELAB_BODY;
      E625 := E625 + 1;
      ADO.TESTS'ELAB_SPEC;
      ADO.TESTS'ELAB_BODY;
      E627 := E627 + 1;
      ADO.TESTSUITE'ELAB_BODY;
      E518 := E518 + 1;
   end adainit;

   procedure Ada_Main_Program;
   pragma Import (Ada, Ada_Main_Program, "_ada_ado_harness");

   function main
     (argc : Integer;
      argv : System.Address;
      envp : System.Address)
      return Integer
   is
      procedure Initialize (Addr : System.Address);
      pragma Import (C, Initialize, "__gnat_initialize");

      procedure Finalize;
      pragma Import (C, Finalize, "__gnat_finalize");
      SEH : aliased array (1 .. 2) of Integer;

      Ensure_Reference : aliased System.Address := Ada_Main_Program_Name'Address;
      pragma Volatile (Ensure_Reference);

   begin
      gnat_argc := argc;
      gnat_argv := argv;
      gnat_envp := envp;

      Initialize (SEH'Address);
      adainit;
      Ada_Main_Program;
      adafinal;
      Finalize;
      return (gnat_exit_status);
   end;

--  BEGIN Object file/option list
   --   /media/scada/SCADA/Instalasi TM1000/instalasi/ada-ado/obj/regtests.o
   --   /media/scada/SCADA/Instalasi TM1000/instalasi/ada-ado/obj/regtests-audits.o
   --   /media/scada/SCADA/Instalasi TM1000/instalasi/ada-ado/obj/regtests-audits-model.o
   --   /media/scada/SCADA/Instalasi TM1000/instalasi/ada-ado/obj/regtests-images.o
   --   /media/scada/SCADA/Instalasi TM1000/instalasi/ada-ado/obj/regtests-images-model.o
   --   /media/scada/SCADA/Instalasi TM1000/instalasi/ada-ado/obj/regtests-simple.o
   --   /media/scada/SCADA/Instalasi TM1000/instalasi/ada-ado/obj/regtests-simple-model.o
   --   /media/scada/SCADA/Instalasi TM1000/instalasi/ada-ado/obj/regtests-comments.o
   --   /media/scada/SCADA/Instalasi TM1000/instalasi/ada-ado/obj/regtests-statements.o
   --   /media/scada/SCADA/Instalasi TM1000/instalasi/ada-ado/obj/regtests-statements-model.o
   --   /media/scada/SCADA/Instalasi TM1000/instalasi/ada-ado/obj/ado-audits-tests.o
   --   /media/scada/SCADA/Instalasi TM1000/instalasi/ada-ado/obj/ado-datasets-tests.o
   --   /media/scada/SCADA/Instalasi TM1000/instalasi/ada-ado/obj/ado-drivers-tests.o
   --   /media/scada/SCADA/Instalasi TM1000/instalasi/ada-ado/obj/ado-objects-tests.o
   --   /media/scada/SCADA/Instalasi TM1000/instalasi/ada-ado/obj/ado-parameters-tests.o
   --   /media/scada/SCADA/Instalasi TM1000/instalasi/ada-ado/obj/ado-queries-tests.o
   --   /media/scada/SCADA/Instalasi TM1000/instalasi/ada-ado/obj/ado-schemas-tests.o
   --   /media/scada/SCADA/Instalasi TM1000/instalasi/ada-ado/obj/ado-sequences-tests.o
   --   /media/scada/SCADA/Instalasi TM1000/instalasi/ada-ado/obj/ado-statements-tests.o
   --   /media/scada/SCADA/Instalasi TM1000/instalasi/ada-ado/obj/ado-tests.o
   --   /media/scada/SCADA/Instalasi TM1000/instalasi/ada-ado/obj/ado-testsuite.o
   --   /media/scada/SCADA/Instalasi TM1000/instalasi/ada-ado/obj/ado_harness.o
   --   -L/media/scada/SCADA/Instalasi TM1000/instalasi/ada-ado/obj/
   --   -L/media/scada/SCADA/Instalasi TM1000/instalasi/ada-ado/obj/
   --   -L/opt/GNAT/2019/lib/utilada_sys.static/
   --   -L/opt/GNAT/2019/lib/utilada_core.static/
   --   -L/opt/GNAT/2019/lib/utilada_base.static/
   --   -L/opt/GNAT/2019/lib/utilada_unit.static/
   --   -L/media/scada/SCADA/Instalasi TM1000/instalasi/ada-ado/lib/ado_all/static/
   --   -L/media/scada/SCADA/Instalasi TM1000/instalasi/ada-ado/lib/ado/static/
   --   -L/opt/GNAT/2019/lib/utilada_xml.static/
   --   -L/opt/GNAT/2019/lib/xmlada/xmlada_input.static/
   --   -L/opt/GNAT/2019/lib/xmlada/xmlada_unicode.static/
   --   -L/opt/GNAT/2019/lib/xmlada/xmlada_sax.static/
   --   -L/media/scada/SCADA/Instalasi TM1000/instalasi/ada-ado/lib/ado_mysql/static/
   --   -L/opt/GNAT/2019/lib/gcc/x86_64-pc-linux-gnu/8.3.1/adalib/
   --   -static
   --   -lmariadb
   --   -ldl
   --   -lgnarl
   --   -lgnat
   --   -lrt
   --   -lpthread
   --   -ldl
--  END Object file/option list   

end ada_main;
