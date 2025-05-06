.data
msg1:   .asciz  "Nhap so nguyen duong N (64-bit): "
msg2:   .asciz  "Tong cac chu so nhi phan cua N la: "
msg3:   .asciz  "So N khong hop le!"
buf:    .space  64

.text
.globl main
main:
        li      a7, 8          # syscall: read string
        la      a0, buf
        li      a1, 64
        ecall

        la      t0, buf        # t0 = addr(buf)
        li      t1, 32         # t1 = length of each half

        li      t6, 48         # t6 = ASCII '0'
        li      a2, 10         # a2 = 10 for multiply

        # parse high 32 chars
        li      t2, 0          # t2 = value_high
        li      t3, 0          # t3 = index
parse_high_part:
        lb      t4, 0(t0)
        beq     t4, zero, end_parse_high
        sub     t4, t4, t6     # t4 = t4 - '0'
        mul     t2, t2, a2     # t2 *= 10
        add     t2, t2, t4
        addi    t0, t0, 1
        addi    t3, t3, 1
        blt     t3, t1, parse_high_part
end_parse_high:

        # parse low 32 chars
        li      t3, 0          # reset index
        li      t4, 0          # t4 = value_low
parse_low_part:
        lb      t5, 0(t0)
        beq     t5, zero, end_parse_low
        sub     t5, t5, t6     # t5 = t5 - '0'
        mul     t4, t4, a2     # t4 *= 10
        add     t4, t4, t5
        addi    t0, t0, 1
        addi    t3, t3, 1
        blt     t3, t1, parse_low_part
end_parse_low:

        mv      s1, t2         # s1 = high part
        mv      s0, t4         # s0 = low part

        # popcount on 64-bit split (s1||s0)
        li      t0, 0          # t0 = total count
        li      t1, 2          # t1 = divisor 2

while_low:
        beq     s0, zero, while_high
        rem     t2, s0, t1     # t2 = s0 % 2
        add     t0, t0, t2
        div     s0, s0, t1     # s0 /= 2
        j       while_low

while_high:
        beq     s1, zero, print
        rem     t2, s1, t1     # t2 = s1 % 2
        add     t0, t0, t2
        div     s1, s1, t1     # s1 /= 2
        j       while_high

print:
        li      a7, 4
        la      a0, msg2
        ecall
        li      a7, 1
        mv      a0, t0
        ecall
        j       end

print_error:
        li      a7, 4
        la      a0, msg3
        ecall

end:
        li      a7, 10
        ecall
