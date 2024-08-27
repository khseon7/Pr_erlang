-module(my_timer).
-export([start/0]).

start()->
    io:format("Enter time in seconds: "),

    {ok,[N]}=io:fread("","~d"),

    erlang:send_after(N*1000,self(), hello),

    receive
        hello ->
            io:format("Hello, World!~n")
    end.