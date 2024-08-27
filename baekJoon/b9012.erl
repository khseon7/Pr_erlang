-module(b9012).
-export([for/2,for/3,ps/0,start/0]).

for(List,Term)->
    for(List,Term,1).

for([],Term,_N)->
    case length(Term) of
        0 -> "YES";
        _ -> "NO"
    end;
    
    for(List,Term,N) when length(List)>0 ->
        io:format("1st ~p~n",[lists:nth(N,List)]),
        NewTerm=lists:append(lists:nth(N,List),Term),
        NewList=lists:delete(lists:nth(N,List),List),
        io:format("~p~n",[NewTerm]),
        for(NewList,NewTerm,N+1).

ps()->
    Input=[string:trim(io:get_line(""))],
    for(Input,[]).

start()->
    ps().