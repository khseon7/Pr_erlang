-module(get_matrix).
-export([start/0]).

start() ->
    Input=io:get_line("Enter numbers : "),
    InputTrimmed=string:trim(Input),
    StringList=string:split(InputTrimmed," ",all),
    IntegerList=[list_to_integer(S) || S<-StringList],
    io:format("Integer List: ~p~n",[IntegerList]),
    IntegerList.