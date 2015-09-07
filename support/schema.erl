%% @doc Functions that help with manage_schema data fixtures.
-module(schema).

-include_lib("zotonic.hrl").

-export([
    file/2,
    reset/1,
    create_identity_if_not_exists/4]
).

%% @doc Locate file in fixtures directory
-spec file(string(), #context{}) -> string().
file(Filename, Context) ->
    filename:join([z_path:site_dir(Context), "files/fixtures/", Filename]).

%% @doc Compile and reset database schema
-spec reset(#context{}) -> ok.
reset(Site) when is_atom(Site) ->
    Context = z_context:new(Site),
    reset(Context);
reset(Context) when is_record(Context, context) ->
    z:m(),
    z_module_manager:reinstall(z_context:site(Context), Context).

%% Set username and password if not set before
-spec create_identity_if_not_exists(atom(), string(), string(), #context{}) -> ok.
create_identity_if_not_exists(Name, Username, Password, Context) ->
    Resource = m_rsc:rid(Name, Context),
    case m_identity:get(Resource, Context) of
        undefined ->
            m_identity:set_username_pw(Resource, Username, Password, Context);
        _ ->
            ok
    end.
