from io import StringIO
from itertools import chain
import numpy as np
import galois

GF2 = galois.GF(2)
GF256 = galois.GF(2**8, irreducible_poly=np.array([1, 0, 0, 0, 1, 1, 0, 1, 1]))

print(GF2.properties)
print(GF256.properties)

def compute_srd(byte):
    aff_translate = GF2(np.array([0, 1, 1, 0, 0, 0, 1, 1]))
    aff_linear = GF2(np.array([     \
        [1, 1, 1, 1, 1, 0, 0, 0],   \
        [0, 1, 1, 1, 1, 1, 0, 0],   \
        [0, 0, 1, 1, 1, 1, 1, 0],   \
        [0, 0, 0, 1, 1, 1, 1, 1],   \
        [1, 0, 0, 0, 1, 1, 1, 1],   \
        [1, 1, 0, 0, 0, 1, 1, 1],   \
        [1, 1, 1, 0, 0, 0, 1, 1],   \
        [1, 1, 1, 1, 0, 0, 0, 1],   \
    ]))

    inv8 = GF256(byte) ** 254

    inv8_vector_GF2 = GF2(np.unpackbits(np.uint8(inv8)))
    srd_vector_GF2 = (aff_linear @ inv8_vector_GF2) + aff_translate

    return np.packbits(np.array(srd_vector_GF2))[0]

def compute_srd_inv(byte):
    affinv_translate = GF2(np.array([0, 0, 0, 0, 0, 1, 0, 1]))
    affinv_linear = GF2(np.array([  \
        [0, 1, 0, 1, 0, 0, 1, 0],   \
        [0, 0, 1, 0, 1, 0, 0, 1],   \
        [1, 0, 0, 1, 0, 1, 0, 0],   \
        [0, 1, 0, 0, 1, 0, 1, 0],   \
        [0, 0, 1, 0, 0, 1, 0, 1],   \
        [1, 0, 0, 1, 0, 0, 1, 0],   \
        [0, 1, 0, 0, 1, 0, 0, 1],   \
        [1, 0, 1, 0, 0, 1, 0, 0],   \
    ]))

    byte_GF2 = GF2(np.unpackbits(np.uint8(byte)))
    affinv_vector_GF2 = (affinv_linear @ byte_GF2) + affinv_translate
    affinv = np.packbits(np.array(affinv_vector_GF2))

    srdinv = np.uint8(GF256(affinv) ** 254)[0]
    return srdinv

def compute_t_table_elts(byte):
    tx1 = np.uint8(GF256(1) * GF256(compute_srd(byte)))
    tx2 = np.uint8(GF256(2) * GF256(compute_srd(byte)))
    tx3 = np.uint8(GF256(3) * GF256(compute_srd(byte)))

    t0 = tx2 | (tx1 << 8) | (tx1 << 16) | (tx3 << 24)
    t1 = tx3 | (tx2 << 8) | (tx1 << 16) | (tx1 << 24)
    t2 = tx1 | (tx3 << 8) | (tx2 << 16) | (tx1 << 24)
    t3 = tx1 | (tx1 << 8) | (tx3 << 16) | (tx2 << 24)

    return [t0, t1, t2, t3]

def compute_t_inv_table_elts(byte):
    txE = np.uint8(GF256(0xE) * GF256(compute_srd_inv(byte)))
    tx9 = np.uint8(GF256(0x9) * GF256(compute_srd_inv(byte)))
    txD = np.uint8(GF256(0xD) * GF256(compute_srd_inv(byte)))
    txB = np.uint8(GF256(0xB) * GF256(compute_srd_inv(byte)))

    t0 = txE | (tx9 << 8) | (txD << 16) | (txB << 24)
    t1 = txB | (txE << 8) | (tx9 << 16) | (txD << 24)
    t2 = txD | (txB << 8) | (txE << 16) | (tx9 << 24)
    t3 = tx9 | (txD << 8) | (txB << 16) | (txE << 24)

    return [t0, t1, t2, t3]

def compute_round_constants():
    RC = np.zeros(16, dtype=np.uint8)
    RC[0] = np.uint8(0)
    RC[1] = np.uint8(1)
    for i in range(2, 16):
        RC[i] = np.uint8(GF256(2) * GF256(RC[i - 1]))

    return RC

def construct_aes_tables():
    rc_str = StringIO()
    fsbox_str, rsbox_str = StringIO(), StringIO()
    ftbls_str = [StringIO(), StringIO(), StringIO(), StringIO()]
    rtbls_str = [StringIO(), StringIO(), StringIO(), StringIO()]

    # Round constants
    for i, val in enumerate(compute_round_constants()):
        if i % 8 == 0:
            rc_str.write('\n    ')
        else:
            rc_str.write(' ')

        rc_str.write(f'0x{val:08X}UL,')

    # Other tables
    for i in range(0, 256):
        fsrdb = compute_srd(i)
        isrdb = compute_srd_inv(i)
        ftbl_elts = compute_t_table_elts(i)
        rtbl_elts = compute_t_inv_table_elts(i)

        if i % 16 == 0:
            fsbox_str.write('\n    ')
            rsbox_str.write('\n    ')
        else:
            fsbox_str.write(' ')
            rsbox_str.write(' ')

        for tbl_str in chain(ftbls_str, rtbls_str):
            if i % 8 == 0:
                tbl_str.write('\n    ')
            else:
                tbl_str.write(' ')

        fsbox_str.write(f'0x{fsrdb:02X}U,')
        rsbox_str.write(f'0x{isrdb:02X}U,')

        for val, str in zip(chain(ftbl_elts, rtbl_elts), chain(ftbls_str, rtbls_str)):
            str.write(f'0x{val:08X}UL,')

    return (rc_str.getvalue(),                          \
        fsbox_str.getvalue(), rsbox_str.getvalue(),     \
        list(map(lambda x: x.getvalue(), ftbls_str)),   \
        list(map(lambda x: x.getvalue(), rtbls_str))    \
    )

rc_str, fsbox_str, rsbox_str, ftbls_str, rtbls_str = construct_aes_tables()
with open('aes_tables_script_out.c', 'w') as fhdl:
    # Helper function
    write_table = (lambda typ, name, cont, length=256: (
        fhdl.write(f'const {typ} {name}[{length}UL] = {{'),
        fhdl.write(cont),
        fhdl.write('\n};\n\n')
    ))

    # Round constants
    write_table('uint32_t', 'AES_RCS', rc_str, 16)

    # FWD and reverse S-Tables
    write_table('uint8_t', 'AES_FSBOX', fsbox_str)
    write_table('uint8_t', 'AES_RSBOX', rsbox_str)

    # FWD T-Tables
    write_table('uint32_t', 'AES_FTTBL0', ftbls_str[0])
    write_table('uint32_t', 'AES_FTTBL1', ftbls_str[1])
    write_table('uint32_t', 'AES_FTTBL2', ftbls_str[2])
    write_table('uint32_t', 'AES_FTTBL3', ftbls_str[3])

    # Reverse T-Tables
    write_table('uint32_t', 'AES_RTTBL0', rtbls_str[0])
    write_table('uint32_t', 'AES_RTTBL1', rtbls_str[1])
    write_table('uint32_t', 'AES_RTTBL2', rtbls_str[2])
    write_table('uint32_t', 'AES_RTTBL3', rtbls_str[3])
