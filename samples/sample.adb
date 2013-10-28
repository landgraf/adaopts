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
with AdaOpts_Parsers; use AdaOpts_Parsers;
with CMD_Options_Lists; use CMD_Options_Lists;
with Ada.Text_Io; use Ada.Text_Io;

procedure sample  is 
    parser :Any_AdaOpts_Parser := new AdaOpts_Parser;
    options : cmd_options_list_access;
begin
    parser.add_option(
        Long  => "version",
        Short => "v",
        Value => False,
        Doc => "Print version",
        Dest => "version"
        );
    parser.add_option(
        Long  => "help",
        Short => "h",
        Value => False,
        Doc => "Print help and exit",
        Dest => "help"
        );
    parser.add_option(
        Long => "memory",
        Short => "m",
        Value => True,
        Doc => "Set memory size",
        Dest => "memory"
        );
    parser.Print_Options_List;
    parser.parse;
    if parser.has_option("memory") then
        Put_Line("Passed, value is " & parser.option("memory").value);
    end if;
    AdaOpts_Parsers.free_parser(parser);
end sample;
