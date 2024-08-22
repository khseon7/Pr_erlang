-module(factorial).
-export([for/2,start/0]).

for(0,Term) ->
    Term;

    for(N,Term) when N>0->
        % io:fwrite("~w~n",[Term]),
        for(N-1,Term*N).
start()->
    io:format("Enter a number : "),
    {ok,[Number]}=io:fread("","~d"),
    io:format("You entered: ~p~n",[Number]),
    Num=for(Number,1),
    io:format("And Facorial ~p is ~p~n.",[Number,Num]).