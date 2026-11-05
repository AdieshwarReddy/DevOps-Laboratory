
# Experiment 6: Automated Unit Tests

import unittest
from app import add


class TestApplication(unittest.TestCase):

    def test_addition(self):
        self.assertEqual(add(10, 20), 30)

    def test_negative_numbers(self):
        self.assertEqual(add(-5, 3), -2)

    def test_zero(self):
        self.assertEqual(add(0, 0), 0)

    def test_large_numbers(self):
        self.assertEqual(add(1000, 2000), 3000)


if __name__ == "__main__":
    unittest.main()
