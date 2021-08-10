pragma Warnings (Off);
pragma Ada_95;
pragma Source_File_Name (ada_main, Spec_File_Name => "b__util_harness.ads");
pragma Source_File_Name (ada_main, Body_File_Name => "b__util_harness.adb");
pragma Suppress (Overflow_Check);

with System.Restrictions;
with Ada.Exceptions;

package body ada_main is

   E077 : Short_Integer; pragma Import (Ada, E077, "system__os_lib_E");
   E015 : Short_Integer; pragma Import (Ada, E015, "system__soft_links_E");
   E027 : Short_Integer; pragma Import (Ada, E027, "system__exception_table_E");
   E042 : Short_Integer; pragma Import (Ada, E042, "ada__containers_E");
   E072 : Short_Integer; pragma Import (Ada, E072, "ada__io_exceptions_E");
   E057 : Short_Integer; pragma Import (Ada, E057, "ada__strings_E");
   E059 : Short_Integer; pragma Import (Ada, E059, "ada__strings__maps_E");
   E063 : Short_Integer; pragma Import (Ada, E063, "ada__strings__maps__constants_E");
   E047 : Short_Integer; pragma Import (Ada, E047, "interfaces__c_E");
   E029 : Short_Integer; pragma Import (Ada, E029, "system__exceptions_E");
   E083 : Short_Integer; pragma Import (Ada, E083, "system__object_reader_E");
   E052 : Short_Integer; pragma Import (Ada, E052, "system__dwarf_lines_E");
   E023 : Short_Integer; pragma Import (Ada, E023, "system__soft_links__initialize_E");
   E041 : Short_Integer; pragma Import (Ada, E041, "system__traceback__symbolic_E");
   E591 : Short_Integer; pragma Import (Ada, E591, "ada__numerics_E");
   E181 : Short_Integer; pragma Import (Ada, E181, "ada__strings__utf_encoding_E");
   E127 : Short_Integer; pragma Import (Ada, E127, "ada__tags_E");
   E144 : Short_Integer; pragma Import (Ada, E144, "ada__streams_E");
   E244 : Short_Integer; pragma Import (Ada, E244, "gnat_E");
   E228 : Short_Integer; pragma Import (Ada, E228, "interfaces__c__strings_E");
   E161 : Short_Integer; pragma Import (Ada, E161, "system__file_control_block_E");
   E146 : Short_Integer; pragma Import (Ada, E146, "system__finalization_root_E");
   E142 : Short_Integer; pragma Import (Ada, E142, "ada__finalization_E");
   E158 : Short_Integer; pragma Import (Ada, E158, "system__file_io_E");
   E224 : Short_Integer; pragma Import (Ada, E224, "ada__streams__stream_io_E");
   E148 : Short_Integer; pragma Import (Ada, E148, "system__storage_pools_E");
   E139 : Short_Integer; pragma Import (Ada, E139, "system__finalization_masters_E");
   E137 : Short_Integer; pragma Import (Ada, E137, "system__storage_pools__subpools_E");
   E125 : Short_Integer; pragma Import (Ada, E125, "ada__strings__unbounded_E");
   E204 : Short_Integer; pragma Import (Ada, E204, "ada__strings__wide_wide_maps_E");
   E200 : Short_Integer; pragma Import (Ada, E200, "ada__strings__wide_wide_unbounded_E");
   E317 : Short_Integer; pragma Import (Ada, E317, "system__task_info_E");
   E311 : Short_Integer; pragma Import (Ada, E311, "system__task_primitives__operations_E");
   E254 : Short_Integer; pragma Import (Ada, E254, "system__regpat_E");
   E008 : Short_Integer; pragma Import (Ada, E008, "ada__calendar_E");
   E657 : Short_Integer; pragma Import (Ada, E657, "ada__calendar__delays_E");
   E105 : Short_Integer; pragma Import (Ada, E105, "ada__calendar__time_zones_E");
   E303 : Short_Integer; pragma Import (Ada, E303, "ada__real_time_E");
   E170 : Short_Integer; pragma Import (Ada, E170, "ada__text_io_E");
   E385 : Short_Integer; pragma Import (Ada, E385, "gnat__calendar_E");
   E388 : Short_Integer; pragma Import (Ada, E388, "gnat__calendar__time_io_E");
   E248 : Short_Integer; pragma Import (Ada, E248, "gnat__directory_operations_E");
   E512 : Short_Integer; pragma Import (Ada, E512, "gnat__secure_hashes_E");
   E695 : Short_Integer; pragma Import (Ada, E695, "gnat__secure_hashes__md5_E");
   E693 : Short_Integer; pragma Import (Ada, E693, "gnat__md5_E");
   E729 : Short_Integer; pragma Import (Ada, E729, "gnat__secure_hashes__sha1_E");
   E519 : Short_Integer; pragma Import (Ada, E519, "gnat__secure_hashes__sha2_common_E");
   E514 : Short_Integer; pragma Import (Ada, E514, "gnat__secure_hashes__sha2_32_E");
   E727 : Short_Integer; pragma Import (Ada, E727, "gnat__sha1_E");
   E510 : Short_Integer; pragma Import (Ada, E510, "gnat__sha256_E");
   E218 : Short_Integer; pragma Import (Ada, E218, "system__assertions_E");
   E172 : Short_Integer; pragma Import (Ada, E172, "system__pool_global_E");
   E664 : Short_Integer; pragma Import (Ada, E664, "system__pool_size_E");
   E652 : Short_Integer; pragma Import (Ada, E652, "gnat__sockets_E");
   E662 : Short_Integer; pragma Import (Ada, E662, "gnat__sockets__thin_common_E");
   E655 : Short_Integer; pragma Import (Ada, E655, "gnat__sockets__thin_E");
   E609 : Short_Integer; pragma Import (Ada, E609, "system__random_seed_E");
   E163 : Short_Integer; pragma Import (Ada, E163, "system__regexp_E");
   E006 : Short_Integer; pragma Import (Ada, E006, "ada__directories_E");
   E246 : Short_Integer; pragma Import (Ada, E246, "gnat__command_line_E");
   E337 : Short_Integer; pragma Import (Ada, E337, "system__tasking__initialization_E");
   E325 : Short_Integer; pragma Import (Ada, E325, "system__tasking__protected_objects_E");
   E341 : Short_Integer; pragma Import (Ada, E341, "system__tasking__protected_objects__entries_E");
   E345 : Short_Integer; pragma Import (Ada, E345, "system__tasking__queuing_E");
   E349 : Short_Integer; pragma Import (Ada, E349, "system__tasking__stages_E");
   E669 : Short_Integer; pragma Import (Ada, E669, "aws__default_E");
   E878 : Short_Integer; pragma Import (Ada, E878, "unicode_E");
   E177 : Short_Integer; pragma Import (Ada, E177, "util__beans__objects_E");
   E198 : Short_Integer; pragma Import (Ada, E198, "util__beans__basic_E");
   E351 : Short_Integer; pragma Import (Ada, E351, "util__log_E");
   E392 : Short_Integer; pragma Import (Ada, E392, "util__streams_E");
   E486 : Short_Integer; pragma Import (Ada, E486, "util__encoders_E");
   E488 : Short_Integer; pragma Import (Ada, E488, "util__encoders__base16_E");
   E490 : Short_Integer; pragma Import (Ada, E490, "util__encoders__base64_E");
   E492 : Short_Integer; pragma Import (Ada, E492, "util__encoders__sha1_E");
   E504 : Short_Integer; pragma Import (Ada, E504, "util__encoders__hmac__sha1_E");
   E230 : Short_Integer; pragma Import (Ada, E230, "util__strings_E");
   E275 : Short_Integer; pragma Import (Ada, E275, "ahven_E");
   E279 : Short_Integer; pragma Import (Ada, E279, "ahven__astrings_E");
   E278 : Short_Integer; pragma Import (Ada, E278, "ahven__astrings_E");
   E287 : Short_Integer; pragma Import (Ada, E287, "ahven__long_astrings_E");
   E286 : Short_Integer; pragma Import (Ada, E286, "ahven__long_astrings_E");
   E285 : Short_Integer; pragma Import (Ada, E285, "ahven__listeners_E");
   E293 : Short_Integer; pragma Import (Ada, E293, "ahven__slist_E");
   E291 : Short_Integer; pragma Import (Ada, E291, "ahven__results_E");
   E295 : Short_Integer; pragma Import (Ada, E295, "ahven__temporary_output_E");
   E289 : Short_Integer; pragma Import (Ada, E289, "ahven__listeners__basic_E");
   E404 : Short_Integer; pragma Import (Ada, E404, "ahven_compat_E");
   E723 : Short_Integer; pragma Import (Ada, E723, "aws__containers__key_value_E");
   E687 : Short_Integer; pragma Import (Ada, E687, "aws__containers__string_vectors_E");
   E569 : Short_Integer; pragma Import (Ada, E569, "aws__containers__tables_E");
   E632 : Short_Integer; pragma Import (Ada, E632, "memory_streams_E");
   E874 : Short_Integer; pragma Import (Ada, E874, "sax__htable_E");
   E876 : Short_Integer; pragma Import (Ada, E876, "sax__pointers_E");
   E644 : Short_Integer; pragma Import (Ada, E644, "templates_parser_tasking_E");
   E889 : Short_Integer; pragma Import (Ada, E889, "unicode__ccs_E");
   E897 : Short_Integer; pragma Import (Ada, E897, "unicode__ccs__iso_8859_1_E");
   E899 : Short_Integer; pragma Import (Ada, E899, "unicode__ccs__iso_8859_15_E");
   E904 : Short_Integer; pragma Import (Ada, E904, "unicode__ccs__iso_8859_2_E");
   E907 : Short_Integer; pragma Import (Ada, E907, "unicode__ccs__iso_8859_3_E");
   E909 : Short_Integer; pragma Import (Ada, E909, "unicode__ccs__iso_8859_4_E");
   E911 : Short_Integer; pragma Import (Ada, E911, "unicode__ccs__windows_1251_E");
   E916 : Short_Integer; pragma Import (Ada, E916, "unicode__ccs__windows_1252_E");
   E885 : Short_Integer; pragma Import (Ada, E885, "unicode__ces_E");
   E872 : Short_Integer; pragma Import (Ada, E872, "sax__symbols_E");
   E870 : Short_Integer; pragma Import (Ada, E870, "sax__locators_E");
   E868 : Short_Integer; pragma Import (Ada, E868, "sax__exceptions_E");
   E891 : Short_Integer; pragma Import (Ada, E891, "unicode__ces__utf32_E");
   E919 : Short_Integer; pragma Import (Ada, E919, "unicode__ces__basic_8bit_E");
   E921 : Short_Integer; pragma Import (Ada, E921, "unicode__ces__utf16_E");
   E887 : Short_Integer; pragma Import (Ada, E887, "unicode__ces__utf8_E");
   E925 : Short_Integer; pragma Import (Ada, E925, "sax__models_E");
   E923 : Short_Integer; pragma Import (Ada, E923, "sax__attributes_E");
   E934 : Short_Integer; pragma Import (Ada, E934, "sax__utils_E");
   E895 : Short_Integer; pragma Import (Ada, E895, "unicode__encodings_E");
   E893 : Short_Integer; pragma Import (Ada, E893, "input_sources_E");
   E930 : Short_Integer; pragma Import (Ada, E930, "input_sources__file_E");
   E932 : Short_Integer; pragma Import (Ada, E932, "input_sources__strings_E");
   E928 : Short_Integer; pragma Import (Ada, E928, "sax__readers_E");
   E441 : Short_Integer; pragma Import (Ada, E441, "util__beans__basic__ranges_E");
   E409 : Short_Integer; pragma Import (Ada, E409, "util__beans__objects__datasets_E");
   E425 : Short_Integer; pragma Import (Ada, E425, "util__beans__objects__enums_E");
   E209 : Short_Integer; pragma Import (Ada, E209, "util__beans__objects__maps_E");
   E434 : Short_Integer; pragma Import (Ada, E434, "util__beans__objects__records_E");
   E436 : Short_Integer; pragma Import (Ada, E436, "util__beans__objects__vectors_E");
   E439 : Short_Integer; pragma Import (Ada, E439, "util__beans__ranges_E");
   E458 : Short_Integer; pragma Import (Ada, E458, "util__concurrent__arrays_E");
   E462 : Short_Integer; pragma Import (Ada, E462, "util__concurrent__fifos_E");
   E466 : Short_Integer; pragma Import (Ada, E466, "util__concurrent__sequence_queues_E");
   E468 : Short_Integer; pragma Import (Ada, E468, "util__dates_E");
   E476 : Short_Integer; pragma Import (Ada, E476, "util__dates__iso8601_E");
   E501 : Short_Integer; pragma Import (Ada, E501, "util__encoders__aes_E");
   E494 : Short_Integer; pragma Import (Ada, E494, "util__encoders__ecc_E");
   E521 : Short_Integer; pragma Import (Ada, E521, "util__encoders__kdf__pbkdf2_E");
   E508 : Short_Integer; pragma Import (Ada, E508, "util__encoders__sha256_E");
   E506 : Short_Integer; pragma Import (Ada, E506, "util__encoders__hmac__sha256_E");
   E527 : Short_Integer; pragma Import (Ada, E527, "util__events_E");
   E529 : Short_Integer; pragma Import (Ada, E529, "util__events__channels_E");
   E541 : Short_Integer; pragma Import (Ada, E541, "util__http_E");
   E801 : Short_Integer; pragma Import (Ada, E801, "util__listeners_E");
   E805 : Short_Integer; pragma Import (Ada, E805, "util__listeners__lifecycles_E");
   E807 : Short_Integer; pragma Import (Ada, E807, "util__listeners__observers_E");
   E815 : Short_Integer; pragma Import (Ada, E815, "util__mail_E");
   E430 : Short_Integer; pragma Import (Ada, E430, "util__nullables_E");
   E427 : Short_Integer; pragma Import (Ada, E427, "util__beans__objects__time_E");
   E968 : Short_Integer; pragma Import (Ada, E968, "util__perfect_hash_E");
   E938 : Short_Integer; pragma Import (Ada, E938, "util__serialize__contexts_E");
   E394 : Short_Integer; pragma Import (Ada, E394, "util__streams__buffered_E");
   E958 : Short_Integer; pragma Import (Ada, E958, "util__streams__buffered__encoders_E");
   E956 : Short_Integer; pragma Import (Ada, E956, "util__streams__aes_E");
   E959 : Short_Integer; pragma Import (Ada, E959, "util__streams__base64_E");
   E552 : Short_Integer; pragma Import (Ada, E552, "util__streams__files_E");
   E796 : Short_Integer; pragma Import (Ada, E796, "util__streams__sockets_E");
   E396 : Short_Integer; pragma Import (Ada, E396, "util__streams__texts_E");
   E381 : Short_Integer; pragma Import (Ada, E381, "util__measures_E");
   E361 : Short_Integer; pragma Import (Ada, E361, "util__strings__builders_E");
   E478 : Short_Integer; pragma Import (Ada, E478, "util__dates__rfc7231_E");
   E545 : Short_Integer; pragma Import (Ada, E545, "util__http__cookies_E");
   E379 : Short_Integer; pragma Import (Ada, E379, "util__strings__formats_E");
   E237 : Short_Integer; pragma Import (Ada, E237, "util__strings__maps_E");
   E239 : Short_Integer; pragma Import (Ada, E239, "util__strings__vectors_E");
   E445 : Short_Integer; pragma Import (Ada, E445, "util__commands_E");
   E452 : Short_Integer; pragma Import (Ada, E452, "util__commands__parsers_E");
   E454 : Short_Integer; pragma Import (Ada, E454, "util__commands__parsers__gnat_parser_E");
   E222 : Short_Integer; pragma Import (Ada, E222, "util__files_E");
   E794 : Short_Integer; pragma Import (Ada, E794, "util__http__tools_E");
   E166 : Short_Integer; pragma Import (Ada, E166, "util__properties_E");
   E472 : Short_Integer; pragma Import (Ada, E472, "util__dates__formats_E");
   E355 : Short_Integer; pragma Import (Ada, E355, "util__log__appenders_E");
   E375 : Short_Integer; pragma Import (Ada, E375, "util__log__appenders__factories_E");
   E367 : Short_Integer; pragma Import (Ada, E367, "util__log__appenders__formatter_E");
   E371 : Short_Integer; pragma Import (Ada, E371, "util__properties__discrete_E");
   E365 : Short_Integer; pragma Import (Ada, E365, "util__log__appenders__consoles_E");
   E377 : Short_Integer; pragma Import (Ada, E377, "util__log__appenders__files_E");
   E353 : Short_Integer; pragma Import (Ada, E353, "util__log__loggers_E");
   E301 : Short_Integer; pragma Import (Ada, E301, "ahven__framework_E");
   E400 : Short_Integer; pragma Import (Ada, E400, "ahven__parameters_E");
   E299 : Short_Integer; pragma Import (Ada, E299, "ahven__runner_E");
   E402 : Short_Integer; pragma Import (Ada, E402, "ahven__xml_runner_E");
   E297 : Short_Integer; pragma Import (Ada, E297, "ahven__text_runner_E");
   E273 : Short_Integer; pragma Import (Ada, E273, "util__assertions_E");
   E277 : Short_Integer; pragma Import (Ada, E277, "util__xunit_E");
   E241 : Short_Integer; pragma Import (Ada, E241, "util__tests_E");
   E450 : Short_Integer; pragma Import (Ada, E450, "util__commands__drivers_E");
   E533 : Short_Integer; pragma Import (Ada, E533, "util__events__timers_E");
   E480 : Short_Integer; pragma Import (Ada, E480, "util__properties__bundles_E");
   E550 : Short_Integer; pragma Import (Ada, E550, "util__serialize__io_E");
   E556 : Short_Integer; pragma Import (Ada, E556, "util__beans__objects__readers_E");
   E554 : Short_Integer; pragma Import (Ada, E554, "util__serialize__io__form_E");
   E543 : Short_Integer; pragma Import (Ada, E543, "util__http__clients_E");
   E839 : Short_Integer; pragma Import (Ada, E839, "util__properties__form_E");
   E845 : Short_Integer; pragma Import (Ada, E845, "util__serialize__io__json_E");
   E843 : Short_Integer; pragma Import (Ada, E843, "util__properties__json_E");
   E865 : Short_Integer; pragma Import (Ada, E865, "util__serialize__io__xml_E");
   E940 : Short_Integer; pragma Import (Ada, E940, "util__serialize__mappers_E");
   E942 : Short_Integer; pragma Import (Ada, E942, "util__serialize__mappers__record_mapper_E");
   E944 : Short_Integer; pragma Import (Ada, E944, "util__serialize__tools_E");
   E970 : Short_Integer; pragma Import (Ada, E970, "util__systems__dlls_E");
   E821 : Short_Integer; pragma Import (Ada, E821, "util__processes_E");
   E825 : Short_Integer; pragma Import (Ada, E825, "util__streams__raw_E");
   E823 : Short_Integer; pragma Import (Ada, E823, "util__processes__os_E");
   E835 : Short_Integer; pragma Import (Ada, E835, "util__streams__pipes_E");
   E833 : Short_Integer; pragma Import (Ada, E833, "util__processes__tools_E");
   E413 : Short_Integer; pragma Import (Ada, E413, "util__test_caller_E");
   E411 : Short_Integer; pragma Import (Ada, E411, "util__beans__objects__datasets__tests_E");
   E419 : Short_Integer; pragma Import (Ada, E419, "util__beans__objects__discrete_tests_E");
   E415 : Short_Integer; pragma Import (Ada, E415, "util__beans__objects__discretes_E");
   E432 : Short_Integer; pragma Import (Ada, E432, "util__beans__objects__record_tests_E");
   E438 : Short_Integer; pragma Import (Ada, E438, "util__beans__objects__tests_E");
   E443 : Short_Integer; pragma Import (Ada, E443, "util__beans__ranges__tests_E");
   E447 : Short_Integer; pragma Import (Ada, E447, "util__commands__tests_E");
   E456 : Short_Integer; pragma Import (Ada, E456, "util__concurrent__tests_E");
   E474 : Short_Integer; pragma Import (Ada, E474, "util__dates__formats__tests_E");
   E484 : Short_Integer; pragma Import (Ada, E484, "util__dates__tests_E");
   E496 : Short_Integer; pragma Import (Ada, E496, "util__encoders__ecc__tests_E");
   E499 : Short_Integer; pragma Import (Ada, E499, "util__encoders__kdf__tests_E");
   E523 : Short_Integer; pragma Import (Ada, E523, "util__encoders__tests_E");
   E531 : Short_Integer; pragma Import (Ada, E531, "util__events__channels__tests_E");
   E535 : Short_Integer; pragma Import (Ada, E535, "util__events__timers__tests_E");
   E539 : Short_Integer; pragma Import (Ada, E539, "util__files__tests_E");
   E800 : Short_Integer; pragma Import (Ada, E800, "util__http__cookies__tests_E");
   E803 : Short_Integer; pragma Import (Ada, E803, "util__listeners__tests_E");
   E811 : Short_Integer; pragma Import (Ada, E811, "util__locales__tests_E");
   E813 : Short_Integer; pragma Import (Ada, E813, "util__log__tests_E");
   E817 : Short_Integer; pragma Import (Ada, E817, "util__mail__tests_E");
   E819 : Short_Integer; pragma Import (Ada, E819, "util__nullables__tests_E");
   E831 : Short_Integer; pragma Import (Ada, E831, "util__processes__tests_E");
   E837 : Short_Integer; pragma Import (Ada, E837, "util__properties__bundles__tests_E");
   E841 : Short_Integer; pragma Import (Ada, E841, "util__properties__form__tests_E");
   E857 : Short_Integer; pragma Import (Ada, E857, "util__properties__json__tests_E");
   E859 : Short_Integer; pragma Import (Ada, E859, "util__properties__tests_E");
   E861 : Short_Integer; pragma Import (Ada, E861, "util__serialize__io__form__tests_E");
   E863 : Short_Integer; pragma Import (Ada, E863, "util__serialize__io__json__tests_E");
   E936 : Short_Integer; pragma Import (Ada, E936, "util__serialize__io__xml__tests_E");
   E946 : Short_Integer; pragma Import (Ada, E946, "util__serialize__tools__tests_E");
   E948 : Short_Integer; pragma Import (Ada, E948, "util__streams__buffered__tests_E");
   E950 : Short_Integer; pragma Import (Ada, E950, "util__streams__files__tests_E");
   E954 : Short_Integer; pragma Import (Ada, E954, "util__streams__tests_E");
   E961 : Short_Integer; pragma Import (Ada, E961, "util__streams__texts__tests_E");
   E963 : Short_Integer; pragma Import (Ada, E963, "util__strings__tests_E");
   E972 : Short_Integer; pragma Import (Ada, E972, "util__systems__dlls__tests_E");
   E974 : Short_Integer; pragma Import (Ada, E974, "util__systems__os__tests_E");
   E798 : Short_Integer; pragma Import (Ada, E798, "util__tests__servers_E");
   E792 : Short_Integer; pragma Import (Ada, E792, "util__http__clients__tests_E");
   E952 : Short_Integer; pragma Import (Ada, E952, "util__streams__sockets__tests_E");
   E976 : Short_Integer; pragma Import (Ada, E976, "util__texts__builders_tests_E");
   E624 : Short_Integer; pragma Import (Ada, E624, "zlib_E");
   E626 : Short_Integer; pragma Import (Ada, E626, "zlib__thin_E");
   E611 : Short_Integer; pragma Import (Ada, E611, "templates_parser_E");
   E638 : Short_Integer; pragma Import (Ada, E638, "templates_parser__input_E");
   E640 : Short_Integer; pragma Import (Ada, E640, "templates_parser__utils_E");
   E576 : Short_Integer; pragma Import (Ada, E576, "aws__utils_E");
   E616 : Short_Integer; pragma Import (Ada, E616, "aws__resources_E");
   E634 : Short_Integer; pragma Import (Ada, E634, "aws__resources__files_E");
   E620 : Short_Integer; pragma Import (Ada, E620, "aws__resources__streams_E");
   E636 : Short_Integer; pragma Import (Ada, E636, "aws__resources__streams__disk_E");
   E628 : Short_Integer; pragma Import (Ada, E628, "aws__resources__streams__memory_E");
   E618 : Short_Integer; pragma Import (Ada, E618, "aws__resources__embedded_E");
   E622 : Short_Integer; pragma Import (Ada, E622, "aws__resources__streams__zlib_E");
   E572 : Short_Integer; pragma Import (Ada, E572, "aws__net_E");
   E574 : Short_Integer; pragma Import (Ada, E574, "aws__net__log_E");
   E646 : Short_Integer; pragma Import (Ada, E646, "aws__net__poll_events_E");
   E650 : Short_Integer; pragma Import (Ada, E650, "aws__net__std_E");
   E648 : Short_Integer; pragma Import (Ada, E648, "aws__net__ssl_E");
   E748 : Short_Integer; pragma Import (Ada, E748, "aws__net__generic_sets_E");
   E770 : Short_Integer; pragma Import (Ada, E770, "aws__net__acceptors_E");
   E750 : Short_Integer; pragma Import (Ada, E750, "aws__net__memory_E");
   E783 : Short_Integer; pragma Import (Ada, E783, "aws__net__ssl__certificate_E");
   E785 : Short_Integer; pragma Import (Ada, E785, "aws__net__ssl__certificate__impl_E");
   E699 : Short_Integer; pragma Import (Ada, E699, "aws__resources__streams__disk__once_E");
   E673 : Short_Integer; pragma Import (Ada, E673, "aws__resources__streams__memory__zlib_E");
   E671 : Short_Integer; pragma Import (Ada, E671, "aws__translator_E");
   E691 : Short_Integer; pragma Import (Ada, E691, "aws__digest_E");
   E668 : Short_Integer; pragma Import (Ada, E668, "aws__net__buffered_E");
   E681 : Short_Integer; pragma Import (Ada, E681, "aws__config_E");
   E683 : Short_Integer; pragma Import (Ada, E683, "aws__config__ini_E");
   E685 : Short_Integer; pragma Import (Ada, E685, "aws__config__utils_E");
   E567 : Short_Integer; pragma Import (Ada, E567, "aws__headers_E");
   E675 : Short_Integer; pragma Import (Ada, E675, "aws__headers__values_E");
   E677 : Short_Integer; pragma Import (Ada, E677, "aws__messages_E");
   E679 : Short_Integer; pragma Import (Ada, E679, "aws__mime_E");
   E565 : Short_Integer; pragma Import (Ada, E565, "aws__attachments_E");
   E705 : Short_Integer; pragma Import (Ada, E705, "aws__config__set_E");
   E774 : Short_Integer; pragma Import (Ada, E774, "aws__services__transient_pages_E");
   E776 : Short_Integer; pragma Import (Ada, E776, "aws__services__transient_pages__control_E");
   E725 : Short_Integer; pragma Import (Ada, E725, "aws__utils__streams_E");
   E721 : Short_Integer; pragma Import (Ada, E721, "aws__session_E");
   E778 : Short_Integer; pragma Import (Ada, E778, "aws__session__control_E");
   E711 : Short_Integer; pragma Import (Ada, E711, "aws__parameters_E");
   E713 : Short_Integer; pragma Import (Ada, E713, "aws__url_E");
   E709 : Short_Integer; pragma Import (Ada, E709, "aws__status_E");
   E697 : Short_Integer; pragma Import (Ada, E697, "aws__response_E");
   E563 : Short_Integer; pragma Import (Ada, E563, "aws__client_E");
   E689 : Short_Integer; pragma Import (Ada, E689, "aws__client__http_utils_E");
   E707 : Short_Integer; pragma Import (Ada, E707, "aws__dispatchers_E");
   E731 : Short_Integer; pragma Import (Ada, E731, "aws__dispatchers__callback_E");
   E756 : Short_Integer; pragma Import (Ada, E756, "aws__hotplug_E");
   E766 : Short_Integer; pragma Import (Ada, E766, "aws__hotplug__get_status_E");
   E733 : Short_Integer; pragma Import (Ada, E733, "aws__log_E");
   E737 : Short_Integer; pragma Import (Ada, E737, "aws__net__websocket_E");
   E758 : Short_Integer; pragma Import (Ada, E758, "aws__net__websocket__handshake_error_E");
   E738 : Short_Integer; pragma Import (Ada, E738, "aws__net__websocket__protocol_E");
   E740 : Short_Integer; pragma Import (Ada, E740, "aws__net__websocket__protocol__draft76_E");
   E742 : Short_Integer; pragma Import (Ada, E742, "aws__net__websocket__protocol__rfc6455_E");
   E746 : Short_Integer; pragma Import (Ada, E746, "aws__net__websocket__registry_E");
   E752 : Short_Integer; pragma Import (Ada, E752, "aws__net__websocket__registry__control_E");
   E760 : Short_Integer; pragma Import (Ada, E760, "aws__net__websocket__registry__utils_E");
   E701 : Short_Integer; pragma Import (Ada, E701, "aws__response__set_E");
   E703 : Short_Integer; pragma Import (Ada, E703, "aws__server_E");
   E762 : Short_Integer; pragma Import (Ada, E762, "aws__server__get_status_E");
   E754 : Short_Integer; pragma Import (Ada, E754, "aws__server__http_utils_E");
   E768 : Short_Integer; pragma Import (Ada, E768, "aws__server__log_E");
   E764 : Short_Integer; pragma Import (Ada, E764, "aws__server__status_E");
   E744 : Short_Integer; pragma Import (Ada, E744, "aws__status__set_E");
   E780 : Short_Integer; pragma Import (Ada, E780, "aws__status__translate_set_E");
   E715 : Short_Integer; pragma Import (Ada, E715, "aws__url__raise_url_error_E");
   E717 : Short_Integer; pragma Import (Ada, E717, "aws__url__set_E");
   E787 : Short_Integer; pragma Import (Ada, E787, "aws__client__ext_E");
   E560 : Short_Integer; pragma Import (Ada, E560, "util__http__clients__aws_E");
   E790 : Short_Integer; pragma Import (Ada, E790, "util__http__clients__aws__tests_E");
   E789 : Short_Integer; pragma Import (Ada, E789, "util__http__clients__aws__tests_E");
   E407 : Short_Integer; pragma Import (Ada, E407, "util__testsuite_E");

   Sec_Default_Sized_Stacks : array (1 .. 1) of aliased System.Secondary_Stack.SS_Stack (System.Parameters.Runtime_Default_Sec_Stack_Size);

   Local_Priority_Specific_Dispatching : constant String := "";
   Local_Interrupt_States : constant String := "";

   Is_Elaborated : Boolean := False;

   procedure finalize_library is
   begin
      declare
         procedure F1;
         pragma Import (Ada, F1, "util__testsuite__finalize_body");
      begin
         E407 := E407 - 1;
         F1;
      end;
      declare
         procedure F2;
         pragma Import (Ada, F2, "util__http__clients__aws__finalize_body");
      begin
         E560 := E560 - 1;
         F2;
      end;
      declare
         procedure F3;
         pragma Import (Ada, F3, "util__http__clients__aws__finalize_spec");
      begin
         F3;
      end;
      E713 := E713 - 1;
      E563 := E563 - 1;
      declare
         procedure F4;
         pragma Import (Ada, F4, "aws__server__finalize_body");
      begin
         E703 := E703 - 1;
         F4;
      end;
      declare
         procedure F5;
         pragma Import (Ada, F5, "aws__net__websocket__finalize_body");
      begin
         E737 := E737 - 1;
         F5;
      end;
      E711 := E711 - 1;
      declare
         procedure F6;
         pragma Import (Ada, F6, "aws__server__finalize_spec");
      begin
         F6;
      end;
      E697 := E697 - 1;
      declare
         procedure F7;
         pragma Import (Ada, F7, "aws__net__websocket__registry__finalize_body");
      begin
         E746 := E746 - 1;
         F7;
      end;
      E742 := E742 - 1;
      declare
         procedure F8;
         pragma Import (Ada, F8, "aws__net__websocket__protocol__rfc6455__finalize_spec");
      begin
         F8;
      end;
      E740 := E740 - 1;
      declare
         procedure F9;
         pragma Import (Ada, F9, "aws__net__websocket__protocol__draft76__finalize_spec");
      begin
         F9;
      end;
      declare
         procedure F10;
         pragma Import (Ada, F10, "aws__net__websocket__protocol__finalize_spec");
      begin
         E738 := E738 - 1;
         F10;
      end;
      E758 := E758 - 1;
      declare
         procedure F11;
         pragma Import (Ada, F11, "aws__net__websocket__handshake_error__finalize_spec");
      begin
         F11;
      end;
      declare
         procedure F12;
         pragma Import (Ada, F12, "aws__net__websocket__finalize_spec");
      begin
         F12;
      end;
      E733 := E733 - 1;
      declare
         procedure F13;
         pragma Import (Ada, F13, "aws__log__finalize_spec");
      begin
         F13;
      end;
      E756 := E756 - 1;
      declare
         procedure F14;
         pragma Import (Ada, F14, "aws__hotplug__finalize_spec");
      begin
         F14;
      end;
      E731 := E731 - 1;
      declare
         procedure F15;
         pragma Import (Ada, F15, "aws__dispatchers__callback__finalize_spec");
      begin
         F15;
      end;
      E707 := E707 - 1;
      declare
         procedure F16;
         pragma Import (Ada, F16, "aws__dispatchers__finalize_spec");
      begin
         F16;
      end;
      declare
         procedure F17;
         pragma Import (Ada, F17, "aws__client__finalize_spec");
      begin
         F17;
      end;
      declare
         procedure F18;
         pragma Import (Ada, F18, "aws__response__finalize_spec");
      begin
         F18;
      end;
      E709 := E709 - 1;
      declare
         procedure F19;
         pragma Import (Ada, F19, "aws__status__finalize_spec");
      begin
         F19;
      end;
      declare
         procedure F20;
         pragma Import (Ada, F20, "aws__url__finalize_spec");
      begin
         F20;
      end;
      declare
         procedure F21;
         pragma Import (Ada, F21, "aws__parameters__finalize_spec");
      begin
         F21;
      end;
      declare
         procedure F22;
         pragma Import (Ada, F22, "aws__session__finalize_body");
      begin
         E721 := E721 - 1;
         F22;
      end;
      declare
         procedure F23;
         pragma Import (Ada, F23, "aws__session__finalize_spec");
      begin
         F23;
      end;
      E725 := E725 - 1;
      declare
         procedure F24;
         pragma Import (Ada, F24, "aws__utils__streams__finalize_spec");
      begin
         F24;
      end;
      declare
         procedure F25;
         pragma Import (Ada, F25, "aws__services__transient_pages__finalize_body");
      begin
         E774 := E774 - 1;
         F25;
      end;
      declare
         procedure F26;
         pragma Import (Ada, F26, "aws__services__transient_pages__finalize_spec");
      begin
         F26;
      end;
      declare
         procedure F27;
         pragma Import (Ada, F27, "aws__attachments__finalize_body");
      begin
         E565 := E565 - 1;
         F27;
      end;
      declare
         procedure F28;
         pragma Import (Ada, F28, "aws__attachments__finalize_spec");
      begin
         F28;
      end;
      declare
         procedure F29;
         pragma Import (Ada, F29, "aws__mime__finalize_body");
      begin
         E679 := E679 - 1;
         F29;
      end;
      E677 := E677 - 1;
      declare
         procedure F30;
         pragma Import (Ada, F30, "aws__messages__finalize_spec");
      begin
         F30;
      end;
      E567 := E567 - 1;
      declare
         procedure F31;
         pragma Import (Ada, F31, "aws__headers__finalize_spec");
      begin
         F31;
      end;
      declare
         procedure F32;
         pragma Import (Ada, F32, "aws__config__finalize_body");
      begin
         E681 := E681 - 1;
         F32;
      end;
      declare
         procedure F33;
         pragma Import (Ada, F33, "aws__config__finalize_spec");
      begin
         F33;
      end;
      E673 := E673 - 1;
      declare
         procedure F34;
         pragma Import (Ada, F34, "aws__resources__streams__memory__zlib__finalize_spec");
      begin
         F34;
      end;
      E699 := E699 - 1;
      declare
         procedure F35;
         pragma Import (Ada, F35, "aws__resources__streams__disk__once__finalize_spec");
      begin
         F35;
      end;
      E783 := E783 - 1;
      declare
         procedure F36;
         pragma Import (Ada, F36, "aws__net__ssl__certificate__finalize_spec");
      begin
         F36;
      end;
      declare
         procedure F37;
         pragma Import (Ada, F37, "aws__net__memory__finalize_body");
      begin
         E750 := E750 - 1;
         F37;
      end;
      declare
         procedure F38;
         pragma Import (Ada, F38, "aws__net__memory__finalize_spec");
      begin
         F38;
      end;
      E770 := E770 - 1;
      declare
         procedure F39;
         pragma Import (Ada, F39, "aws__net__acceptors__finalize_spec");
      begin
         F39;
      end;
      E572 := E572 - 1;
      E648 := E648 - 1;
      declare
         procedure F40;
         pragma Import (Ada, F40, "aws__net__ssl__finalize_spec");
      begin
         F40;
      end;
      E650 := E650 - 1;
      declare
         procedure F41;
         pragma Import (Ada, F41, "aws__net__std__finalize_spec");
      begin
         F41;
      end;
      E646 := E646 - 1;
      declare
         procedure F42;
         pragma Import (Ada, F42, "aws__net__poll_events__finalize_spec");
      begin
         F42;
      end;
      declare
         procedure F43;
         pragma Import (Ada, F43, "aws__net__log__finalize_body");
      begin
         E574 := E574 - 1;
         F43;
      end;
      declare
         procedure F44;
         pragma Import (Ada, F44, "aws__net__finalize_spec");
      begin
         F44;
      end;
      declare
         procedure F45;
         pragma Import (Ada, F45, "templates_parser__finalize_body");
      begin
         E611 := E611 - 1;
         F45;
      end;
      declare
         procedure F46;
         pragma Import (Ada, F46, "aws__resources__embedded__finalize_body");
      begin
         E618 := E618 - 1;
         F46;
      end;
      E622 := E622 - 1;
      declare
         procedure F47;
         pragma Import (Ada, F47, "aws__resources__streams__zlib__finalize_spec");
      begin
         F47;
      end;
      E628 := E628 - 1;
      declare
         procedure F48;
         pragma Import (Ada, F48, "aws__resources__streams__memory__finalize_spec");
      begin
         F48;
      end;
      E636 := E636 - 1;
      declare
         procedure F49;
         pragma Import (Ada, F49, "aws__resources__streams__disk__finalize_spec");
      begin
         F49;
      end;
      E620 := E620 - 1;
      declare
         procedure F50;
         pragma Import (Ada, F50, "aws__resources__streams__finalize_spec");
      begin
         F50;
      end;
      E576 := E576 - 1;
      declare
         procedure F51;
         pragma Import (Ada, F51, "aws__utils__finalize_spec");
      begin
         F51;
      end;
      declare
         procedure F52;
         pragma Import (Ada, F52, "templates_parser__finalize_spec");
      begin
         F52;
      end;
      E624 := E624 - 1;
      declare
         procedure F53;
         pragma Import (Ada, F53, "zlib__finalize_spec");
      begin
         F53;
      end;
      declare
         procedure F54;
         pragma Import (Ada, F54, "util__texts__builders_tests__finalize_body");
      begin
         E976 := E976 - 1;
         F54;
      end;
      declare
         procedure F55;
         pragma Import (Ada, F55, "util__texts__builders_tests__finalize_spec");
      begin
         F55;
      end;
      declare
         procedure F56;
         pragma Import (Ada, F56, "util__streams__sockets__tests__finalize_body");
      begin
         E952 := E952 - 1;
         F56;
      end;
      declare
         procedure F57;
         pragma Import (Ada, F57, "util__streams__sockets__tests__finalize_spec");
      begin
         F57;
      end;
      declare
         procedure F58;
         pragma Import (Ada, F58, "util__http__clients__tests__finalize_body");
      begin
         E792 := E792 - 1;
         F58;
      end;
      declare
         procedure F59;
         pragma Import (Ada, F59, "util__http__clients__tests__finalize_spec");
      begin
         F59;
      end;
      declare
         procedure F60;
         pragma Import (Ada, F60, "util__tests__servers__finalize_body");
      begin
         E798 := E798 - 1;
         F60;
      end;
      declare
         procedure F61;
         pragma Import (Ada, F61, "util__tests__servers__finalize_spec");
      begin
         F61;
      end;
      E974 := E974 - 1;
      declare
         procedure F62;
         pragma Import (Ada, F62, "util__systems__os__tests__finalize_spec");
      begin
         F62;
      end;
      E972 := E972 - 1;
      declare
         procedure F63;
         pragma Import (Ada, F63, "util__systems__dlls__tests__finalize_spec");
      begin
         F63;
      end;
      declare
         procedure F64;
         pragma Import (Ada, F64, "util__strings__tests__finalize_body");
      begin
         E963 := E963 - 1;
         F64;
      end;
      declare
         procedure F65;
         pragma Import (Ada, F65, "util__strings__tests__finalize_spec");
      begin
         F65;
      end;
      E961 := E961 - 1;
      declare
         procedure F66;
         pragma Import (Ada, F66, "util__streams__texts__tests__finalize_spec");
      begin
         F66;
      end;
      E954 := E954 - 1;
      declare
         procedure F67;
         pragma Import (Ada, F67, "util__streams__tests__finalize_spec");
      begin
         F67;
      end;
      E950 := E950 - 1;
      declare
         procedure F68;
         pragma Import (Ada, F68, "util__streams__files__tests__finalize_spec");
      begin
         F68;
      end;
      E948 := E948 - 1;
      declare
         procedure F69;
         pragma Import (Ada, F69, "util__streams__buffered__tests__finalize_spec");
      begin
         F69;
      end;
      declare
         procedure F70;
         pragma Import (Ada, F70, "util__serialize__tools__tests__finalize_body");
      begin
         E946 := E946 - 1;
         F70;
      end;
      declare
         procedure F71;
         pragma Import (Ada, F71, "util__serialize__tools__tests__finalize_spec");
      begin
         F71;
      end;
      declare
         procedure F72;
         pragma Import (Ada, F72, "util__serialize__io__xml__tests__finalize_body");
      begin
         E936 := E936 - 1;
         F72;
      end;
      declare
         procedure F73;
         pragma Import (Ada, F73, "util__serialize__io__xml__tests__finalize_spec");
      begin
         F73;
      end;
      declare
         procedure F74;
         pragma Import (Ada, F74, "util__serialize__io__json__tests__finalize_body");
      begin
         E863 := E863 - 1;
         F74;
      end;
      declare
         procedure F75;
         pragma Import (Ada, F75, "util__serialize__io__json__tests__finalize_spec");
      begin
         F75;
      end;
      declare
         procedure F76;
         pragma Import (Ada, F76, "util__serialize__io__form__tests__finalize_body");
      begin
         E861 := E861 - 1;
         F76;
      end;
      declare
         procedure F77;
         pragma Import (Ada, F77, "util__serialize__io__form__tests__finalize_spec");
      begin
         F77;
      end;
      E859 := E859 - 1;
      declare
         procedure F78;
         pragma Import (Ada, F78, "util__properties__tests__finalize_spec");
      begin
         F78;
      end;
      E857 := E857 - 1;
      declare
         procedure F79;
         pragma Import (Ada, F79, "util__properties__json__tests__finalize_spec");
      begin
         F79;
      end;
      E841 := E841 - 1;
      declare
         procedure F80;
         pragma Import (Ada, F80, "util__properties__form__tests__finalize_spec");
      begin
         F80;
      end;
      E837 := E837 - 1;
      declare
         procedure F81;
         pragma Import (Ada, F81, "util__properties__bundles__tests__finalize_spec");
      begin
         F81;
      end;
      declare
         procedure F82;
         pragma Import (Ada, F82, "util__processes__tests__finalize_body");
      begin
         E831 := E831 - 1;
         F82;
      end;
      declare
         procedure F83;
         pragma Import (Ada, F83, "util__processes__tests__finalize_spec");
      begin
         F83;
      end;
      E819 := E819 - 1;
      declare
         procedure F84;
         pragma Import (Ada, F84, "util__nullables__tests__finalize_spec");
      begin
         F84;
      end;
      E817 := E817 - 1;
      declare
         procedure F85;
         pragma Import (Ada, F85, "util__mail__tests__finalize_spec");
      begin
         F85;
      end;
      declare
         procedure F86;
         pragma Import (Ada, F86, "util__log__tests__finalize_body");
      begin
         E813 := E813 - 1;
         F86;
      end;
      declare
         procedure F87;
         pragma Import (Ada, F87, "util__log__tests__finalize_spec");
      begin
         F87;
      end;
      E811 := E811 - 1;
      declare
         procedure F88;
         pragma Import (Ada, F88, "util__locales__tests__finalize_spec");
      begin
         F88;
      end;
      declare
         procedure F89;
         pragma Import (Ada, F89, "util__listeners__tests__finalize_body");
      begin
         E803 := E803 - 1;
         F89;
      end;
      declare
         procedure F90;
         pragma Import (Ada, F90, "util__listeners__tests__finalize_spec");
      begin
         F90;
      end;
      declare
         procedure F91;
         pragma Import (Ada, F91, "util__http__cookies__tests__finalize_body");
      begin
         E800 := E800 - 1;
         F91;
      end;
      declare
         procedure F92;
         pragma Import (Ada, F92, "util__http__cookies__tests__finalize_spec");
      begin
         F92;
      end;
      E539 := E539 - 1;
      declare
         procedure F93;
         pragma Import (Ada, F93, "util__files__tests__finalize_spec");
      begin
         F93;
      end;
      E535 := E535 - 1;
      declare
         procedure F94;
         pragma Import (Ada, F94, "util__events__timers__tests__finalize_spec");
      begin
         F94;
      end;
      E531 := E531 - 1;
      declare
         procedure F95;
         pragma Import (Ada, F95, "util__events__channels__tests__finalize_spec");
      begin
         F95;
      end;
      E523 := E523 - 1;
      declare
         procedure F96;
         pragma Import (Ada, F96, "util__encoders__tests__finalize_spec");
      begin
         F96;
      end;
      E499 := E499 - 1;
      declare
         procedure F97;
         pragma Import (Ada, F97, "util__encoders__kdf__tests__finalize_spec");
      begin
         F97;
      end;
      E496 := E496 - 1;
      declare
         procedure F98;
         pragma Import (Ada, F98, "util__encoders__ecc__tests__finalize_spec");
      begin
         F98;
      end;
      E484 := E484 - 1;
      declare
         procedure F99;
         pragma Import (Ada, F99, "util__dates__tests__finalize_spec");
      begin
         F99;
      end;
      declare
         procedure F100;
         pragma Import (Ada, F100, "util__dates__formats__tests__finalize_body");
      begin
         E474 := E474 - 1;
         F100;
      end;
      declare
         procedure F101;
         pragma Import (Ada, F101, "util__dates__formats__tests__finalize_spec");
      begin
         F101;
      end;
      declare
         procedure F102;
         pragma Import (Ada, F102, "util__concurrent__tests__finalize_body");
      begin
         E456 := E456 - 1;
         F102;
      end;
      declare
         procedure F103;
         pragma Import (Ada, F103, "util__concurrent__tests__finalize_spec");
      begin
         F103;
      end;
      declare
         procedure F104;
         pragma Import (Ada, F104, "util__commands__tests__finalize_body");
      begin
         E447 := E447 - 1;
         F104;
      end;
      declare
         procedure F105;
         pragma Import (Ada, F105, "util__commands__tests__finalize_spec");
      begin
         F105;
      end;
      E443 := E443 - 1;
      declare
         procedure F106;
         pragma Import (Ada, F106, "util__beans__ranges__tests__finalize_spec");
      begin
         F106;
      end;
      E438 := E438 - 1;
      declare
         procedure F107;
         pragma Import (Ada, F107, "util__beans__objects__tests__finalize_spec");
      begin
         F107;
      end;
      declare
         procedure F108;
         pragma Import (Ada, F108, "util__beans__objects__record_tests__finalize_body");
      begin
         E432 := E432 - 1;
         F108;
      end;
      declare
         procedure F109;
         pragma Import (Ada, F109, "util__beans__objects__record_tests__finalize_spec");
      begin
         F109;
      end;
      declare
         procedure F110;
         pragma Import (Ada, F110, "util__beans__objects__discretes__finalize_body");
      begin
         E415 := E415 - 1;
         F110;
      end;
      E411 := E411 - 1;
      declare
         procedure F111;
         pragma Import (Ada, F111, "util__beans__objects__datasets__tests__finalize_spec");
      begin
         F111;
      end;
      E835 := E835 - 1;
      declare
         procedure F112;
         pragma Import (Ada, F112, "util__streams__pipes__finalize_spec");
      begin
         F112;
      end;
      declare
         procedure F113;
         pragma Import (Ada, F113, "util__processes__finalize_body");
      begin
         E821 := E821 - 1;
         F113;
      end;
      E823 := E823 - 1;
      declare
         procedure F114;
         pragma Import (Ada, F114, "util__processes__os__finalize_spec");
      begin
         F114;
      end;
      E825 := E825 - 1;
      declare
         procedure F115;
         pragma Import (Ada, F115, "util__streams__raw__finalize_spec");
      begin
         F115;
      end;
      declare
         procedure F116;
         pragma Import (Ada, F116, "util__processes__finalize_spec");
      begin
         F116;
      end;
      declare
         procedure F117;
         pragma Import (Ada, F117, "util__serialize__tools__finalize_body");
      begin
         E944 := E944 - 1;
         F117;
      end;
      declare
         procedure F118;
         pragma Import (Ada, F118, "util__serialize__mappers__finalize_body");
      begin
         E940 := E940 - 1;
         F118;
      end;
      declare
         procedure F119;
         pragma Import (Ada, F119, "util__serialize__mappers__finalize_spec");
      begin
         F119;
      end;
      declare
         procedure F120;
         pragma Import (Ada, F120, "util__serialize__io__xml__finalize_body");
      begin
         E865 := E865 - 1;
         F120;
      end;
      declare
         procedure F121;
         pragma Import (Ada, F121, "util__serialize__io__xml__finalize_spec");
      begin
         F121;
      end;
      declare
         procedure F122;
         pragma Import (Ada, F122, "util__properties__json__finalize_body");
      begin
         E843 := E843 - 1;
         F122;
      end;
      E845 := E845 - 1;
      declare
         procedure F123;
         pragma Import (Ada, F123, "util__serialize__io__json__finalize_spec");
      begin
         F123;
      end;
      declare
         procedure F124;
         pragma Import (Ada, F124, "util__properties__form__finalize_body");
      begin
         E839 := E839 - 1;
         F124;
      end;
      declare
         procedure F125;
         pragma Import (Ada, F125, "util__http__clients__finalize_body");
      begin
         E543 := E543 - 1;
         F125;
      end;
      declare
         procedure F126;
         pragma Import (Ada, F126, "util__http__clients__finalize_spec");
      begin
         F126;
      end;
      E554 := E554 - 1;
      declare
         procedure F127;
         pragma Import (Ada, F127, "util__serialize__io__form__finalize_spec");
      begin
         F127;
      end;
      E556 := E556 - 1;
      declare
         procedure F128;
         pragma Import (Ada, F128, "util__beans__objects__readers__finalize_spec");
      begin
         F128;
      end;
      declare
         procedure F129;
         pragma Import (Ada, F129, "util__serialize__io__finalize_body");
      begin
         E550 := E550 - 1;
         F129;
      end;
      declare
         procedure F130;
         pragma Import (Ada, F130, "util__properties__bundles__finalize_body");
      begin
         E480 := E480 - 1;
         F130;
      end;
      declare
         procedure F131;
         pragma Import (Ada, F131, "util__properties__bundles__finalize_spec");
      begin
         F131;
      end;
      declare
         procedure F132;
         pragma Import (Ada, F132, "util__events__timers__finalize_body");
      begin
         E533 := E533 - 1;
         F132;
      end;
      declare
         procedure F133;
         pragma Import (Ada, F133, "util__events__timers__finalize_spec");
      begin
         F133;
      end;
      E277 := E277 - 1;
      declare
         procedure F134;
         pragma Import (Ada, F134, "util__tests__finalize_body");
      begin
         E241 := E241 - 1;
         F134;
      end;
      declare
         procedure F135;
         pragma Import (Ada, F135, "util__tests__finalize_spec");
      begin
         F135;
      end;
      declare
         procedure F136;
         pragma Import (Ada, F136, "util__xunit__finalize_spec");
      begin
         F136;
      end;
      E301 := E301 - 1;
      declare
         procedure F137;
         pragma Import (Ada, F137, "ahven__framework__finalize_spec");
      begin
         F137;
      end;
      declare
         procedure F138;
         pragma Import (Ada, F138, "util__log__loggers__finalize_body");
      begin
         E353 := E353 - 1;
         F138;
      end;
      declare
         procedure F139;
         pragma Import (Ada, F139, "util__log__loggers__finalize_spec");
      begin
         F139;
      end;
      E377 := E377 - 1;
      declare
         procedure F140;
         pragma Import (Ada, F140, "util__log__appenders__files__finalize_spec");
      begin
         F140;
      end;
      E365 := E365 - 1;
      declare
         procedure F141;
         pragma Import (Ada, F141, "util__log__appenders__consoles__finalize_spec");
      begin
         F141;
      end;
      E355 := E355 - 1;
      declare
         procedure F142;
         pragma Import (Ada, F142, "util__log__appenders__finalize_spec");
      begin
         F142;
      end;
      declare
         procedure F143;
         pragma Import (Ada, F143, "util__properties__finalize_body");
      begin
         E166 := E166 - 1;
         F143;
      end;
      declare
         procedure F144;
         pragma Import (Ada, F144, "util__properties__finalize_spec");
      begin
         F144;
      end;
      E445 := E445 - 1;
      declare
         procedure F145;
         pragma Import (Ada, F145, "util__commands__finalize_spec");
      begin
         F145;
      end;
      E545 := E545 - 1;
      declare
         procedure F146;
         pragma Import (Ada, F146, "util__http__cookies__finalize_spec");
      begin
         F146;
      end;
      E381 := E381 - 1;
      declare
         procedure F147;
         pragma Import (Ada, F147, "util__measures__finalize_spec");
      begin
         F147;
      end;
      E396 := E396 - 1;
      declare
         procedure F148;
         pragma Import (Ada, F148, "util__streams__texts__finalize_spec");
      begin
         F148;
      end;
      E796 := E796 - 1;
      declare
         procedure F149;
         pragma Import (Ada, F149, "util__streams__sockets__finalize_spec");
      begin
         F149;
      end;
      E552 := E552 - 1;
      declare
         procedure F150;
         pragma Import (Ada, F150, "util__streams__files__finalize_spec");
      begin
         F150;
      end;
      declare
         procedure F151;
         pragma Import (Ada, F151, "util__streams__base64__finalize_spec");
      begin
         E959 := E959 - 1;
         F151;
      end;
      E956 := E956 - 1;
      declare
         procedure F152;
         pragma Import (Ada, F152, "util__streams__aes__finalize_spec");
      begin
         F152;
      end;
      E394 := E394 - 1;
      declare
         procedure F153;
         pragma Import (Ada, F153, "util__streams__buffered__finalize_spec");
      begin
         F153;
      end;
      E938 := E938 - 1;
      declare
         procedure F154;
         pragma Import (Ada, F154, "util__serialize__contexts__finalize_spec");
      begin
         F154;
      end;
      declare
         procedure F155;
         pragma Import (Ada, F155, "util__beans__objects__time__finalize_body");
      begin
         E427 := E427 - 1;
         F155;
      end;
      declare
         procedure F156;
         pragma Import (Ada, F156, "util__listeners__finalize_spec");
      begin
         E801 := E801 - 1;
         F156;
      end;
      E541 := E541 - 1;
      declare
         procedure F157;
         pragma Import (Ada, F157, "util__http__finalize_spec");
      begin
         F157;
      end;
      E529 := E529 - 1;
      declare
         procedure F158;
         pragma Import (Ada, F158, "util__events__channels__finalize_spec");
      begin
         F158;
      end;
      E527 := E527 - 1;
      declare
         procedure F159;
         pragma Import (Ada, F159, "util__events__finalize_spec");
      begin
         F159;
      end;
      E506 := E506 - 1;
      declare
         procedure F160;
         pragma Import (Ada, F160, "util__encoders__hmac__sha256__finalize_spec");
      begin
         F160;
      end;
      E501 := E501 - 1;
      declare
         procedure F161;
         pragma Import (Ada, F161, "util__encoders__aes__finalize_spec");
      begin
         F161;
      end;
      declare
         procedure F162;
         pragma Import (Ada, F162, "util__beans__ranges__finalize_spec");
      begin
         E439 := E439 - 1;
         F162;
      end;
      E436 := E436 - 1;
      declare
         procedure F163;
         pragma Import (Ada, F163, "util__beans__objects__vectors__finalize_spec");
      begin
         F163;
      end;
      E209 := E209 - 1;
      declare
         procedure F164;
         pragma Import (Ada, F164, "util__beans__objects__maps__finalize_spec");
      begin
         F164;
      end;
      E409 := E409 - 1;
      declare
         procedure F165;
         pragma Import (Ada, F165, "util__beans__objects__datasets__finalize_spec");
      begin
         F165;
      end;
      E928 := E928 - 1;
      declare
         procedure F166;
         pragma Import (Ada, F166, "sax__readers__finalize_spec");
      begin
         F166;
      end;
      E932 := E932 - 1;
      declare
         procedure F167;
         pragma Import (Ada, F167, "input_sources__strings__finalize_spec");
      begin
         F167;
      end;
      E930 := E930 - 1;
      declare
         procedure F168;
         pragma Import (Ada, F168, "input_sources__file__finalize_spec");
      begin
         F168;
      end;
      E893 := E893 - 1;
      declare
         procedure F169;
         pragma Import (Ada, F169, "input_sources__finalize_spec");
      begin
         F169;
      end;
      E934 := E934 - 1;
      declare
         procedure F170;
         pragma Import (Ada, F170, "sax__utils__finalize_spec");
      begin
         F170;
      end;
      E923 := E923 - 1;
      declare
         procedure F171;
         pragma Import (Ada, F171, "sax__attributes__finalize_spec");
      begin
         F171;
      end;
      E868 := E868 - 1;
      declare
         procedure F172;
         pragma Import (Ada, F172, "sax__exceptions__finalize_spec");
      begin
         F172;
      end;
      E872 := E872 - 1;
      declare
         procedure F173;
         pragma Import (Ada, F173, "sax__symbols__finalize_spec");
      begin
         F173;
      end;
      declare
         procedure F174;
         pragma Import (Ada, F174, "templates_parser_tasking__finalize_body");
      begin
         E644 := E644 - 1;
         F174;
      end;
      E876 := E876 - 1;
      declare
         procedure F175;
         pragma Import (Ada, F175, "sax__pointers__finalize_spec");
      begin
         F175;
      end;
      E569 := E569 - 1;
      declare
         procedure F176;
         pragma Import (Ada, F176, "aws__containers__tables__finalize_spec");
      begin
         F176;
      end;
      E289 := E289 - 1;
      declare
         procedure F177;
         pragma Import (Ada, F177, "ahven__listeners__basic__finalize_spec");
      begin
         F177;
      end;
      E291 := E291 - 1;
      declare
         procedure F178;
         pragma Import (Ada, F178, "ahven__results__finalize_spec");
      begin
         F178;
      end;
      E285 := E285 - 1;
      declare
         procedure F179;
         pragma Import (Ada, F179, "ahven__listeners__finalize_spec");
      begin
         F179;
      end;
      E230 := E230 - 1;
      declare
         procedure F180;
         pragma Import (Ada, F180, "util__strings__finalize_spec");
      begin
         F180;
      end;
      E504 := E504 - 1;
      declare
         procedure F181;
         pragma Import (Ada, F181, "util__encoders__hmac__sha1__finalize_spec");
      begin
         F181;
      end;
      E486 := E486 - 1;
      E492 := E492 - 1;
      declare
         procedure F182;
         pragma Import (Ada, F182, "util__encoders__sha1__finalize_spec");
      begin
         F182;
      end;
      E490 := E490 - 1;
      declare
         procedure F183;
         pragma Import (Ada, F183, "util__encoders__base64__finalize_spec");
      begin
         F183;
      end;
      E488 := E488 - 1;
      declare
         procedure F184;
         pragma Import (Ada, F184, "util__encoders__base16__finalize_spec");
      begin
         F184;
      end;
      declare
         procedure F185;
         pragma Import (Ada, F185, "util__encoders__finalize_spec");
      begin
         F185;
      end;
      E392 := E392 - 1;
      declare
         procedure F186;
         pragma Import (Ada, F186, "util__streams__finalize_spec");
      begin
         F186;
      end;
      E177 := E177 - 1;
      declare
         procedure F187;
         pragma Import (Ada, F187, "util__beans__basic__finalize_spec");
      begin
         E198 := E198 - 1;
         F187;
      end;
      declare
         procedure F188;
         pragma Import (Ada, F188, "util__beans__objects__finalize_spec");
      begin
         F188;
      end;
      E341 := E341 - 1;
      declare
         procedure F189;
         pragma Import (Ada, F189, "system__tasking__protected_objects__entries__finalize_spec");
      begin
         F189;
      end;
      E006 := E006 - 1;
      declare
         procedure F190;
         pragma Import (Ada, F190, "ada__directories__finalize_spec");
      begin
         F190;
      end;
      E163 := E163 - 1;
      declare
         procedure F191;
         pragma Import (Ada, F191, "system__regexp__finalize_spec");
      begin
         F191;
      end;
      declare
         procedure F192;
         pragma Import (Ada, F192, "gnat__sockets__finalize_body");
      begin
         E652 := E652 - 1;
         F192;
      end;
      declare
         procedure F193;
         pragma Import (Ada, F193, "gnat__sockets__finalize_spec");
      begin
         F193;
      end;
      E664 := E664 - 1;
      declare
         procedure F194;
         pragma Import (Ada, F194, "system__pool_size__finalize_spec");
      begin
         F194;
      end;
      E172 := E172 - 1;
      declare
         procedure F195;
         pragma Import (Ada, F195, "system__pool_global__finalize_spec");
      begin
         F195;
      end;
      E170 := E170 - 1;
      declare
         procedure F196;
         pragma Import (Ada, F196, "ada__text_io__finalize_spec");
      begin
         F196;
      end;
      E200 := E200 - 1;
      declare
         procedure F197;
         pragma Import (Ada, F197, "ada__strings__wide_wide_unbounded__finalize_spec");
      begin
         F197;
      end;
      E204 := E204 - 1;
      declare
         procedure F198;
         pragma Import (Ada, F198, "ada__strings__wide_wide_maps__finalize_spec");
      begin
         F198;
      end;
      E125 := E125 - 1;
      declare
         procedure F199;
         pragma Import (Ada, F199, "ada__strings__unbounded__finalize_spec");
      begin
         F199;
      end;
      E137 := E137 - 1;
      declare
         procedure F200;
         pragma Import (Ada, F200, "system__storage_pools__subpools__finalize_spec");
      begin
         F200;
      end;
      E139 := E139 - 1;
      declare
         procedure F201;
         pragma Import (Ada, F201, "system__finalization_masters__finalize_spec");
      begin
         F201;
      end;
      E224 := E224 - 1;
      declare
         procedure F202;
         pragma Import (Ada, F202, "ada__streams__stream_io__finalize_spec");
      begin
         F202;
      end;
      declare
         procedure F203;
         pragma Import (Ada, F203, "system__file_io__finalize_body");
      begin
         E158 := E158 - 1;
         F203;
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
          (True, True, True, False, True, True, False, False, 
           True, False, False, True, True, True, True, False, 
           False, True, False, False, True, True, False, True, 
           True, False, True, True, True, True, False, True, 
           False, True, False, True, False, True, True, False, 
           True, True, True, True, False, True, True, True, 
           True, False, False, True, False, True, True, True, 
           False, True, False, True, True, True, True, True, 
           True, True, True, False, True, True, True, False, 
           True, True, False, True, True, True, True, True, 
           True, True, False, False, False, True, True, True, 
           True, False, True, False),
         Count => (0, 0, 0, 6, 3, 2, 9, 0, 28, 0),
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
      E027 := E027 + 1;
      Ada.Containers'Elab_Spec;
      E042 := E042 + 1;
      Ada.Io_Exceptions'Elab_Spec;
      E072 := E072 + 1;
      Ada.Strings'Elab_Spec;
      E057 := E057 + 1;
      Ada.Strings.Maps'Elab_Spec;
      E059 := E059 + 1;
      Ada.Strings.Maps.Constants'Elab_Spec;
      E063 := E063 + 1;
      Interfaces.C'Elab_Spec;
      E047 := E047 + 1;
      System.Exceptions'Elab_Spec;
      E029 := E029 + 1;
      System.Object_Reader'Elab_Spec;
      E083 := E083 + 1;
      System.Dwarf_Lines'Elab_Spec;
      E052 := E052 + 1;
      System.Os_Lib'Elab_Body;
      E077 := E077 + 1;
      System.Soft_Links.Initialize'Elab_Body;
      E023 := E023 + 1;
      E015 := E015 + 1;
      System.Traceback.Symbolic'Elab_Body;
      E041 := E041 + 1;
      Ada.Numerics'Elab_Spec;
      E591 := E591 + 1;
      Ada.Strings.Utf_Encoding'Elab_Spec;
      E181 := E181 + 1;
      Ada.Tags'Elab_Spec;
      Ada.Tags'Elab_Body;
      E127 := E127 + 1;
      Ada.Streams'Elab_Spec;
      E144 := E144 + 1;
      Gnat'Elab_Spec;
      E244 := E244 + 1;
      Interfaces.C.Strings'Elab_Spec;
      E228 := E228 + 1;
      System.File_Control_Block'Elab_Spec;
      E161 := E161 + 1;
      System.Finalization_Root'Elab_Spec;
      E146 := E146 + 1;
      Ada.Finalization'Elab_Spec;
      E142 := E142 + 1;
      System.File_Io'Elab_Body;
      E158 := E158 + 1;
      Ada.Streams.Stream_Io'Elab_Spec;
      E224 := E224 + 1;
      System.Storage_Pools'Elab_Spec;
      E148 := E148 + 1;
      System.Finalization_Masters'Elab_Spec;
      System.Finalization_Masters'Elab_Body;
      E139 := E139 + 1;
      System.Storage_Pools.Subpools'Elab_Spec;
      E137 := E137 + 1;
      Ada.Strings.Unbounded'Elab_Spec;
      E125 := E125 + 1;
      Ada.Strings.Wide_Wide_Maps'Elab_Spec;
      E204 := E204 + 1;
      Ada.Strings.Wide_Wide_Unbounded'Elab_Spec;
      E200 := E200 + 1;
      System.Task_Info'Elab_Spec;
      E317 := E317 + 1;
      System.Task_Primitives.Operations'Elab_Body;
      E311 := E311 + 1;
      System.Regpat'Elab_Spec;
      E254 := E254 + 1;
      Ada.Calendar'Elab_Spec;
      Ada.Calendar'Elab_Body;
      E008 := E008 + 1;
      Ada.Calendar.Delays'Elab_Body;
      E657 := E657 + 1;
      Ada.Calendar.Time_Zones'Elab_Spec;
      E105 := E105 + 1;
      Ada.Real_Time'Elab_Spec;
      Ada.Real_Time'Elab_Body;
      E303 := E303 + 1;
      Ada.Text_Io'Elab_Spec;
      Ada.Text_Io'Elab_Body;
      E170 := E170 + 1;
      Gnat.Calendar'Elab_Spec;
      E385 := E385 + 1;
      Gnat.Calendar.Time_Io'Elab_Spec;
      E388 := E388 + 1;
      Gnat.Directory_Operations'Elab_Spec;
      Gnat.Directory_Operations'Elab_Body;
      E248 := E248 + 1;
      E512 := E512 + 1;
      E695 := E695 + 1;
      Gnat.Md5'Elab_Spec;
      E693 := E693 + 1;
      E729 := E729 + 1;
      E519 := E519 + 1;
      E514 := E514 + 1;
      Gnat.Sha1'Elab_Spec;
      E727 := E727 + 1;
      Gnat.Sha256'Elab_Spec;
      E510 := E510 + 1;
      System.Assertions'Elab_Spec;
      E218 := E218 + 1;
      System.Pool_Global'Elab_Spec;
      E172 := E172 + 1;
      System.Pool_Size'Elab_Spec;
      E664 := E664 + 1;
      Gnat.Sockets'Elab_Spec;
      E662 := E662 + 1;
      E655 := E655 + 1;
      Gnat.Sockets'Elab_Body;
      E652 := E652 + 1;
      System.Random_Seed'Elab_Body;
      E609 := E609 + 1;
      System.Regexp'Elab_Spec;
      E163 := E163 + 1;
      Ada.Directories'Elab_Spec;
      Ada.Directories'Elab_Body;
      E006 := E006 + 1;
      Gnat.Command_Line'Elab_Spec;
      Gnat.Command_Line'Elab_Body;
      E246 := E246 + 1;
      System.Tasking.Initialization'Elab_Body;
      E337 := E337 + 1;
      System.Tasking.Protected_Objects'Elab_Body;
      E325 := E325 + 1;
      System.Tasking.Protected_Objects.Entries'Elab_Spec;
      E341 := E341 + 1;
      System.Tasking.Queuing'Elab_Body;
      E345 := E345 + 1;
      System.Tasking.Stages'Elab_Body;
      E349 := E349 + 1;
      AWS.DEFAULT'ELAB_SPEC;
      E669 := E669 + 1;
      Unicode'Elab_Body;
      E878 := E878 + 1;
      Util.Beans.Objects'Elab_Spec;
      Util.Beans.Basic'Elab_Spec;
      E198 := E198 + 1;
      Util.Beans.Objects'Elab_Body;
      E177 := E177 + 1;
      Util.Log'Elab_Spec;
      E351 := E351 + 1;
      Util.Streams'Elab_Spec;
      E392 := E392 + 1;
      Util.Encoders'Elab_Spec;
      Util.Encoders.Base16'Elab_Spec;
      Util.Encoders.Base16'Elab_Body;
      E488 := E488 + 1;
      Util.Encoders.Base64'Elab_Spec;
      Util.Encoders.Base64'Elab_Body;
      E490 := E490 + 1;
      Util.Encoders.Sha1'Elab_Spec;
      Util.Encoders.Sha1'Elab_Body;
      E492 := E492 + 1;
      Util.Encoders'Elab_Body;
      E486 := E486 + 1;
      Util.Encoders.Hmac.Sha1'Elab_Spec;
      Util.Encoders.Hmac.Sha1'Elab_Body;
      E504 := E504 + 1;
      Util.Strings'Elab_Spec;
      Util.Strings'Elab_Body;
      E230 := E230 + 1;
      Ahven'Elab_Spec;
      E275 := E275 + 1;
      Ahven.Astrings'Elab_Body;
      E279 := E279 + 1;
      Ahven.Long_Astrings'Elab_Body;
      E287 := E287 + 1;
      Ahven.Listeners'Elab_Spec;
      Ahven.Listeners'Elab_Body;
      E285 := E285 + 1;
      E293 := E293 + 1;
      Ahven.Results'Elab_Spec;
      E291 := E291 + 1;
      Ahven.Temporary_Output'Elab_Spec;
      E295 := E295 + 1;
      Ahven.Listeners.Basic'Elab_Spec;
      Ahven.Listeners.Basic'Elab_Body;
      E289 := E289 + 1;
      E404 := E404 + 1;
      AWS.CONTAINERS.KEY_VALUE'ELAB_SPEC;
      E723 := E723 + 1;
      AWS.CONTAINERS.STRING_VECTORS'ELAB_SPEC;
      E687 := E687 + 1;
      AWS.CONTAINERS.TABLES'ELAB_SPEC;
      AWS.CONTAINERS.TABLES'ELAB_BODY;
      E569 := E569 + 1;
      E632 := E632 + 1;
      E874 := E874 + 1;
      Sax.Pointers'Elab_Spec;
      Sax.Pointers'Elab_Body;
      E876 := E876 + 1;
      Templates_Parser_Tasking'Elab_Body;
      E644 := E644 + 1;
      Unicode.Ccs'Elab_Spec;
      E889 := E889 + 1;
      E897 := E897 + 1;
      E899 := E899 + 1;
      E904 := E904 + 1;
      E907 := E907 + 1;
      E909 := E909 + 1;
      E911 := E911 + 1;
      E916 := E916 + 1;
      Unicode.Ces'Elab_Spec;
      E885 := E885 + 1;
      Sax.Symbols'Elab_Spec;
      Sax.Symbols'Elab_Body;
      E872 := E872 + 1;
      E870 := E870 + 1;
      Sax.Exceptions'Elab_Spec;
      Sax.Exceptions'Elab_Body;
      E868 := E868 + 1;
      E891 := E891 + 1;
      E919 := E919 + 1;
      E921 := E921 + 1;
      E887 := E887 + 1;
      Sax.Models'Elab_Spec;
      E925 := E925 + 1;
      Sax.Attributes'Elab_Spec;
      Sax.Attributes'Elab_Body;
      E923 := E923 + 1;
      Sax.Utils'Elab_Spec;
      Sax.Utils'Elab_Body;
      E934 := E934 + 1;
      E895 := E895 + 1;
      Input_Sources'Elab_Spec;
      Input_Sources'Elab_Body;
      E893 := E893 + 1;
      Input_Sources.File'Elab_Spec;
      Input_Sources.File'Elab_Body;
      E930 := E930 + 1;
      Input_Sources.Strings'Elab_Spec;
      Input_Sources.Strings'Elab_Body;
      E932 := E932 + 1;
      Sax.Readers'Elab_Spec;
      Sax.Readers'Elab_Body;
      E928 := E928 + 1;
      E441 := E441 + 1;
      Util.Beans.Objects.Datasets'Elab_Spec;
      Util.Beans.Objects.Datasets'Elab_Body;
      E409 := E409 + 1;
      E425 := E425 + 1;
      Util.Beans.Objects.Maps'Elab_Spec;
      Util.Beans.Objects.Maps'Elab_Body;
      E209 := E209 + 1;
      E434 := E434 + 1;
      Util.Beans.Objects.Vectors'Elab_Spec;
      Util.Beans.Objects.Vectors'Elab_Body;
      E436 := E436 + 1;
      Util.Beans.Ranges'Elab_Spec;
      E439 := E439 + 1;
      E458 := E458 + 1;
      E462 := E462 + 1;
      E466 := E466 + 1;
      E468 := E468 + 1;
      E476 := E476 + 1;
      Util.Encoders.Aes'Elab_Spec;
      Util.Encoders.Aes'Elab_Body;
      E501 := E501 + 1;
      E494 := E494 + 1;
      E521 := E521 + 1;
      E508 := E508 + 1;
      Util.Encoders.Hmac.Sha256'Elab_Spec;
      Util.Encoders.Hmac.Sha256'Elab_Body;
      E506 := E506 + 1;
      Util.Events'Elab_Spec;
      Util.Events'Elab_Body;
      E527 := E527 + 1;
      Util.Events.Channels'Elab_Spec;
      Util.Events.Channels'Elab_Body;
      E529 := E529 + 1;
      Util.Http'Elab_Spec;
      E541 := E541 + 1;
      Util.Listeners'Elab_Spec;
      E801 := E801 + 1;
      E805 := E805 + 1;
      E807 := E807 + 1;
      E815 := E815 + 1;
      Util.Nullables'Elab_Spec;
      E430 := E430 + 1;
      Util.Beans.Objects.Time'Elab_Body;
      E427 := E427 + 1;
      E968 := E968 + 1;
      Util.Serialize.Contexts'Elab_Spec;
      Util.Serialize.Contexts'Elab_Body;
      E938 := E938 + 1;
      Util.Streams.Buffered'Elab_Spec;
      Util.Streams.Buffered'Elab_Body;
      E394 := E394 + 1;
      E958 := E958 + 1;
      Util.Streams.Aes'Elab_Spec;
      Util.Streams.Aes'Elab_Body;
      E956 := E956 + 1;
      Util.Streams.Base64'Elab_Spec;
      E959 := E959 + 1;
      Util.Streams.Files'Elab_Spec;
      Util.Streams.Files'Elab_Body;
      E552 := E552 + 1;
      Util.Streams.Sockets'Elab_Spec;
      Util.Streams.Sockets'Elab_Body;
      E796 := E796 + 1;
      Util.Streams.Texts'Elab_Spec;
      Util.Streams.Texts'Elab_Body;
      E396 := E396 + 1;
      Util.Measures'Elab_Spec;
      Util.Measures'Elab_Body;
      E381 := E381 + 1;
      Util.Strings.Builders'Elab_Spec;
      E361 := E361 + 1;
      E478 := E478 + 1;
      Util.Http.Cookies'Elab_Spec;
      Util.Http.Cookies'Elab_Body;
      E545 := E545 + 1;
      E379 := E379 + 1;
      Util.Strings.Maps'Elab_Spec;
      E237 := E237 + 1;
      Util.Strings.Vectors'Elab_Spec;
      E239 := E239 + 1;
      Util.Commands'Elab_Spec;
      Util.Commands'Elab_Body;
      E445 := E445 + 1;
      E452 := E452 + 1;
      E454 := E454 + 1;
      E222 := E222 + 1;
      E794 := E794 + 1;
      Util.Properties'Elab_Spec;
      Util.Properties'Elab_Body;
      E166 := E166 + 1;
      E472 := E472 + 1;
      Util.Log.Appenders'Elab_Spec;
      Util.Log.Appenders'Elab_Body;
      E355 := E355 + 1;
      E375 := E375 + 1;
      E367 := E367 + 1;
      E371 := E371 + 1;
      Util.Log.Appenders.Consoles'Elab_Spec;
      Util.Log.Appenders.Consoles'Elab_Body;
      E365 := E365 + 1;
      Util.Log.Appenders.Files'Elab_Spec;
      Util.Log.Appenders.Files'Elab_Body;
      E377 := E377 + 1;
      Util.Log.Loggers'Elab_Spec;
      Util.Log.Loggers'Elab_Body;
      E353 := E353 + 1;
      Ahven.Framework'Elab_Spec;
      Ahven.Framework'Elab_Body;
      E301 := E301 + 1;
      Ahven.Parameters'Elab_Spec;
      E400 := E400 + 1;
      E299 := E299 + 1;
      E402 := E402 + 1;
      E297 := E297 + 1;
      Util.Xunit'Elab_Spec;
      E273 := E273 + 1;
      Util.Tests'Elab_Spec;
      Util.Tests'Elab_Body;
      E241 := E241 + 1;
      Util.Xunit'Elab_Body;
      E277 := E277 + 1;
      E450 := E450 + 1;
      Util.Events.Timers'Elab_Spec;
      Util.Events.Timers'Elab_Body;
      E533 := E533 + 1;
      Util.Properties.Bundles'Elab_Spec;
      Util.Properties.Bundles'Elab_Body;
      E480 := E480 + 1;
      Util.Serialize.Io'Elab_Spec;
      Util.Serialize.Io'Elab_Body;
      E550 := E550 + 1;
      Util.Beans.Objects.Readers'Elab_Spec;
      Util.Beans.Objects.Readers'Elab_Body;
      E556 := E556 + 1;
      Util.Serialize.Io.Form'Elab_Spec;
      Util.Serialize.Io.Form'Elab_Body;
      E554 := E554 + 1;
      Util.Http.Clients'Elab_Spec;
      Util.Http.Clients'Elab_Body;
      E543 := E543 + 1;
      Util.Properties.Form'Elab_Body;
      E839 := E839 + 1;
      Util.Serialize.Io.Json'Elab_Spec;
      Util.Serialize.Io.Json'Elab_Body;
      E845 := E845 + 1;
      Util.Properties.Json'Elab_Body;
      E843 := E843 + 1;
      Util.Serialize.Io.Xml'Elab_Spec;
      Util.Serialize.Io.Xml'Elab_Body;
      E865 := E865 + 1;
      Util.Serialize.Mappers'Elab_Spec;
      Util.Serialize.Mappers'Elab_Body;
      E940 := E940 + 1;
      E942 := E942 + 1;
      Util.Serialize.Tools'Elab_Body;
      E944 := E944 + 1;
      Util.Systems.Dlls'Elab_Spec;
      E970 := E970 + 1;
      Util.Processes'Elab_Spec;
      Util.Streams.Raw'Elab_Spec;
      Util.Streams.Raw'Elab_Body;
      E825 := E825 + 1;
      Util.Processes.Os'Elab_Spec;
      Util.Processes.Os'Elab_Body;
      E823 := E823 + 1;
      Util.Processes'Elab_Body;
      E821 := E821 + 1;
      Util.Streams.Pipes'Elab_Spec;
      Util.Streams.Pipes'Elab_Body;
      E835 := E835 + 1;
      E833 := E833 + 1;
      E413 := E413 + 1;
      Util.Beans.Objects.Datasets.Tests'Elab_Spec;
      Util.Beans.Objects.Datasets.Tests'Elab_Body;
      E411 := E411 + 1;
      E419 := E419 + 1;
      Util.Beans.Objects.Discretes'Elab_Body;
      E415 := E415 + 1;
      Util.Beans.Objects.Record_Tests'Elab_Spec;
      Util.Beans.Objects.Record_Tests'Elab_Body;
      E432 := E432 + 1;
      Util.Beans.Objects.Tests'Elab_Spec;
      Util.Beans.Objects.Tests'Elab_Body;
      E438 := E438 + 1;
      Util.Beans.Ranges.Tests'Elab_Spec;
      Util.Beans.Ranges.Tests'Elab_Body;
      E443 := E443 + 1;
      Util.Commands.Tests'Elab_Spec;
      Util.Commands.Tests'Elab_Body;
      E447 := E447 + 1;
      Util.Concurrent.Tests'Elab_Spec;
      Util.Concurrent.Tests'Elab_Body;
      E456 := E456 + 1;
      Util.Dates.Formats.Tests'Elab_Spec;
      Util.Dates.Formats.Tests'Elab_Body;
      E474 := E474 + 1;
      Util.Dates.Tests'Elab_Spec;
      Util.Dates.Tests'Elab_Body;
      E484 := E484 + 1;
      Util.Encoders.Ecc.Tests'Elab_Spec;
      Util.Encoders.Ecc.Tests'Elab_Body;
      E496 := E496 + 1;
      Util.Encoders.Kdf.Tests'Elab_Spec;
      Util.Encoders.Kdf.Tests'Elab_Body;
      E499 := E499 + 1;
      Util.Encoders.Tests'Elab_Spec;
      Util.Encoders.Tests'Elab_Body;
      E523 := E523 + 1;
      Util.Events.Channels.Tests'Elab_Spec;
      Util.Events.Channels.Tests'Elab_Body;
      E531 := E531 + 1;
      Util.Events.Timers.Tests'Elab_Spec;
      Util.Events.Timers.Tests'Elab_Body;
      E535 := E535 + 1;
      Util.Files.Tests'Elab_Spec;
      Util.Files.Tests'Elab_Body;
      E539 := E539 + 1;
      Util.Http.Cookies.Tests'Elab_Spec;
      Util.Http.Cookies.Tests'Elab_Body;
      E800 := E800 + 1;
      Util.Listeners.Tests'Elab_Spec;
      Util.Listeners.Tests'Elab_Body;
      E803 := E803 + 1;
      Util.Locales.Tests'Elab_Spec;
      Util.Locales.Tests'Elab_Body;
      E811 := E811 + 1;
      Util.Log.Tests'Elab_Spec;
      Util.Log.Tests'Elab_Body;
      E813 := E813 + 1;
      Util.Mail.Tests'Elab_Spec;
      Util.Mail.Tests'Elab_Body;
      E817 := E817 + 1;
      Util.Nullables.Tests'Elab_Spec;
      Util.Nullables.Tests'Elab_Body;
      E819 := E819 + 1;
      Util.Processes.Tests'Elab_Spec;
      Util.Processes.Tests'Elab_Body;
      E831 := E831 + 1;
      Util.Properties.Bundles.Tests'Elab_Spec;
      Util.Properties.Bundles.Tests'Elab_Body;
      E837 := E837 + 1;
      Util.Properties.Form.Tests'Elab_Spec;
      Util.Properties.Form.Tests'Elab_Body;
      E841 := E841 + 1;
      Util.Properties.Json.Tests'Elab_Spec;
      Util.Properties.Json.Tests'Elab_Body;
      E857 := E857 + 1;
      Util.Properties.Tests'Elab_Spec;
      Util.Properties.Tests'Elab_Body;
      E859 := E859 + 1;
      Util.Serialize.Io.Form.Tests'Elab_Spec;
      Util.Serialize.Io.Form.Tests'Elab_Body;
      E861 := E861 + 1;
      Util.Serialize.Io.Json.Tests'Elab_Spec;
      Util.Serialize.Io.Json.Tests'Elab_Body;
      E863 := E863 + 1;
      Util.Serialize.Io.Xml.Tests'Elab_Spec;
      Util.Serialize.Io.Xml.Tests'Elab_Body;
      E936 := E936 + 1;
      Util.Serialize.Tools.Tests'Elab_Spec;
      Util.Serialize.Tools.Tests'Elab_Body;
      E946 := E946 + 1;
      Util.Streams.Buffered.Tests'Elab_Spec;
      Util.Streams.Buffered.Tests'Elab_Body;
      E948 := E948 + 1;
      Util.Streams.Files.Tests'Elab_Spec;
      Util.Streams.Files.Tests'Elab_Body;
      E950 := E950 + 1;
      Util.Streams.Tests'Elab_Spec;
      Util.Streams.Tests'Elab_Body;
      E954 := E954 + 1;
      Util.Streams.Texts.Tests'Elab_Spec;
      Util.Streams.Texts.Tests'Elab_Body;
      E961 := E961 + 1;
      Util.Strings.Tests'Elab_Spec;
      Util.Strings.Tests'Elab_Body;
      E963 := E963 + 1;
      Util.Systems.Dlls.Tests'Elab_Spec;
      Util.Systems.Dlls.Tests'Elab_Body;
      E972 := E972 + 1;
      Util.Systems.Os.Tests'Elab_Spec;
      Util.Systems.Os.Tests'Elab_Body;
      E974 := E974 + 1;
      Util.Tests.Servers'Elab_Spec;
      Util.Tests.Servers'Elab_Body;
      E798 := E798 + 1;
      Util.Http.Clients.Tests'Elab_Spec;
      Util.Http.Clients.Tests'Elab_Body;
      E792 := E792 + 1;
      Util.Streams.Sockets.Tests'Elab_Spec;
      Util.Streams.Sockets.Tests'Elab_Body;
      E952 := E952 + 1;
      Util.Texts.Builders_Tests'Elab_Spec;
      Util.Texts.Builders_Tests'Elab_Body;
      E976 := E976 + 1;
      Zlib'Elab_Spec;
      Zlib.Thin'Elab_Body;
      E626 := E626 + 1;
      Zlib'Elab_Body;
      E624 := E624 + 1;
      Templates_Parser'Elab_Spec;
      Templates_Parser.Input'Elab_Spec;
      Templates_Parser.Utils'Elab_Spec;
      E640 := E640 + 1;
      AWS.UTILS'ELAB_SPEC;
      AWS.UTILS'ELAB_BODY;
      E576 := E576 + 1;
      AWS.RESOURCES'ELAB_SPEC;
      AWS.RESOURCES.STREAMS'ELAB_SPEC;
      AWS.RESOURCES.STREAMS'ELAB_BODY;
      E620 := E620 + 1;
      AWS.RESOURCES.STREAMS.DISK'ELAB_SPEC;
      AWS.RESOURCES.STREAMS.DISK'ELAB_BODY;
      E636 := E636 + 1;
      AWS.RESOURCES.STREAMS.MEMORY'ELAB_SPEC;
      AWS.RESOURCES.STREAMS.MEMORY'ELAB_BODY;
      E628 := E628 + 1;
      E616 := E616 + 1;
      AWS.RESOURCES.STREAMS.ZLIB'ELAB_SPEC;
      AWS.RESOURCES.STREAMS.ZLIB'ELAB_BODY;
      E622 := E622 + 1;
      AWS.RESOURCES.EMBEDDED'ELAB_BODY;
      E618 := E618 + 1;
      E634 := E634 + 1;
      Templates_Parser'Elab_Body;
      E611 := E611 + 1;
      E638 := E638 + 1;
      AWS.NET'ELAB_SPEC;
      AWS.NET.LOG'ELAB_BODY;
      E574 := E574 + 1;
      AWS.NET.POLL_EVENTS'ELAB_SPEC;
      AWS.NET.POLL_EVENTS'ELAB_BODY;
      E646 := E646 + 1;
      AWS.NET.STD'ELAB_SPEC;
      AWS.NET.STD'ELAB_BODY;
      E650 := E650 + 1;
      AWS.NET.SSL'ELAB_SPEC;
      AWS.NET.SSL'ELAB_BODY;
      E648 := E648 + 1;
      AWS.NET'ELAB_BODY;
      E572 := E572 + 1;
      E748 := E748 + 1;
      AWS.NET.ACCEPTORS'ELAB_SPEC;
      AWS.NET.ACCEPTORS'ELAB_BODY;
      E770 := E770 + 1;
      AWS.NET.MEMORY'ELAB_SPEC;
      AWS.NET.MEMORY'ELAB_BODY;
      E750 := E750 + 1;
      AWS.NET.SSL.CERTIFICATE'ELAB_SPEC;
      E785 := E785 + 1;
      E783 := E783 + 1;
      AWS.RESOURCES.STREAMS.DISK.ONCE'ELAB_SPEC;
      AWS.RESOURCES.STREAMS.DISK.ONCE'ELAB_BODY;
      E699 := E699 + 1;
      AWS.RESOURCES.STREAMS.MEMORY.ZLIB'ELAB_SPEC;
      AWS.RESOURCES.STREAMS.MEMORY.ZLIB'ELAB_BODY;
      E673 := E673 + 1;
      AWS.TRANSLATOR'ELAB_BODY;
      E671 := E671 + 1;
      AWS.DIGEST'ELAB_BODY;
      E691 := E691 + 1;
      AWS.NET.BUFFERED'ELAB_SPEC;
      AWS.NET.BUFFERED'ELAB_BODY;
      E668 := E668 + 1;
      AWS.CONFIG'ELAB_SPEC;
      AWS.CONFIG'ELAB_BODY;
      E681 := E681 + 1;
      E685 := E685 + 1;
      E683 := E683 + 1;
      AWS.HEADERS'ELAB_SPEC;
      AWS.HEADERS'ELAB_BODY;
      E567 := E567 + 1;
      AWS.HEADERS.VALUES'ELAB_BODY;
      E675 := E675 + 1;
      AWS.MESSAGES'ELAB_SPEC;
      E677 := E677 + 1;
      AWS.MIME'ELAB_BODY;
      E679 := E679 + 1;
      AWS.ATTACHMENTS'ELAB_SPEC;
      AWS.ATTACHMENTS'ELAB_BODY;
      E565 := E565 + 1;
      E705 := E705 + 1;
      AWS.SERVICES.TRANSIENT_PAGES'ELAB_SPEC;
      AWS.SERVICES.TRANSIENT_PAGES'ELAB_BODY;
      E774 := E774 + 1;
      E776 := E776 + 1;
      AWS.UTILS.STREAMS'ELAB_SPEC;
      E725 := E725 + 1;
      AWS.SESSION'ELAB_SPEC;
      AWS.SESSION'ELAB_BODY;
      E721 := E721 + 1;
      E778 := E778 + 1;
      AWS.PARAMETERS'ELAB_SPEC;
      AWS.URL'ELAB_SPEC;
      AWS.STATUS'ELAB_SPEC;
      E709 := E709 + 1;
      AWS.RESPONSE'ELAB_SPEC;
      AWS.CLIENT'ELAB_SPEC;
      AWS.DISPATCHERS'ELAB_SPEC;
      AWS.DISPATCHERS'ELAB_BODY;
      E707 := E707 + 1;
      AWS.DISPATCHERS.CALLBACK'ELAB_SPEC;
      AWS.DISPATCHERS.CALLBACK'ELAB_BODY;
      E731 := E731 + 1;
      AWS.HOTPLUG'ELAB_SPEC;
      E756 := E756 + 1;
      E766 := E766 + 1;
      AWS.LOG'ELAB_SPEC;
      AWS.LOG'ELAB_BODY;
      E733 := E733 + 1;
      AWS.NET.WEBSOCKET'ELAB_SPEC;
      AWS.NET.WEBSOCKET.HANDSHAKE_ERROR'ELAB_SPEC;
      AWS.NET.WEBSOCKET.HANDSHAKE_ERROR'ELAB_BODY;
      E758 := E758 + 1;
      AWS.NET.WEBSOCKET.PROTOCOL'ELAB_SPEC;
      E738 := E738 + 1;
      AWS.NET.WEBSOCKET.PROTOCOL.DRAFT76'ELAB_SPEC;
      AWS.NET.WEBSOCKET.PROTOCOL.DRAFT76'ELAB_BODY;
      E740 := E740 + 1;
      AWS.NET.WEBSOCKET.PROTOCOL.RFC6455'ELAB_SPEC;
      AWS.NET.WEBSOCKET.PROTOCOL.RFC6455'ELAB_BODY;
      E742 := E742 + 1;
      AWS.NET.WEBSOCKET.REGISTRY'ELAB_SPEC;
      AWS.NET.WEBSOCKET.REGISTRY'ELAB_BODY;
      E746 := E746 + 1;
      E752 := E752 + 1;
      E760 := E760 + 1;
      E689 := E689 + 1;
      AWS.RESPONSE'ELAB_BODY;
      E697 := E697 + 1;
      AWS.SERVER'ELAB_SPEC;
      AWS.PARAMETERS'ELAB_BODY;
      E711 := E711 + 1;
      E701 := E701 + 1;
      AWS.SERVER.HTTP_UTILS'ELAB_SPEC;
      E768 := E768 + 1;
      E762 := E762 + 1;
      AWS.NET.WEBSOCKET'ELAB_BODY;
      E737 := E737 + 1;
      AWS.SERVER.HTTP_UTILS'ELAB_BODY;
      E754 := E754 + 1;
      E780 := E780 + 1;
      AWS.SERVER'ELAB_BODY;
      E703 := E703 + 1;
      E715 := E715 + 1;
      E717 := E717 + 1;
      AWS.CLIENT'ELAB_BODY;
      E563 := E563 + 1;
      E764 := E764 + 1;
      E744 := E744 + 1;
      AWS.URL'ELAB_BODY;
      E713 := E713 + 1;
      E787 := E787 + 1;
      Util.Http.Clients.Aws'Elab_Spec;
      Util.Http.Clients.Aws'Elab_Body;
      E560 := E560 + 1;
      Util.Http.Clients.Aws.Tests'Elab_Spec;
      Util.Http.Clients.Aws.Tests'Elab_Body;
      E790 := E790 + 1;
      Util.Testsuite'Elab_Body;
      E407 := E407 + 1;
   end adainit;

   procedure Ada_Main_Program;
   pragma Import (Ada, Ada_Main_Program, "_ada_util_harness");

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
   --   /home/scada/Downloads/ada-util-master/obj/util-perfect_hash.o
   --   /home/scada/Downloads/ada-util-master/obj/util-beans-objects-datasets-tests.o
   --   /home/scada/Downloads/ada-util-master/obj/util-beans-objects-discrete_tests.o
   --   /home/scada/Downloads/ada-util-master/obj/util-beans-objects-discretes.o
   --   /home/scada/Downloads/ada-util-master/obj/util-beans-objects-record_tests.o
   --   /home/scada/Downloads/ada-util-master/obj/util-beans-objects-tests.o
   --   /home/scada/Downloads/ada-util-master/obj/util-beans-ranges-tests.o
   --   /home/scada/Downloads/ada-util-master/obj/util-commands-tests.o
   --   /home/scada/Downloads/ada-util-master/obj/util-concurrent-tests.o
   --   /home/scada/Downloads/ada-util-master/obj/util-dates-formats-tests.o
   --   /home/scada/Downloads/ada-util-master/obj/util-dates-tests.o
   --   /home/scada/Downloads/ada-util-master/obj/util-encoders-ecc-tests.o
   --   /home/scada/Downloads/ada-util-master/obj/util-encoders-kdf-tests.o
   --   /home/scada/Downloads/ada-util-master/obj/util-encoders-tests.o
   --   /home/scada/Downloads/ada-util-master/obj/util-events-channels-tests.o
   --   /home/scada/Downloads/ada-util-master/obj/util-events-timers-tests.o
   --   /home/scada/Downloads/ada-util-master/obj/util-files-tests.o
   --   /home/scada/Downloads/ada-util-master/obj/util-http-cookies-tests.o
   --   /home/scada/Downloads/ada-util-master/obj/util-listeners-tests.o
   --   /home/scada/Downloads/ada-util-master/obj/util-locales-tests.o
   --   /home/scada/Downloads/ada-util-master/obj/util-log-tests.o
   --   /home/scada/Downloads/ada-util-master/obj/util-mail-tests.o
   --   /home/scada/Downloads/ada-util-master/obj/util-nullables-tests.o
   --   /home/scada/Downloads/ada-util-master/obj/util-processes-tests.o
   --   /home/scada/Downloads/ada-util-master/obj/util-properties-bundles-tests.o
   --   /home/scada/Downloads/ada-util-master/obj/util-properties-form-tests.o
   --   /home/scada/Downloads/ada-util-master/obj/util-properties-json-tests.o
   --   /home/scada/Downloads/ada-util-master/obj/util-properties-tests.o
   --   /home/scada/Downloads/ada-util-master/obj/util-serialize-io-form-tests.o
   --   /home/scada/Downloads/ada-util-master/obj/util-serialize-io-json-tests.o
   --   /home/scada/Downloads/ada-util-master/obj/util-serialize-io-xml-tests.o
   --   /home/scada/Downloads/ada-util-master/obj/util-serialize-tools-tests.o
   --   /home/scada/Downloads/ada-util-master/obj/util-streams-buffered-tests.o
   --   /home/scada/Downloads/ada-util-master/obj/util-streams-files-tests.o
   --   /home/scada/Downloads/ada-util-master/obj/util-streams-tests.o
   --   /home/scada/Downloads/ada-util-master/obj/util-streams-texts-tests.o
   --   /home/scada/Downloads/ada-util-master/obj/util-strings-tests.o
   --   /home/scada/Downloads/ada-util-master/obj/util-systems-dlls-tests.o
   --   /home/scada/Downloads/ada-util-master/obj/util-systems-os-tests.o
   --   /home/scada/Downloads/ada-util-master/obj/util-http-clients-tests.o
   --   /home/scada/Downloads/ada-util-master/obj/util-streams-sockets-tests.o
   --   /home/scada/Downloads/ada-util-master/obj/util-texts-builders_tests.o
   --   /home/scada/Downloads/ada-util-master/obj/util-http-clients-aws-tests.o
   --   /home/scada/Downloads/ada-util-master/obj/util-testsuite.o
   --   /home/scada/Downloads/ada-util-master/obj/util_harness.o
   --   -L/home/scada/Downloads/ada-util-master/obj/
   --   -L/home/scada/Downloads/ada-util-master/obj/
   --   -L/home/scada/Downloads/ada-util-master/lib/utilada_core/static/
   --   -L/home/scada/Downloads/ada-util-master/lib/utilada_sys/static/
   --   -L/home/scada/Downloads/ada-util-master/lib/utilada_aws/static/
   --   -L/opt/GNAT/2019/lib/aws.static/
   --   -L/opt/GNAT/2019/lib/xmlada/xmlada_schema.static/
   --   -L/opt/GNAT/2019/lib/xmlada/xmlada_sax.static/
   --   -L/opt/GNAT/2019/lib/xmlada/xmlada_unicode.static/
   --   -L/opt/GNAT/2019/lib/xmlada/xmlada_input.static/
   --   -L/opt/GNAT/2019/lib/xmlada/xmlada_dom.static/
   --   -L/home/scada/Downloads/ada-util-master/lib/utilada_unit/static/
   --   -L/home/scada/Downloads/ada-util-master/lib/utilada_xml/static/
   --   -L/opt/GNAT/2019/lib/gcc/x86_64-pc-linux-gnu/8.3.1/adalib/
   --   -static
   --   -ldl
   --   -lgnarl
   --   -lgnat
   --   -lrt
   --   -lpthread
   --   -ldl
--  END Object file/option list   

end ada_main;
