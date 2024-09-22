# Заготовленные строки
.data
prompt_dividend: .asciz "Enter the dividend: "
prompt_divisor: .asciz "Enter the divisor:  "
error_divide_by_zero: .asciz "Error: division by zero. \n"
result_quotient: .asciz "Quotient: "
result_remainder: .asciz " Remainder: "

.text
main:
    # Ввод делимого
    li      a7, 4                      # Печать строки
    la      a0, prompt_dividend         # Адрес строки
    ecall                            # Печать
    li      a7, 5                      # Ввод целого числа
    ecall                            # Ввод делимого
    mv    t0, a0                     # Сохранение делимого

    # Ввод делителя
    li      a7, 4                      # Печать строки
    la      a0, prompt_divisor          # Адрес строки
    ecall                            # Печать
    li      a7, 5                      # Ввод целого числа
    ecall                            # Ввод делителя
    mv    t1, a0                     # Сохранение делителя

    # Проверка деления на ноль
    beqz   t1, divide_by_zero    # Если делитель == 0, перейти к ошибке
  

    # Логика деления
    li      t2, 0                      # Инициализация частного в 0
    bltz t0, dividend_less_zero
    bgtz t1, division_loop_both_greater_zero
    j    division_loop_divisor_less_zero
   dividend_less_zero:
     bgtz t1, division_loop_dividend_less_zero
     j  division_loop_both_less_zero
         

division_loop_both_greater_zero:
    blt     t0, t1, division_done       # Если делимое <  делителя , выйти
    sub     t0, t0, t1                  # Вычесть делитель из делимого
    addi    t2, t2, 1                   # Увеличить частное

    j         division_loop_both_greater_zero            # Повторить цикл

division_loop_both_less_zero:
    bgt     t0, t1, division_done       # Если делимое >  делителя , выйти
    sub     t0, t0, t1                  # Вычесть делитель из делимого
    addi    t2, t2, 1                   # Увеличить частное

    j         division_loop_both_less_zero            # Повторить цикл

division_loop_dividend_less_zero:
    bgtz     t0, step_back       # Если делимое > 0 , выйти
    add     t0, t0, t1                  # Прибавить делитель к делимому(т.к идем в обратном порядке)
    addi    t2, t2, -1                   # Уменьшить частное (т.к мы идем в обратную сторону)

    j         division_loop_dividend_less_zero              # Повторить цикл

division_loop_divisor_less_zero:
    bltz     t0, step_back       # Если делимое > 0 , выйти
    add     t0, t0, t1                  # Прибавить делитель к делимому(т.к идем в обратном порядке)
    addi    t2, t2, -1                   # Уменьшить частное (т.к мы идем в обратную сторону)

    j    division_loop_divisor_less_zero           # Повторить цикл

step_back: #Сделать шаг назад, чтобы получить корректное значение остатка
  sub t0,  t0, t1
   addi    t2, t2, 1
  j  division_done

division_done:
    # Вывод результата
    li      a7, 4                      # Печать строки
    la      a0, result_quotient         # Адрес строки "Частное"
    ecall                            # Печать
    mv    a0, t2                     # Частное в a0
    li      a7, 1                      # Печать целого числа
    ecall                            # Печать частного

    li      a7, 4                      # Печать строки
    la      a0, result_remainder        # Адрес строки "Остаток"
    ecall                            # Печать
    mv    a0, t0                     # Остаток в a0
    li      a7, 1                      # Печать целого числа
    ecall                            # Печать остатка

    j       exit

divide_by_zero:
    li      a7, 4                      # Печать строки
    la      a0, error_divide_by_zero    # Адрес строки "Ошибка"
    ecall                            # Печать
    j       exit

exit:
    li      a7, 10                     # Завершение программы
    ecall
