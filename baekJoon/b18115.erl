-module(b18115).
-export([for/2,start/0]).
-import(lists,[last/1,droplast/1,append/2,nth/2,delete/2]).

for([],Term)->
    Term;

    for(Input,Term) when length(Input)>0->
        InputElement=last(Input),
        NewInput=droplast(Input),
        % io:format("NewInput : ~p~n",[NewInput]),
        NewTerm =
            case length(Term) of
                0 ->
                    append(Term,[length(Term)+1]);
                _ ->
                    case InputElement of
                        1 ->
                            append([length(Term)+1],Term);
                        2 ->
                            Element=nth(1,Term),
                            DeleteTerm=delete(Element,Term),
                            AppendTerm=append([length(Term)+1],DeleteTerm),
                            append([Element],AppendTerm);
                        3 ->
                            append(Term,[length(Term)+1]);
                        _ ->
                            Term
                    end
            end,
        % io:format("NewTerm : ~p~n",[NewTerm]),
        for(NewInput,NewTerm).

start()->
    % {ok,[N]}=io:fread("","~d"),
    Input=string:trim(io:get_line("")),
    InputSplit=string:split(Input," ",all),
    InputList=[list_to_integer(S)||S<-InputSplit],
    io:format("~w~n",[for(InputList,[])]).