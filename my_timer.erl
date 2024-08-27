-module(my_timer).
-export([start/0]).

start()->
    io:format("Enter time in seconds: "),

    {ok,[N]}=io:fread("","~d"),

    erlang:send_after(1000,self(),{tick,1}),

    erlang:send_after(N*1000, self(), hello),
    
    loop(N).

loop(N)->
    receive
        {tick, Sec}->
            io:format("~p second(s) passed~n",[Sec]),
            erlang:send_after(1000,self(),{tick,Sec+1}),
            loop(N);
        hello ->
            io:format("Hello, World!~n")
    end.