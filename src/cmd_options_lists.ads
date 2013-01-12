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
with Ada.Containers.Ordered_Maps;  use Ada.Containers;
with AdaOpts_Options; use AdaOpts_Options;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with CMD_Options; use CMD_Options; 

package CMD_Options_Lists is 
    type cmd_options_list_type is tagged limited private;
    type any_cmd_options_list_type is access all cmd_options_list_type'Class;
    package adaopt_cmd_options_map is new Ada.Containers.Ordered_Maps(
        Key_Type => Unbounded_String,
        Element_Type => Any_Cmd_Option
    );
    subtype cmd_options_list is adaopt_cmd_options_map.Map;
    type cmd_options_list_access is access all cmd_options_list;

    function Has_option( Name : String) return Boolean;
    function Option(Name : String) return Any_CMD_Option;
    procedure Add(option : in Any_CMD_Option);
    procedure Free;
    private 
    type cmd_options_list_type is tagged limited null record;
    protected Options_List is 
        procedure Add_Option(option : Any_CMD_Option);
        procedure Free_Opts;
        function Has_Opt(Name : Unbounded_String) return Boolean;
        function Opt(Name : Unbounded_String) return Any_CMD_Option;
        private
        options : cmd_options_list;
    end Options_List;

end CMD_Options_Lists;
