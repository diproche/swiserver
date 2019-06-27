:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_parameters)).
:- use_module(library(http/http_client)).

:- use_module(diproche8).

:- http_handler(root(dipr), reply, []).



server(Port) :-
        http_server(http_dispatch, [port(Port)]).

reply(Request) :-
        http_read_data(Request, ProposedProof, []),
        member(method(post), Request), !,
        bagof(DiprocheReturn, diproche_fo(ProposedProof, DiprocheReturn), Returns),
		write('List of Lists with unverified Input: '), write(Returns).

