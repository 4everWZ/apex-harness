import unittest
from ranker import choose
class RankerTests(unittest.TestCase):
    def test_order(self):
        items = [{"score": 1, "name": "b"}, {"score": 2, "name": "z"}, {"score": 1, "name": "a"}]
        self.assertEqual(choose(items, 2), [items[1], items[2]])
    def test_empty(self):
        self.assertEqual(choose([], 3), [])
