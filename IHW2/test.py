import numpy as np

# Функция проверки через определитель с использованием numpy
def check_points_numpy(points):
    # Создание матрицы
    matrix = [
        [x, y, x**2 + y**2, 1] for x, y in points
    ]
    # Вычисление определителя
    det = np.linalg.det(matrix)
    # Проверка условия
    return abs(det) < 0.01 #точность такая же как и в ассемблере, можно увидеть, что программа в ассемблере считает с очень схожей точностью

# Функция проверки через формулу
def check_points_formula(points):
    x1, y1 = points[0]
    x2, y2 = points[1]
    x3, y3 = points[2]
    x4, y4 = points[3]

    result = (
        x2**2 * (x4 * (y3 - y1) + x3 * (y1 - y4) + x1 * (y4 - y3))
        + x2 * (
            x3**2 * (y4 - y1)
            + x4**2 * (y1 - y3)
            + (y3 - y4) * (x1**2 + (y1 - y3) * (y1 - y4))
        )
        + (y2 - y3)
        * (
            -x1 * (x4**2 + (y2 - y4) * (y3 - y4))
            + x4 * (y1 - y2) * (y1 - y3)
            + x4 * x1**2
        )
        + x3**2 * (x4 * (y1 - y2) + x1 * (y2 - y4))
        + x3
        * (
            x4**2 * (y2 - y1)
            - (y2 - y4) * (x1**2 + (y1 - y2) * (y1 - y4))
        )
    )

    # Проверка условия
    return abs(result) < 0.01 #точность такая же как и в ассемблере, можно увидеть, что программа в ассемблере считает с очень схожей точностью

# Тестовые случаи
test_cases = [
    {
        "points": [(28, -12), (32, -8), (36, -12), (32, -16)],
        "expected": True,
        "description": "Test case 1: Points belong to the same circle"
    },
    {
        "points": [(1, 2), (0, 1), (1, 0), (-1, 0)],
        "expected": False,
        "description": "Test case 2: Points don't belong to the same circle"
    },
    {
        "points": [(0, 3.47723), (6.19615, 0), (1, -7.56776), (-4.19615, 0)],
        "expected": True,
        "description": "Test case 3: Points belong to the same circle"
    },
    {
        "points": [(0, 3.47723), (6.19615, 0), (1, -7.6), (-4.19615, 0)],
        "expected": False,
        "description": "Test case 4: Points don't belong to the same circle"
    },
    {
        "points": [(0, 0), (0, 0), (0, 0), (0, 0)],
        "expected": True,
        "description": "Test case 5: Points belong to the same circle"
    }
]

# Проверка тестов
for test in test_cases:
    print(f"{test['description']}:")
    points = test["points"]
    expected = test["expected"]

    # Проверка через numpy
    result_numpy = check_points_numpy(points)
    print(f"  Using numpy: {'PASSED' if result_numpy == expected else 'FAILED'}")

    # Проверка через формулу
    result_formula = check_points_formula(points)
    print(f"  Using formula: {'PASSED' if result_formula == expected else 'FAILED'}")