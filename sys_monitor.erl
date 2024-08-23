-module(sys_monitor).
-export([start/0, monitor/2, collect_data/0, alert_if_needed/1, log_data/1]).

-record(system_memory, {total_memory, free_memory, buffered_memory,
                       cached_memory, swap_memory, free_swap}).
-compile({no_auto_import, [monitor/2]}).

%% Start the monitoring system
start() ->
    case application:start(os_mon) of
        ok -> 
            Interval = 5000,
            spawn(fun() -> monitor(Interval, []) end);
        {error, Reason} -> 
            io:format("Failed to start os_mon: ~p~n", [Reason])
    end.

%% Monitor function that runs in a loop
monitor(Interval, Logs) ->
    Data = collect_data(),
    log_data(Data),
    alert_if_needed(Data),
    timer:sleep(Interval),
    monitor(Interval, [Data | Logs]).

%% Function to collect system data (e.g., CPU, Memory)
collect_data() ->
    case cpu_usage() of
        {ok, CpuUsage} ->
            MemUsage = memory_usage(),
            {CpuUsage, MemUsage};
        {error, Reason} ->
            io:format("Failed to collect CPU usage: ~p~n", [Reason]),
            {0, memory_usage()}
    end.

%% Function to retrieve CPU usage
cpu_usage() ->
    case cpu_sup:avg1() of
        {ok, [{Avg1, _, _, _}]} -> 
            {ok, Avg1};
        Error -> 
            {error, Error}
    end.

%% Function to retrieve memory usage
memory_usage() ->
    {ok, MemData} = memsup:get_system_memory_data(),
    TotalMemory = MemData#system_memory.total_memory,
    FreeMemory = MemData#system_memory.free_memory,
    UsedMemory = TotalMemory - FreeMemory,
    MemUsagePercent = (UsedMemory * 100) div TotalMemory,
    MemUsagePercent.

%% Function to log the collected data
log_data({CpuUsage, MemUsage}) ->
    io:format("CPU Usage: ~p% | Memory Usage: ~p%~n", [CpuUsage, MemUsage]).

%% Function to check if an alert should be triggered
alert_if_needed({CpuUsage, MemUsage}) ->
    CPUThreshold = 90,
    MemThreshold = 90,
    case CpuUsage > CPUThreshold of
        true -> io:format("ALERT: CPU usage is too high! (~p%)~n", [CpuUsage]);
        false -> ok
    end,
    case MemUsage > MemThreshold of
        true -> io:format("ALERT: Memory usage is too high! (~p%)~n", [MemUsage]);
        false -> ok
    end.
