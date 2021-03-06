"""Basic views with no home"""
from pyramid.httpexceptions import HTTPFound
from pyramid.httpexceptions import HTTPNotFound
from pyramid.view import view_config

from bookie.models.auth import UserMgr


@view_config(route_name="home")
@view_config(route_name="user_home")
def home(request):
    """Inital / view for now until we find a better one"""
    rdict = request.matchdict
    username = rdict.get('username', None)

    if not username:
        return HTTPFound(location=request.route_url("bmark_recent"))
    else:
        # we need to see if we have a user by this name
        user = UserMgr.get(username=username)

        if not user:
            return HTTPNotFound()
        else:
            return HTTPFound(location=request.route_url("user_bmark_recent",
                                                        username=username))
