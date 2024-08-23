-module(b2749).
-export([for/2,start/0]).
-import(lists,[sum/1,nthtail/2,last/1,append/2]).

for(2,Term) ->
    Term;

    for(N,Term) when N>2 ->
        Mod=1000000,
        NewTerm=append(Term,[sum(nthtail(length(Term) - 2, Term)) rem Mod]),
        for(N-1,NewTerm).

start() ->
    Fibo=lists:duplicate(2,1),
    io:format("Enter the Number : "),
    {ok,[Number]}=io:fread("","~d"),
    case Number of
        1 -> io:format("Fibo(~p)=~p~n",[Number,1]);
        2 -> io:format("Fibo(~p)=~p~n",[Number,1]);
        _->
            Results=for(Number,Fibo),
            % io:format("Fibo = ~w~n",[Results]),
            io:format("Fibo(~p)=~p~n",[Number,last(Results)])
    end.