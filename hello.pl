:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_parameters)).
:- use_module(library(http/http_client)).
:- use_module(diproche8).

:- http_handler(root(hallo), say_hi, []).		% (1)
:- http_handler(root(dipr), reply, []).		% (1)

server(Port) :-						% (2)
        http_server(http_dispatch, [port(Port)]).


transform(R) :-
        atom_string(R, "[hallo]").


reply(Request) :-
        member(method(post), Request), !,
        http_read_data(Request, Data, to(atom)),
        term_to_atom(Data, Proof),
        diproche_fo(Proof, R),
        format('Content-type: text/plain~n~n', []),
        format(R).
        % format(Data).

% [[es,seien,a,und,b,aussagen],[wir,zeigen,[[a,and,b],<->,[b,and,a]]],[=>],[angenommen,[a,and,b]],[dann,a],[ferner,gilt,b],[damit,folgt,[b,and,a]],[qed],[abs],[<=],[nehmen,wir,jetzt,an,dass,[b,and,a]],[dann,folgt,a],[ausserdem,folgt,b],[also,gilt,nun,[a,and,b]],[qed],[damit,gilt,[[a,and,b],<->,[b,and,a]]]]
say_hi(Request) :-					% (3)
        http_parameters(Request,
        [ name(Name, [])]),
        format('Content-type: text/plain~n~n'),
         format(Name).
