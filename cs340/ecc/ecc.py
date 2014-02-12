import math

class Point(object):
    def __init__(self, x=0, y=0):
        self.x = float(x)
        self.y = float(y)

    def __str__(self):
        return str(self.x) + "," + str(self.y)

class EllipticCurve(object):

    def __init__(self, a, b):
        """ 
        Takes in b and c to define the curve y^2 = x^3 + ax + b
        """
        self.a = float(a)
        self.b = float(b)

    def add(self, point1, point2):
        """
        Given two points, uses the proper equation to add them together
        and find the new point on the curve
        """
        if point1.x != point2.x: 
            return self.regular_add(point1, point2)
        elif point1.y != point2.y: 
            # point is at infinity
            return None
        elif point1.y != 0:
            # they are the same point and y is not 0
            return self.double_point(point1)
        else:
            return None

    def regular_add(self, point1, point2):
        """
        Returns the addition of the two points
        """
        # lambda
        lam = (point2.y - point1.y) / (point2.x - point1.x)

        point3 = Point()

        # calculate x
        point3.x = lam**2 - point1.x - point2.x
        # calculate y
        point3.y = lam * (point1.x - point3.x) - point1.y

        return point3

    def double_point(self, point):
        """
        Given P, returns 2P
        """
        # lambda
        lam = (3 * point.x**2 + self.a) / (2 * point.y)

        result_point = Point()

        # calculate x
        result_point.x = lam**2 - (2 * point.x)

        #calculate y
        result_point.y = lam * (point.x - result_point.x) - point.y

        return result_point

    def integer_point(self, x):
        """
        Returns the point if it is an integer point, otherwise returns none
        """
        y_squared = float(x)**3 + self.a + self.b

        y = math.sqrt(y_squared)

        if self.is_integer(y) and self.is_integer(x):
            return Point( int(x), int(y) )
        else:
            return None

    def is_integer(self, num):
        return abs( num - int(num) ) < (1.0 / 1000000)
        
