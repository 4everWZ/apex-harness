import unittest

from order import describe_order


class OrderTests(unittest.TestCase):
    def test_order(self):
        self.assertEqual(describe_order(["b", "a", "A"]), ["A", "a", "b"])
