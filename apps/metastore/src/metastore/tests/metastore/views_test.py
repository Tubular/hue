from unittest import TestCase
from collections import namedtuple
from time import time
import calendar
from datetime import datetime

from metastore.views import _get_table_health_status


class TestViews(TestCase):

    maxDiff = None
    table_cls = namedtuple('Table', ['details'])

    def test_warehouse_health(self):
        now = datetime(2017, 7, 1, 10, 5)
        now_ts = calendar.timegm(now.utctimetuple())
        table = self.table_cls(details={
            'stats': {
                'cron_schedule': '0 10 * * *',
                'transient_lastDdlTime': str(now_ts),
            },
        })

        table_status = _get_table_health_status(table, at_time=now)

        del table_status['last_update_expected']
        del table_status['next_update_expected']

        self.assertEqual(
            table_status,
            {'last_update': now_ts,
             'last_update_ago': {'days': 0, 'hours': 0},
             'last_update_expected_ago': {'days': 0, 'hours': 6},
             'next_update_expected_ago': {'days': 0, 'hours': 17},
             'status': 'healthy'},
        )

        table = self.table_cls(details={
            'stats': {
                'cron_schedule': '0 10 * * *',
                'transient_lastDdlTime': str(now_ts - 20 * 60 * 60),
            },
        })

        table_status = _get_table_health_status(table, at_time=now)

        del table_status['last_update_expected']
        del table_status['next_update_expected']

        self.assertEqual(
            table_status,
            {'last_update': now_ts - 20 * 60 * 60,
             'last_update_ago': {'days': 0, 'hours': 20},
             'last_update_expected_ago': {'days': 0, 'hours': 6},
             'next_update_expected_ago': {'days': 0, 'hours': 17},
             'status': 'unhealthy'},
        )
