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
with Ada.Command_line; use Ada.Command_Line;
with adaopts_available_options;
with Ada.Text_IO; use Ada.Text_IO;
with Gnat.OS_Lib;
package body CMD_Options is 

    function Value( This : in CMD_Option) return String is 
    begin
        return To_String(This.Value);
    end Value;
    function Name( This : in CMD_Option) return String is 
    begin 
        return To_String(This.Name);
    end Name;

    function Name( This : in CMD_Option) return Unbounded_String is 
    begin
        return This.Name;
    end Name;

    function Option( This : in CMD_Option) return Any_AdaOpts_Option  is 
    begin
        return This.Option;
    end Option;
    -- Long options
    function Init(N : in Integer; Eq : in Boolean := False; Eq_Pos : Natural := 0) return Any_CMD_Option is 
        opt : Any_CMD_Option := new CMD_Option; 
        -- Shrink "--"
        curopt : String := Ada.Command_line.Argument(N)(3..Ada.Command_line.Argument(N)'Length);
    begin
        if not Eq then
            if adaopts_available_options.Contains_Option(curopt) then
                opt.option := adaopts_available_options.Get_Option(curopt);
                opt.Name := opt.option.Dest;
                if opt.option.all in AdaOpts_Option_Valued then
                    raise MAILFORMED_OPTION;
                end if;
            else
                raise INCORRECT_OPTION;
            end if;
        else 
            if adaopts_available_options.Contains_Option(curopt(3..Eq_Pos-1)) then 
                opt.option := adaopts_available_options.Get_Option(curopt(3..Eq_Pos-1));
                opt.Name := opt.option.Dest;
                if opt.option.all not  in AdaOpts_Option_Valued  then
                    raise MAILFORMED_OPTION;
                end if;
            else
                raise INCORRECT_OPTION;
            end if;
                
        end if;
        return opt;
    exception
        when CONSTRAINT_ERROR => 
            Put_Line("You must specify value for option:" & curopt);
            Gnat.OS_Lib.Os_Exit(1);
    end Init;

    function Init(Arg : in Integer; Pos : in Integer) return Any_CMD_Option is 
        opt : Any_CMD_Option := new CMD_Option; 
        curopt : Character := Ada.Command_line.Argument(Arg)(Pos);
    begin
        if adaopts_available_options.Contains_Option(curopt) then
            opt.option := adaopts_available_options.Get_Option(curopt);
            opt.Name := opt.option.Dest;
            if opt.option.all in AdaOpts_Option_Valued then
                opt.value :=  To_Unbounded_String(Ada.Command_line.Argument(Arg+1));
            end if;
        else
            raise INCORRECT_OPTION;
        end if;
        return opt;
    end Init;

    procedure Free_Option(This : in out Any_CMD_Option) is 
    begin
        Free(This);
    end Free_Option;
end CMD_Options; 
