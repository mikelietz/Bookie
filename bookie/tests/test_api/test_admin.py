"""Test that we're meeting delicious API specifications"""
import logging
import json
import transaction
import unittest
import urllib
from nose.tools import ok_, eq_
from pyramid import testing

from bookie.models import DBSession
from bookie.tests import BOOKIE_TEST_INI
from bookie.tests import empty_db

LOG = logging.getLogger(__name__)


class AdminApiTest(unittest.TestCase):
    """Test the bookie admin api calls."""
    _api_key = None

    @property
    def api_key(self):
        """Cache the api key for all calls."""
        if not self._api_key:
            res = DBSession.execute(
                "SELECT api_key FROM users WHERE username = 'admin'").fetchone()
            self._api_key = res['api_key']
        return self._api_key

    def setUp(self):
        from pyramid.paster import get_app
        app = get_app(BOOKIE_TEST_INI, 'main')
        from webtest import TestApp
        self.testapp = TestApp(app)
        testing.setUp()

    def tearDown(self):
        """We need to empty the bmarks table on each run"""
        testing.tearDown()
        empty_db()

    def test_list_inactive_users(self):
        """Test that we can fetch the inactive users."""
        # for now just make sure we can get a 200 call on it.
        params = {
            'api_key': self.api_key
        }
        res = self.testapp.get('/api/v1/a/accounts/inactive',
                                params=params,
                                status=200)
        # by default we shouldn't have any inactive users
        data = json.loads(res.body)
        users = [u for u in data['users']]
        for u in users:
            eq_(0, u['invite_ct'], "Count should be 0 to start.")

    def test_invite_ct(self):
        """Test we can call and get the invite counts."""
        # for now just make sure we can get a 200 call on it.
        params = {
            'api_key': self.api_key
        }
        res = self.testapp.get('/api/v1/a/accounts/invites',
                                params=params,
                                status=200)
        # we should get back tuples of username/count
        data = json.loads(res.body)['users']
        found = False
        invite_count = None
        for user, count in data:
            if user == u'admin':
                found = True
                invite_count = count

        ok_(found, "There should be the admin user." + res.body)
        eq_(0, invite_count, "The admin user shouldn't have any invites." + res.body)

    def test_set_invite_ct(self):
        """Test we can set the invite count for the user"""
        # for now just make sure we can get a 200 call on it.
        params = {
            'api_key': self.api_key
        }
        res = self.testapp.post('/api/v1/a/accounts/invites/admin/10',
                                params=params,
                                status=200)
        # we should get back tuples of username/count
        data = json.loads(res.body)
        eq_('admin', data.get('username'), "The admin user data is returned to us." + res.body)
        eq_(10, int(data.get('invite_ct')), "The admin user now has 10 invites." + res.body)

        # and of course when we're done we need to unset it back to 0 or else
        # the test above blows up...sigh.
        res = self.testapp.post('/api/v1/a/accounts/invites/admin/0',
                                params=params,
                                status=200)
