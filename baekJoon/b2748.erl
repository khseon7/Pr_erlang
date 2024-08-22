-module(b2748).
-export([for/2,start/0]).
-import(lists,[sum/1,nthtail/2,append/2]).

for(2,Fibo)->
    lists:last(Fibo);

    for(N,Fibo) when N>2->
        io:format("~p~n",[Fibo]),
        SemiFibo=nthtail(length(Fibo)-2,Fibo),
        io:format("~p~n",[sum(SemiFibo)]),
        NewFibo=append(Fibo,[sum(SemiFibo)]),
        for(N-1,NewFibo).

start()->
    Fibo=lists:duplicate(2,1),
    io:format("Enter a number : "),
    {ok,[Number]}=io:fread("","~d"),
    case Number of
        1 -> io:format("Fibo ~p is ~p~n",[Number,1]);
        2 -> io:format("Fibo ~p is ~p~n",[Number,1]);
        _->
            Results=for(Number,Fibo),
            io:format("Fibo ~p is ~p~n",[Number,Results])
    end.
