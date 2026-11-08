import unittest
from parser import parse_limit

class AcceptedContract(unittest.TestCase):
    def test_default(self):
        self.assertEqual(parse_limit(), 30)
    def test_bounds(self):
        self.assertEqual(parse_limit(5), 5)
        self.assertEqual(parse_limit(120), 120)
    def test_invalid(self):
        for value in (4, 121, True, "30", 30.0):
            with self.subTest(value=value):
                with self.assertRaises(ValueError):
                    parse_limit(value)

if __name__ == "__main__":
    unittest.main()
