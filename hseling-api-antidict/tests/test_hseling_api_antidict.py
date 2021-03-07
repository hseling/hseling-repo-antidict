import unittest

import hseling_api_antidict


class HSELing_API_AntidictTestCase(unittest.TestCase):

    def setUp(self):
        self.app = hseling_api_antidict.app.test_client()

    def test_index(self):
        rv = self.app.get('/healthz')
        self.assertIn('Application Antidict', rv.data.decode())


if __name__ == '__main__':
    unittest.main()
