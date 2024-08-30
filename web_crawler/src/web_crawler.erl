-module(web_crawler).
-export([start/1, crawl/2,fetch_url/1,extract_links/1]).

% HTTP 클라이언트를 사용하여 페이지를 가져옵니다.
fetch_url(URL) ->
    %% Ensure inets is started before making HTTP requests
    case application:ensure_all_started(inets) of
        {ok, _} -> 
            io:format("inets started successfully~n"),
            case string:find(URL,"http://") of
                URL->
                    %% Set up HTTP headers, including User-Agent
                    Headers = [{"User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36"}],
                    %% Send HTTP GET request
                    case httpc:request(get, {URL, Headers}, [], []) of
                        {ok, {{Version, StatusCode, ReasonPhrase}, Headers, Body}} ->
                            %% Log the entire response for debugging
                            io:format("Response: ~p~n", [{Version, StatusCode, ReasonPhrase, Headers, Body}]),
                            case StatusCode of
                                200 -> Body;
                                _ ->
                                    %% Handle non-200 responses
                                    io:format("Error: HTTP Status Code ~p, Reason: ~s~n", [StatusCode, ReasonPhrase]),
                                    <<>> %% Return empty body on error
                            end;
                        {error, HttpReason} ->
                            %% Handle errors in the HTTP request itself
                            io:format("HTTP Request Error: ~p~n", [HttpReason]),
                            <<>> %% Return empty body on error
                    end;
                nomatch ->
                    io:format("Invalid URL format. URL must start with 'http://' or 'https://'.~n"),
                    <<>>
            end;
        {error, StartReason} -> 
            io:format("Failed to start inets: ~p~n", [StartReason]),
            exit(StartReason)
    end.


% 페이지의 링크를 추출합니다.
extract_links(Body) ->
    %% HTML 파싱을 위한 라이브러리 사용 (예: floki)
    %% 여기는 간단한 정규식으로 처리 (추천하지 않음, 라이브러리 사용 권장)
    case re:compile("<a[^>]+href=[\"']?([^\"'>]+)[\"']?") of
        {ok, Re} ->
            %% 정규식을 이용해 링크 추출
            case re:run(Body, Re, [{capture, all, list}]) of
                {match, Links} -> Links;
                nomatch -> []
            end;
        {error, Reason} ->
            io:format("Error compiling regex: ~p~n", [Reason]),
            []
    end.

% 링크를 기반으로 크롤링
crawl(URL, Depth) when Depth > 0 ->
    io:format("Crawling ~s~n", [URL]),
    Body = fetch_url(URL),
    %% Handle empty or invalid body
    case Body of
        <<>> -> 
            io:format("Failed to fetch or empty body for URL ~s~n", [URL]);
        _ ->
            Links = extract_links(Body),
            %% 병렬로 각 링크를 크롤링
            [spawn(fun() -> crawl(Link, Depth - 1) end) || Link <- Links]
    end;
crawl(_, _) ->
    done.

% 크롤러 시작
start(URL) ->
    ssl:start(), % ssl 앱 실행
    Depth = 2, % 크롤링 깊이 설정
    spawn(fun() -> crawl(URL, Depth) end).
