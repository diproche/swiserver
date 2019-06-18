:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_parameters)).

:- http_handler(root(hallo), say_hi, []).		% (1)

server(Port) :-						% (2)
        http_server(http_dispatch, [port(Port)]).

say_hi(Request) :-					% (3)
        http_parameters(Request,
        [ name(Name, [])]),
        format('Content-type: text/plain~n~n'),
        format(Name).
