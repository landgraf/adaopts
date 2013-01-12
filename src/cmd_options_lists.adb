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
with Ada.Text_Io; use Ada.Text_Io;
package body CMD_Options_Lists is 

    function Has_option(Name : String) return Boolean is 
    begin
        if Options_List.Has_Opt(To_Unbounded_String(NAme)) then 
            return True;
        end if;
        return False;
    end Has_option;
    procedure Add(option : in Any_CMD_Option) is 
    begin
        Options_List.Add_Option(Option);
    exception 
        when CONSTRAINT_ERROR => 
            Put_Line("Option already included, ignorring!!! " & Option.Name);
    end Add;

    function Option(Name : String) return Any_CMD_Option is 
    begin
        return Options_List.Opt(To_Unbounded_String(Name));
    end Option;

    protected body Options_List is 
        procedure Add_Option(option : Any_CMD_Option) is 
        begin
            options.Insert(option.Name, option);
        end Add_Option;
        function Has_Opt(Name : Unbounded_String) return Boolean is 
        begin
            if options.Contains(Name) then
                return True;
            end if;
            return False;
        end Has_Opt;
        function Opt(Name : Unbounded_String) return Any_CMD_Option is 
        begin
            return options.Element(Name);
        end Opt;
        procedure Free_Opts is 
            cur :adaopt_cmd_options_map.Cursor := options.First;
            element : Any_Cmd_Option;
        begin
            for I in 1..options.Length loop 
                exit when not adaopt_cmd_options_map.Has_Element(cur);
                element := adaopt_cmd_options_map.Element(cur);
                Cmd_Options.Free_Option(element);
                adaopt_cmd_options_map.Next(cur);
            end loop;
        end Free_Opts;

    end Options_List;
    procedure Free is 
    begin
        Options_List.Free_Opts; 
    end Free;
end CMD_Options_Lists;
