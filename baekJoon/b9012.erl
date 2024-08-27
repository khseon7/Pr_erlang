-module(b9012).
-export([for/1,for/2,ps/0,start/0]).
-import(lists,[nth/2,append/2]).

for([],Term)->
    case length(Term) of
        0 -> "YES";
        _ -> "NO"
    end;
    
    for(List,Term) when length(List)>0 ->
        N=1,
        Element=nth(N,List),
        % io:format("~w's element is ~p~n",[N,Element]),
        case Element of
            40->
                NewTerm=append([Element],Term);
            41->
                NewTerm = case length(Term) of
                    0->append([Element],Term);
                    _->lists:droplast(Term)
                end;
            _->
                NewTerm=Term
        end,
        NewList=lists:delete(Element,List),
        % io:format("~p~n",[NewTerm]),
        for(NewList,NewTerm).

ps()->
    Input=string:trim(io:get_line("")),
    % io:format("~w, ~p~n",[length(Input),Input]),
    for(Input,[]).

for(1) -> io:format("~p~n",[ps()]);
for(N) when N>1->
    io:format("~p~n",[ps()]),
    for(N-1).


start()->
    {ok, [N]} = io:fread("", "~d"), % {ok, [N]} 형식으로 반환됨 
    for(N).