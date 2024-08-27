-module(b2164).
-export([for/1,for/2,start/0]).
-import(lists,[nth/2,append/2,delete/2,reverse/1]).

for(0,Term)->
    Term;

    for(N,Term) when N>0->
        NewTerm=append([N],Term),
        for(N-1,NewTerm).

for(Term) when length(Term)==1->
    hd(Term);

    for(Term) when length(Term)>1->
        DeleteTerm=delete(nth(1,Term),Term),
        Element=nth(1,DeleteTerm),
        NewDeleteTerm=delete(Element,DeleteTerm),
        % io:format("NewDeleteTerm - ~w~n",[NewDeleteTerm]),
        NewTerm=append(NewDeleteTerm,[Element]),
        % io:format("NewTerm - ~w~n",[NewTerm]),
        for(NewTerm).

start() ->
    {ok,[N]}=io:fread("","~d"),
    NumList=for(N,[]),
    % io:format("~w~n",[NumList]),
    io:format("~p~n",[for(NumList)]).