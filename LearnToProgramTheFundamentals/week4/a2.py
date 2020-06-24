def get_length(dna):
    """ (str) -> int

    Return the length of the DNA sequence dna.

    >>> get_length('ATCGAT')
    6
    >>> get_length('ATCG')
    4
    """
    return len(dna)


def is_longer(dna1, dna2):
    """ (str, str) -> bool

    Return True if and only if DNA sequence dna1 is longer than DNA sequence
    dna2.

    >>> is_longer('ATCG', 'AT')
    True
    >>> is_longer('ATCG', 'ATCGGA')
    False
    """
    if len(dna1) > len(dna2):
        return True
    else:
        return False


def count_nucleotides(dna, nucleotide):
    """ (str, str) -> int

    Return the number of occurrences of nucleotide in the DNA sequence dna.

    >>> count_nucleotides('ATCGGC', 'G')
    2
    >>> count_nucleotides('ATCTA', 'G')
    0
    """
    return dna.count(nucleotide)


def contains_sequence(dna1, dna2):
    """ (str, str) -> bool

    Return True if and only if DNA sequence dna2 occurs in the DNA sequence
    dna1.

    >>> contains_sequence('ATCGGC', 'GG')
    True
    >>> contains_sequence('ATCGGC', 'GT')
    False

    """
    if dna2 in dna1:
        return True
    else:
        return False
    
def is_valid_sequence(s):
    """

    Returns
    -------
    None.

    """
    for c in s:
        if c.islower():
            return False
        elif c not in 'AGCT' :
            return False
    return True

def insert_sequence(d1, d2, n):
    return d1[0:n] + d2 + d1[n:]
    
def get_complement(c):
    if c == 'A':
        return 'T'
    elif c == 'T':
        return 'A'
    elif c == 'G':
        return 'C'
    elif c == 'C':
        return 'G'
    
def get_complementary_sequence(s):
    ns = ''
    for c in s:
        ns = ns + get_complement(c)
    return ns