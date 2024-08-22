-module(b2748).
-export([for/2,start/0]).
-import(lists,[sum/1,nthtail/2,append/2]).

for(2,Fibo)->
    lists:last(Fibo); % Fibo의 마지막 요소를 리턴

    for(N,Fibo) when N>2-> % Fibo(2,_)가 될때까지 실행
        io:format("~p~n",[Fibo]), % Fibo 출력
        SemiFibo=nthtail(length(Fibo)-2,Fibo), % Fibo의 마지막 2개 요소를 SemiFibo에 저장
        io:format("~p~n",[sum(SemiFibo)]), % SemiFibo에 있는 요소들의 합 출력
        NewFibo=append(Fibo,[sum(SemiFibo)]), % Fibo의 맨 뒤에 SemiFibo에 있는 요소들의 합 추가
        for(N-1,NewFibo). % 재귀

start()->
    Fibo=lists:duplicate(2,1), % [1,1] 리스트 생성
    io:format("Enter a number : "),
    {ok,[Number]}=io:fread("","~d"), % 사용자에게 숫자 입력받기
    case Number of % 입력받은 숫자가 1,2면 1을 출력, 그게 아니면 Fibo값으로 출력
        1 -> io:format("Fibo ~p is ~p~n",[Number,1]);
        2 -> io:format("Fibo ~p is ~p~n",[Number,1]);
        _->
            Results=for(Number,Fibo),
            io:format("Fibo ~p is ~p~n",[Number,Results])
    end.
