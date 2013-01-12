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
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings.Fixed;
with Ada.Command_line; use Ada.Command_Line;

package body adaopts_parsers is 

    procedure add_option(
        Self : adaopts_parser; 
        Long : String;
        Short : String;
        Value : Boolean;
        Doc : String;
        Dest : String) is 
        option : Any_AdaOpts_Option;--  := new AdaOpts_Option;
    begin
        if value then 
            option := new  AdaOpts_Option_Valued; 
        else 
            option := new AdaOpts_Option;
        end if;
        option.Set_Doc(Doc);
        option.Set_Dest(Dest);
        adaopts_available_options.Add(
            Short_Name => To_Unbounded_String(Short), 
            Long_Name => To_Unbounded_String(Long), 
            Option => option
            );
    end add_option;

    function has_option(
        Self : adaopts_parser;
        Opt : String
    ) return Boolean is 
    begin
        return CMD_Options_Lists.has_option(Opt);
    end Has_Option;

    function option(
        Self : adaopts_parser;
        Opt : String
        ) return ANy_CMD_Option is
    begin
        return CMD_Options_Lists.option(Opt);
    end option;
    procedure Print_Options_List(
        Self : adaopts_parser) is 
        arr : options_array(1..Get_Options_Count) := Get_Options;
    begin
        Put_Line("Available options:");
        for I in 1..arr'Length loop
            Put_Line(To_String(arr(I)));
        end loop;
    end Print_Options_List;

    procedure parse(
        Self : adaopts_parser
        )  is 
    begin
        if Argument_Count = 0 then 
            return;
        end if;
        for I in 1..Argument_Count loop 
            if Argument(I)(1) = '-' then
                if Argument(I)(2) = '-' then
                    if Ada.Strings.Fixed.Index(Argument(I),"=") /= 0 then
                        Cmd_Options_Lists.add(Cmd_Options.Init(I, True, Ada.Strings.Fixed.Index(Argument(I),"=")));
                    else
                        Cmd_Options_Lists.add(Cmd_Options.Init(I, False, Integer'Last));
                    end if;
                else 
                    for J in 2..Argument(I)'Length loop
                        Cmd_Options_Lists.add(Cmd_Options.Init(I,J));
                    end loop;
                end if;
            end if;
        end loop;
    end parse;

    procedure Free_Parser(This: in out any_adaopts_parser) is 
    begin
        adaopts_available_options.Free;
        CMD_Options_Lists.Free;
        AdaOpts_Parsers.Free(This);
    end free_parser;
end adaopts_parsers;
