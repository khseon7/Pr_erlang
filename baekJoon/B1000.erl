-module(b1000).
-export([start/0]).
start() ->
    % io:get_line -> stdin에서 줄을 읽고 표시한다.
    Input=io:get_line(""),
    % string:trim -> Input에 있는 개행문자(\n) 제거한다.
    CleanInput=string:trim(Input),
    % string:split -> 문장 전체를 " "으로 나눈다.
    NumberAsStrings=string:split(CleanInput," ",all),
    % NumberAsStrings의 각 요소에 대해 개행문자를 지우고 숫자로 변경하여 리스트로 만든다.
    Numbers=lists:map(fun(S)->list_to_integer(string:trim(S)) end, NumberAsStrings),
    % list 요소들의 합을 출력한다.
    io:format("~p~n",[lists:sum(Numbers)]).