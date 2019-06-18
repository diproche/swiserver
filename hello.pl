:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_parameters)).
:- use_module(library(http/http_client)).

:- use_module(diproche8).

:- http_handler(root(dipr), reply, []).



server(Port) :-
        http_server(http_dispatch, [port(Port)]).

reply(Request) :-
        member(method(post), Request), !,
        http_read_data(Request, ProposedProof, []),
        diproche_fo(ProposedProof, DiprocheReturn),
        format('Content-type: text/plain~n~n', []),
        format(DiprocheReturn).

