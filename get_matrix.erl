-module(get_matrix).
-export([for/2,start/0]).
-import(string,[trim/1,split/3]).

for(0,Term)->
    Term;

    for(N,Term) when N>0->
        Input=io:get_line("Enter Row Elements : "),
        InputTrimmed=trim(Input),
        StringList=split(InputTrimmed," ",all),
        IntegerList=[list_to_integer(S) || S<-StringList],
        io:format("~w~n",[IntegerList]),
        NewTerm=Term ++ IntegerList,
        for(N-1,NewTerm).

start() ->
    {ok,[Number]}=io:fread("","~d"),
    Results=for(Number,[]),
    io:format("~w~n",[Results]).