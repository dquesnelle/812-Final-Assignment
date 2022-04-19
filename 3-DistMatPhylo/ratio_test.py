import sys

def ratio_test(src, dist, ratio=0.6):
    data = []
    with open(src, "r", encoding="utf-8") as fasta:
        buffer = fasta.readline()
        while buffer:
            if buffer.count("-") > len(buffer) * ratio:
                print(buffer)
                data.pop()
            else:
                data.append(buffer)
            buffer = fasta.readline()
    with open(dist, "w", encoding="utf-8") as fasta:
        fasta.writelines(data)

ratio_test(sys.argv[1], sys.argv[2])
