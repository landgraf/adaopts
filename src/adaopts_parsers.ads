------------------------------------------------------------------------------
--                              Ada OptParser                               --
--                                                                          --
--                     Copyright (C) 2012, Pavel Zhukov                     --
--                                                                          --
--  This is free software;  you can redistribute it  and/or modify it       --
--  under terms of the  GNU General Public License as published  by the     --
--  Free Software  Foundation;  either version 3,  or (at your option) any  --
--  later version.  This software is distributed in the hope  that it will  --
--  be useful, but WITHOUT ANY WARRANTY;  without even the implied warranty --
--  of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU     --
--  General Public License for  more details.                               --
--                                                                          --
--  You should have  received  a copy of the GNU General  Public  License   --
--  distributed  with  this  software;   see  file COPYING3.  If not, go    --
--  to http://www.gnu.org/licenses for a complete copy of the license.      --
------------------------------------------------------------------------------
with CMD_Options_Lists; use CMD_Options_Lists;
with CMD_Options; use CMD_Options;
with adaopts_available_options; use adaopts_available_options;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with AdaOpts_Options; use AdaOpts_Options;
with AdaOpts_Options_Valued; use AdaOpts_Options_Valued;
with Ada.Unchecked_Deallocation;

package adaopts_parsers is 
    type adaopts_parser is tagged limited private;
    type adaopts_parser_access is access all adaopts_parser;
    type any_adaopts_parser is access all adaopts_parser'Class;

    procedure Free_Parser(This: in out any_adaopts_parser);


    procedure add_option(
        Self : adaopts_parser; 
        Long : String;
        Short : String;
        Value : Boolean;
        Doc : String;
        Dest : String);

    procedure Print_Options_List(
        Self : adaopts_parser);

    procedure parse(
        Self : adaopts_parser
        );

    function has_option(
        Self : adaopts_parser;
        Opt : String
        ) return Boolean;

    function option(
        Self : adaopts_parser;
        Opt : String
        ) return ANy_CMD_Option;

    private
    type adaopts_parser is tagged limited null record;
    procedure Free is new Ada.Unchecked_Deallocation (AdaOpts_Parser'Class, Any_AdaOpts_Parser);

end adaopts_parsers;
